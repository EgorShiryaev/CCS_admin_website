import 'package:admin_website/classes/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../classes/data_type.dart';

class CubitConstructor extends Cubit<StateCubit> {
  final CollectionReference collectionRef;

  CubitConstructor({
    required this.collectionRef,
  }) : super(Empty());

  create(DataType entity) async {
    emit(Loading());
    try {
      await collectionRef.doc(entity.id).set(entity);
      read();
    } catch (e) {
      emit(Error(message: e.toString()));
    }
  }

  read() async {
    emit(Loading());
    try {
      List<QueryDocumentSnapshot<User>> docs =
          await collectionRef.get().then((value) => value.docs as List<QueryDocumentSnapshot<User>>);
      emit(Loaded(data: docs.map((e) => e.data()).toList()));
    } catch (e) {
      emit(Error(message: e.toString()));
    }
  }

  update(DataType entity) async {
    emit(Loading());
    try {
      await collectionRef.doc(entity.id).set(entity);
      read();
    } catch (e) {
      emit(Error(message: e.toString()));
    }
  }

  delete(String documentId) async {
    emit(Loading());
    try {
      await collectionRef.doc(documentId).delete();
      read();
    } catch (e) {
      emit(Error(message: e.toString()));
    }
  }
}

class StateCubit {}

class Empty extends StateCubit {}

class Loading extends StateCubit {}

class Loaded extends StateCubit {
  final List data;

  Loaded({required this.data});
}

class Error extends StateCubit {
  final String message;

  Error({required this.message});
}
