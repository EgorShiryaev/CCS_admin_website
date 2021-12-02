import 'package:admin_website/classes/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersState {}

class Empty extends UsersState{}

class Loading extends UsersState {}

class Loaded extends UsersState {
  final List<User> users;

  Loaded({required this.users});
}

class Error extends UsersState {
  final String message;

  Error({required this.message});
}
