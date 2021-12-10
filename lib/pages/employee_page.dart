import 'package:admin_website/classes/employee.dart';
import 'package:admin_website/providers/crud_cubit_constructor.dart';
import 'package:admin_website/widgets/state_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../providers/employee_crud_cubit.dart';
import '../widgets/employee_page/body_employee_page.dart';

class EmployeePage extends StatelessWidget {
  const EmployeePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<EmployeesCRUDCubit, StateCubit>(builder: (context, state) {
        if (state is Loading) {
          return StateBuilder.loading();
        }
        if (state is Error) {
          return StateBuilder.error(state.message);
        }
        if (state is Loaded) {
          List<Employee> data = state.data as List<Employee>;
          return BodyEmployeePage(employees: data);
        }
        return StateBuilder.error('Неизвестный state');
      }),
    );
  }
}
