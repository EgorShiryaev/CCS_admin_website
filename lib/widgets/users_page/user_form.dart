import 'package:admin_website/classes/user.dart';
import 'package:flutter/material.dart';

class UserForm extends StatelessWidget {
  final TextEditingController loginController;
  final TextEditingController passController;
  final TextEditingController nameController;
  final Function loginValidator;
  final Function passValidator;
  final Function nameValidator;
  final Role role;
  final Function setRole;
  final GlobalKey<FormState> formGlobalKey;
  final bool isSelectedUserIsNotNull;

  const UserForm({
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
    required this.isSelectedUserIsNotNull,
  }) : super(key: key);

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
                readOnly: isSelectedUserIsNotNull,
                controller: loginController,
                style: isSelectedUserIsNotNull ? LocalStyles.activeTextFieldStyle : LocalStyles.inactiveTextFieldStyle,
                cursorColor: LocalStyles.inputColor,
                decoration: LocalStyles.buildInputDecoration('Login'),
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
                decoration: LocalStyles.buildInputDecoration('Password'),
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
                decoration: LocalStyles.buildInputDecoration('Name'),
                validator: (value) => nameValidator(value),
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
}

class LocalStyles {
  static const inputColor = Colors.white;
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
