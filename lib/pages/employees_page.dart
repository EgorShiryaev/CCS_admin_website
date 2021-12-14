import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../_config/firebase_config.dart';
import '../classes/employee.dart';
import '../providers/cubit_constructor.dart';
import '../providers/employees_cubit.dart';
import '../widgets/employees_page/body_employee_page.dart';
import '../widgets/main_menu_page/body_main_menu_page.dart';
import '../widgets/state_builder.dart';

class EmployeesPage extends StatelessWidget {
  EmployeesPage({Key? key}) : super(key: key);

  final Stream<DocumentSnapshot<Data>> _employeeRolesStream = FirebaseFirestore.instance
      .collection(DefaultFirebaseConfig.employeesRoles)
      .withConverter(
        fromFirestore: (snapshot, _) => Data.fromJson(snapshot.data()!, DefaultFirebaseConfig.employeesRoles),
        toFirestore: (data, _) => {},
      )
      .doc(DefaultFirebaseConfig.employeesRoles)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EmployeesCubit>(context).read();
    return Scaffold(body: _streamBuilder());
  }

  _streamBuilder() {
    return StreamBuilder<DocumentSnapshot<Data>>(
      stream: _employeeRolesStream,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Data>> snapshot) {
        if (snapshot.hasError) {
          return StateBuilder.error(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return StateBuilder.loading();
        }
        List dataDynamic = snapshot.data!.get(DefaultFirebaseConfig.employeesRoles);
        List<String> roles = dataDynamic.map((e) => e.toString()).toList();
        return _blocBuilder(roles);
      },
    );
  }

  _blocBuilder(List<String> roles) {
    return BlocBuilder<EmployeesCubit, CubitState>(
      builder: (context, state) {
        if (state is Loading) {
          return StateBuilder.loading();
        }
        if (state is Error) {
          return StateBuilder.error(state.message);
        }
        if (state is Loaded) {
          List<Employee> data = state.data as List<Employee>;
          return BodyEmployeePage(employees: data, roles: roles);
        }
        return StateBuilder.error('Неизвестный state');
      },
    );
  }
}
