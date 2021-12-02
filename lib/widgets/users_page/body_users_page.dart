import 'package:admin_website/classes/user.dart';
import 'package:admin_website/widgets/body_constructor.dart';
import 'package:admin_website/widgets/users_page/table_users.dart';
import 'package:admin_website/widgets/users_page/user_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../providers/users/users_cubit.dart';

class BodyUsersPage extends StatefulWidget {
  final List<User> users;
  BodyUsersPage({
    Key? key,
    required this.users,
  }) : super(key: key);

  final TextEditingController loginController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  State<BodyUsersPage> createState() => _BodyUsersPageState();
}

class _BodyUsersPageState extends State<BodyUsersPage> {
  User? selectUser = null;
  setSelectedUser(User? e) {
    setState(() => selectUser = e);
    widget.loginController.text = selectUser != null ? selectUser!.login : '';
    widget.passController.text = selectUser != null ? selectUser!.password : '';
    widget.nameController.text = selectUser != null ? selectUser!.name : '';
    selectRole = selectUser != null ? selectUser!.role : Role.admin;
  }

  Role selectRole = Role.admin;
  setSelectRol(Role role) => setState(() => selectRole = role);

  @override
  Widget build(BuildContext context) {
    Widget form = UserForm(
      loginController: widget.loginController,
      passController: widget.passController,
      nameController: widget.nameController,
      role: selectRole,
      setRole: setSelectRol,
    );
    Widget table = TableUsers(
      users: widget.users,
      setSelectedUser: setSelectedUser,
      selectUser: selectUser,
    );
    return BodyConstructor(
      form: form,
      table: table,
      add: _addUser,
      update: _updateUser,
      delete: _deleteUser, isSelect: selectUser != null,
    );
  }

  _addUser() {
    User user = User(
      login: widget.loginController.text,
      password: widget.passController.text,
      name: widget.nameController.text,
      role: selectRole,
    );
    BlocProvider.of<UsersCubit>(context).create(user);
    setState(() => selectUser = null);
  }

  _updateUser() {
    User user = User(
      login: widget.loginController.text,
      password: widget.passController.text,
      name: widget.nameController.text,
      role: selectRole,
    );
    BlocProvider.of<UsersCubit>(context).update(selectUser!.login, user);
    setState(() => selectUser = null);
  }

  _deleteUser() {
    BlocProvider.of<UsersCubit>(context).delete(selectUser!.login);
    setState(() => selectUser = null);
  }
}

class LocalStyles {
  static const header2 = TextStyle(fontSize: 32, color: inputColor);
  static const inputColor = Colors.grey;
  static final buttonStyle = OutlinedButton.styleFrom(
    side: const BorderSide(width: 1, color: inputColor),
    padding: const EdgeInsets.all(10),
    primary: inputColor,
  );
  static const buttonTextStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
  );
}
