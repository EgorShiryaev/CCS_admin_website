import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../classes/data_type.dart';

class CubitConstructor<Type> extends Cubit<CubitState> {
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
      List<QueryDocumentSnapshot<Object?>> docs = await collectionRef.get().then((value) => value.docs);
      emit(Loaded<Type>(data: docs.map((e) => e.data() as Type).toList()));
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

class CubitState {}

class Empty extends CubitState {}

class Loading extends CubitState {}

class Loaded<Type> extends CubitState {
  final List<Type> data;

  Loaded({required this.data});
}

class Error extends CubitState {
  final String message;

  Error({required this.message});
}
