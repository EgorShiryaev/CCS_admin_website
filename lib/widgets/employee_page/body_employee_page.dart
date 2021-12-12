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
  final nameController = TextEditingController();

  final globalKey = GlobalKey<FormState>();

  @override
  State<BodyEmployeePage> createState() => _BodyEmployeePageState();
}

class _BodyEmployeePageState extends State<BodyEmployeePage> {
  Employee? selectUser;
  setSelectUser(Employee? e) {
    setState(() => selectUser = e);
    widget.loginController.text = selectUser != null ? selectUser!.login : '';
    widget.passController.text = '';
    widget.nameController.text = selectUser != null ? selectUser!.name : '';
    selectRole = selectUser != null ? selectUser!.role : widget.roles.last;
  }

  String selectRole = '';
  setSelectRol(String role) => setState(() => selectRole = role);

  @override
  void initState() {
    selectRole = widget.roles.last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget form = EmployeeForm(
      loginController: widget.loginController,
      passController: widget.passController,
      nameController: widget.nameController,
      role: selectRole,
      setRole: setSelectRol,
      loginValidator: _loginValidator,
      passValidator: _passwordValidator,
      nameValidator: _emptyValidator,
      formGlobalKey: widget.globalKey,
      isSelectedEmployeeIsNotNull: selectUser != null,
      roles: widget.roles,
    );
    Widget table = TableConstructor(
      datas: widget.employees,
      setSelectedData: setSelectUser,
      selectData: selectUser,
    );
    return BodyConstructor(
      form: form,
      table: table,
      add: _create,
      update: _update,
      delete: _delete,
      isSelect: selectUser != null,
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

  _emptyValidator(String value) {
    return value.isEmpty ? 'Введите данные' : null;
  }

  _create() {
    if (widget.globalKey.currentState!.validate()) {
      final employee = _createEmployee();
      BlocProvider.of<EmployeesCubit>(context).create(employee);
      setSelectUser(null);
    }
  }

  _update() {
    if (_passwordValidator(widget.passController.text) == null) {
      final user = _createEmployee();
      BlocProvider.of<EmployeesCubit>(context).update(user);
      setSelectUser(null);
    } else {
      widget.globalKey.currentState!.validate();
    }
  }

  _delete() {
    BlocProvider.of<EmployeesCubit>(context).delete(selectUser!.id);
    setSelectUser(null);
  }

  _createEmployee() {
    return Employee(
      login: widget.loginController.text,
      password: widget.passController.text.isEmpty ? selectUser!.password : hashingPassword(widget.passController.text),
      name: widget.nameController.text,
      role: selectRole,
    );
  }

  String hashingPassword(String password) => sha256.convert(utf8.encode(password)).toString();
}
