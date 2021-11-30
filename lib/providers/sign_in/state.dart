class SignInState {}

class Loading extends SignInState {}

class Loaded extends SignInState {
  final bool isSignIn;

  Loaded({required this.isSignIn});
}

class Error extends SignInState {
  final String message;

  Error({required this.message});
}
