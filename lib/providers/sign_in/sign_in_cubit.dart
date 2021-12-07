import 'dart:convert';
import 'package:admin_website/_config/firebase_config.dart';
import 'package:admin_website/classes/exception.dart';
import 'package:admin_website/classes/user.dart';
import 'package:admin_website/providers/sign_in/sign_in_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignOut());

  final usersRef = FirebaseFirestore.instance.collection(DefaultFirebaseConfig.users).withConverter<User>(
        fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  void signIn(String login, String password) async {
    emit(Loading());
    try {
      User? user = await usersRef.doc(login).get().then((value) => value.data());
      if (user != null && user.login == login && user.password == _hashingPassword(password)) {
        emit(SignIn(user: user));
        return;
      }
      emit(Error(message: ExceptionConvert.toTextError(Exceptions.userNotFound)));
    } catch (e) {
      emit(Error(message: e.toString()));
    }
  }

  _hashingPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  void resignIn() {
    emit(SignOut());
  }
}
