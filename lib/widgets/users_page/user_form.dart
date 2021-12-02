import 'dart:developer';

import 'package:admin_website/classes/user.dart';
import 'package:flutter/material.dart';

class UserForm extends StatelessWidget {
  final TextEditingController loginController;
  final TextEditingController passController;
  final TextEditingController nameController;
  final Role role;
  final Function setRole;

  UserForm({
    Key? key,
    required this.loginController,
    required this.passController,
    required this.nameController,
    required this.role,
    required this.setRole,
  }) : super(key: key);

  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formGlobalKey,
      child: SizedBox(
        child: Column(
          children: [
            Container(
              width: 300,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                controller: loginController,
                style: LocalStyles.textFieldStyle,
                cursorColor: LocalStyles.inputColor,
                decoration: LocalStyles.buildInputDecoration('Login'),
                validator: (value) => _emptyValidator(value ?? ''),
              ),
            ),
            Container(
              width: 300,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                controller: passController,
                style: LocalStyles.textFieldStyle,
                cursorColor: LocalStyles.inputColor,
                decoration: LocalStyles.buildInputDecoration('Password'),
                validator: (value) => _emptyValidator(value ?? ''),
              ),
            ),
            Container(
              width: 300,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                controller: nameController,
                style: LocalStyles.textFieldStyle,
                cursorColor: LocalStyles.inputColor,
                decoration: LocalStyles.buildInputDecoration('Name'),
                validator: (value) => _emptyValidator(value ?? ''),
              ),
            ),
            
            SizedBox(
              width: 300,
              child: DropdownButton<Role>(
                value: role,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                alignment: AlignmentDirectional.center,
                icon: const Icon(Icons.arrow_downward_sharp),
                underline: Container(
                  height: 1,
                  color: LocalStyles.focusColor,
                ),
                onChanged: (value) => setRole(value),
                items: Role.values.map<DropdownMenuItem<Role>>((Role role) {
                  return DropdownMenuItem<Role>(
                    value: role,
                    child: SizedBox(
                      width: 276,
                      child: Center(
                        child: Text(role.name),
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  _emptyValidator(String value) {
    return value.isEmpty ? 'Введите данные' : null;
  }
}

class LocalStyles {
  static const inputColor = Colors.white;
  static const focusColor = Colors.grey;
  static const headerTextStyle = TextStyle(fontSize: 16, color: inputColor);
  static const textFieldStyle = TextStyle(color: inputColor);

  static buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      hintStyle: const TextStyle(color: focusColor),
      // Unfocused
      labelStyle: const TextStyle(color: focusColor),
      border: const OutlineInputBorder(borderSide: BorderSide(color: focusColor)),
      // Focused
      floatingLabelStyle: const TextStyle(color: focusColor),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: focusColor)),
    );
  }
}