import 'dart:convert';
import 'package:admin_website/classes/employee.dart';
import 'package:admin_website/widgets/_constructors/body_constructor.dart';
import 'package:admin_website/widgets/_constructors/table_constructor.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../providers/employees_cubit.dart';
import 'employee_form.dart';

class BodyEmployeePage extends StatefulWidget {
  final List<Employee> employees;
  final List<String> roles;
  BodyEmployeePage({
    Key? key,
    required this.employees,
    required this.roles,
  }) : super(key: key);

  final loginController = TextEditingController();
  final passController = TextEditingController();
  final surnameController = TextEditingController();
  final nameController = TextEditingController();
  final globalKey = GlobalKey<FormState>();

  @override
  State<BodyEmployeePage> createState() => _BodyEmployeePageState();
}

class _BodyEmployeePageState extends State<BodyEmployeePage> {
  Employee? selectedUser;

  setSelectedUser(Employee? e) {
    setState(() => selectedUser = e);
    widget.loginController.text = selectedUser != null ? selectedUser!.login : '';
    widget.passController.text = '';
    widget.surnameController.text = selectedUser != null ? selectedUser!.surname : '';
    widget.nameController.text = selectedUser != null ? selectedUser!.name : '';
    selectedRole = selectedUser != null ? selectedUser!.role : widget.roles.last;
  }

  String selectedRole = '';
  setSelectedRole(String role) => setState(() => selectedRole = role);

  @override
  void initState() {
    selectedRole = widget.roles.last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget form = EmployeeForm(
      loginController: widget.loginController,
      passController: widget.passController,
      nameController: widget.nameController,
      surnameController: widget.surnameController,
      role: selectedRole,
      setRole: setSelectedRole,
      loginValidator: _loginValidator,
      passValidator: _passwordValidator,
      nameValidator: _nameValidator,
      surnameValidator: _surnameValidator,
      formGlobalKey: widget.globalKey,
      isSelectedEmployeeIsNotNull: selectedUser != null,
      roles: widget.roles,
    );

    Widget table = TableConstructor(
      data: widget.employees,
      setSelectedData: setSelectedUser,
      selectData: selectedUser,
    );

    return BodyConstructor(
      form: form,
      table: table,
      add: _create,
      update: _update,
      delete: _delete,
      isSelect: selectedUser != null,
    );
  }

  _loginValidator(String value) {
    for (var user in widget.employees) {
      if (user.login == value) {
        return 'Этот логин занят';
      }
    }
    return _emptyValidator(value);
  }

  _passwordValidator(String value) {
    if (selectedUser == null || value.isNotEmpty) {
      if (value.length < 8) {
        return 'Пароль должен быть 8 или больше символов';
      }
      if (value.length > 30) {
        return 'Пароль должен быть 30 или меньше символов';
      }
      return null;
    }
  }

  _nameValidator(String value) {
    if (value.contains(' ')) {
      return 'Имя не может содержать пробел';
    }
    return _emptyValidator(value);
  }

  _surnameValidator(String value) {
    if (value.contains(' ')) {
      return 'Фамилия не может содержать пробел';
    }
    return _emptyValidator(value);
  }

  _emptyValidator(String value) {
    return value.isEmpty ? 'Введите данные' : null;
  }

  _create() {
    if (widget.globalKey.currentState!.validate()) {
      final employee = _createEmployee();
      BlocProvider.of<EmployeesCubit>(context).create(employee);
      setSelectedUser(null);
    }
  }

  _update() {
    if (_passwordValidator(widget.passController.text) == null) {
      final user = _createEmployee();
      BlocProvider.of<EmployeesCubit>(context).update(user);
      setSelectedUser(null);
    } else {
      widget.globalKey.currentState!.validate();
    }
  }

  _delete() {
    BlocProvider.of<EmployeesCubit>(context).delete(selectedUser!.id);
    setSelectedUser(null);
  }

  _createEmployee() {
    return Employee(
      login: widget.loginController.text,
      password:
          widget.passController.text.isEmpty ? selectedUser!.password : hashingPassword(widget.passController.text),
      name: widget.nameController.text,
      surname: widget.surnameController.text,
      role: selectedRole,
    );
  }

  String hashingPassword(String password) => sha256.convert(utf8.encode(password)).toString();
}
