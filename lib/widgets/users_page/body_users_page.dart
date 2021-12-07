import 'dart:convert';

import 'package:admin_website/classes/user.dart';
import 'package:admin_website/providers/cubit_constructor.dart';
import 'package:admin_website/widgets/_constructors/body_constructor.dart';
import 'package:admin_website/widgets/_constructors/table_constructor.dart';
import 'package:admin_website/widgets/users_page/user_form.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../providers/users_cubit.dart';

class BodyUsersPage extends StatefulWidget {
  final List<User> users;
  BodyUsersPage({
    Key? key,
    required this.users,
  }) : super(key: key);

  final loginController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();

  final globalKey = GlobalKey<FormState>();

  @override
  State<BodyUsersPage> createState() => _BodyUsersPageState();
}

class _BodyUsersPageState extends State<BodyUsersPage> {
  User? selectUser;
  setSelectedUser(User? e) {
    setState(() => selectUser = e);
    widget.loginController.text = selectUser != null ? selectUser!.login : '';
    widget.passController.text = '';
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
      loginValidator: loginValidator,
      passValidator: passwordValidator,
      nameValidator: emptyValidator,
      formGlobalKey: widget.globalKey,
      isSelectedUserIsNotNull: selectUser != null,
    );
    Widget table = TableConstructor(
      datas: widget.users,
      setSelectedData: setSelectedUser,
      selectData: selectUser,
    );
    return BodyConstructor(
      form: form,
      table: table,
      add: _createUser,
      update: _updateUser,
      delete: _deleteUser,
      isSelect: selectUser != null,
    );
  }

  loginValidator(String value) {
    for (var user in widget.users) {
      if (user.login == value) {
        return 'Этот логин занят';
      }
    }
    return emptyValidator(value);
  }

  passwordValidator(String value) {
    if (selectUser == null || value.isNotEmpty) {
      if (value.length < 8) {
        return 'Пароль должен быть 8 или больше символов';
      }
      if (value.length > 30) {
        return 'Пароль должен быть 30 или меньше символов';
      }
      return null;
    }
  }

  emptyValidator(String value) {
    return value.isEmpty ? 'Введите данные' : null;
  }

  _createUser() {
    if (widget.globalKey.currentState!.validate()) {
      User user = User(
        login: widget.loginController.text,
        password: widget.passController.text,
        name: widget.nameController.text,
        role: selectRole,
      );
      BlocProvider.of<CubitConstructor>(context).create(user);
      setState(() => selectUser = null);
    }
  }

  _updateUser() {
    if (passwordValidator(widget.passController.text) == null) {
      User user = User(
        login: widget.loginController.text,
        password:
            widget.passController.text.isEmpty ? selectUser!.password : hashingPassword(widget.passController.text),
        name: widget.nameController.text,
        role: selectRole,
      );
      BlocProvider.of<UsersCubit>(context).update(user);
      setState(() => selectUser = null);
    } else {
      widget.globalKey.currentState!.validate();
    }
  }

  _deleteUser() {
    BlocProvider.of<UsersCubit>(context).delete(selectUser!.id);
    setState(() => selectUser = null);
  }

  String hashingPassword(String password) => sha256.convert(utf8.encode(password)).toString();
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
