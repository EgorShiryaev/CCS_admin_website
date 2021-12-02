import 'package:admin_website/classes/exception.dart';
import 'package:admin_website/classes/user.dart';
import 'package:admin_website/providers/sign_in/sign_in_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(Empty());

  final usersRef = FirebaseFirestore.instance.collection('users').withConverter<User>(
        fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  void signIn(String login, String password) async {
    emit(Loading());

    try {
      List<QueryDocumentSnapshot<User>> userDocuments = await usersRef.get().then((value) => value.docs);
      for (var userDoc in userDocuments) {
        var user = userDoc.data();
        if (user.login == login && user.password == password) {
          emit(Loaded(user: user));
          return;
        }
      }
      emit(Error(message: ExceptionConvert.toTextError(Exceptions.userNotFound)));
      return;
    } catch (e) {
      emit(Error(message: e.toString()));
      return;
    }
  }

  void resignIn() {
    emit(Empty());
  }
}
