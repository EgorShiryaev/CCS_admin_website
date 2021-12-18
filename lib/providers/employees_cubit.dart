import 'package:admin_website/providers/cubit_constructor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../_config/firebase_config.dart';
import '../classes/employee.dart';

class EmployeesCubit extends CubitConstructor<Employee> {
  EmployeesCubit()
      : super(
          collectionRef: FirebaseFirestore.instance.collection(FirebaseConfig.employees).withConverter<Employee>(
                fromFirestore: (snapshot, _) => Employee.fromJson(snapshot.data()!),
                toFirestore: (user, _) => user.toJson(),
              ),
        );
}
