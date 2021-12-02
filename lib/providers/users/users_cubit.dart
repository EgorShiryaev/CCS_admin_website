import 'dart:convert';
import 'dart:developer';
import 'package:admin_website/providers/users/users_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto/crypto.dart';
import '../../classes/user.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(Empty());

  final usersRef = FirebaseFirestore.instance.collection('users').withConverter<User>(
        fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  create(User user) async {
    emit(Loading());
    try {
      await usersRef.doc(user.login).set(_hashingPassword(user));
      log('User Added');
    } catch (e) {
      log('Failed to add user: $e');
      emit(Error(message: e.toString()));
    }
    read();
  }

  read() async {
    emit(Loading());
    try {
      List<QueryDocumentSnapshot<User>> userDocuments = await usersRef.get().then((value) => value.docs);
      emit(Loaded(users: userDocuments.map((e) => e.data()).toList()));
    } catch (e) {
      emit(Error(message: e.toString()));
    }
  }

  update(User user, bool savePassword) async {
    emit(Loading());
    try {
      await usersRef.doc(user.login).set(savePassword ? user : _hashingPassword(user));
      log('User Updated');
    } catch (e) {
      log('Failed to update user: $e');
      emit(Error(message: e.toString()));
    }
    read();
  }

  delete(String documentId) async {
    emit(Loading());
    try {
      await usersRef.doc(documentId).delete();
      log('User Deleted');
    } catch (e) {
      log('Failed to delete user: $e');
      emit(Error(message: e.toString()));
    }
    read();
  }

  _hashingPassword(User user) {
    var bytes = utf8.encode(user.password);
    var digest = sha256.convert(bytes);

    return user = User(
      login: user.login,
      password: digest.toString(),
      name: user.name,
      role: user.role,
    );
  }
}
