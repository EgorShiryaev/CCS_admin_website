import 'package:flutter/material.dart';

class EmployeeForm extends StatelessWidget {
  final GlobalKey<FormState> formGlobalKey;
  final TextEditingController loginController;
  final TextEditingController passController;
  final TextEditingController nameController;
  final Function loginValidator;
  final Function passValidator;
  final Function nameValidator;
  final String role;
  final Function setRole;
  final bool isSelectedEmployeeIsNotNull;
  final List<String> roles;

  const EmployeeForm({
    Key? key,
    required this.loginController,
    required this.passController,
    required this.nameController,
    required this.loginValidator,
    required this.passValidator,
    required this.nameValidator,
    required this.role,
    required this.setRole,
    required this.formGlobalKey,
    required this.isSelectedEmployeeIsNotNull,
    required this.roles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formGlobalKey,
      child: Column(
        children: [
          Container(
            width: 300,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              readOnly: isSelectedEmployeeIsNotNull,
              controller: loginController,
              style:
                  isSelectedEmployeeIsNotNull ? LocalStyles.activeTextFieldStyle : LocalStyles.inactiveTextFieldStyle,
              cursorColor: LocalStyles.inputColor,
              decoration: LocalStyles.buildInputDecoration('Логин'),
              validator: (value) => loginValidator(value),
            ),
          ),
          Container(
            width: 300,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              controller: passController,
              style: LocalStyles.inactiveTextFieldStyle,
              cursorColor: LocalStyles.inputColor,
              decoration: LocalStyles.buildInputDecoration('Пароль'),
              validator: (value) => passValidator(value),
            ),
          ),
          Container(
            width: 300,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              controller: nameController,
              style: LocalStyles.inactiveTextFieldStyle,
              cursorColor: LocalStyles.inputColor,
              decoration: LocalStyles.buildInputDecoration('ФИО'),
              validator: (value) => nameValidator(value),
            ),
          ),
          SizedBox(
            width: 300,
            child: DropdownButton<String>(
              value: role,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              alignment: AlignmentDirectional.center,
              icon: const Icon(Icons.arrow_downward_sharp),
              underline: Container(
                height: 1,
                color: LocalStyles.focusColor,
              ),
              onChanged: (value) => setRole(value),
              items: roles.map<DropdownMenuItem<String>>((String role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: SizedBox(
                    width: 276,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(role, style:LocalStyles.headerTextStyle),
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

class LocalStyles {
  static const inputColor = Colors.grey;
  static const focusColor = Colors.grey;
  static const headerTextStyle = TextStyle(fontSize: 16, color: inputColor);
  static const inactiveTextFieldStyle = TextStyle(color: inputColor);
  static const activeTextFieldStyle = TextStyle(color: focusColor);

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
