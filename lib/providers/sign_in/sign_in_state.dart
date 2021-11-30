import 'package:admin_website/classes/user.dart';

class SignInState {}

class Empty extends SignInState{}

class Loading extends SignInState {}

class Loaded extends SignInState {
  final User user;

  Loaded({required this.user});
}

class Error extends SignInState {
  final String message;

  Error({required this.message});
}
