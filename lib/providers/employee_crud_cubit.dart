import 'package:admin_website/providers/crud_cubit_constructor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../_config/firebase_config.dart';
import '../classes/employee.dart';

class EmployeesCRUDCubit extends CRUD_CubitConstructor<Employee> {
  EmployeesCRUDCubit()
      : super(
          collectionRef: FirebaseFirestore.instance.collection(DefaultFirebaseConfig.employees).withConverter<Employee>(
                fromFirestore: (snapshot, _) => Employee.fromJson(snapshot.data()!),
                toFirestore: (user, _) => user.toJson(),
              ),
        );
}
