import 'package:admin_website/classes/employee.dart';

class SignInState {}

class SignOut extends SignInState{}

class Loading extends SignInState {}

class SignIn extends SignInState {
  final Employee user;

  SignIn({required this.user});
}

class Error extends SignInState {
  final String message;

  Error({required this.message});
}
