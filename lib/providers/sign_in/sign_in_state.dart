import 'package:admin_website/classes/user.dart';

class SignInState {}

class SignOut extends SignInState{}

class Loading extends SignInState {}

class SignIn extends SignInState {
  final User user;

  SignIn({required this.user});
}

class Error extends SignInState {
  final String message;

  Error({required this.message});
}
