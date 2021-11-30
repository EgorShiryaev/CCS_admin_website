import 'dart:developer';

import 'package:flutter/material.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({Key? key}) : super(key: key);

  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool passwordIsUnvisible = true;

  changePasswordIsUnvisible() {
    setState(() {
      passwordIsUnvisible = !passwordIsUnvisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: loginController,
          cursorColor: Styles.inputFocusColor,
          decoration: Styles.loginInputDecoration,
        ),
        const SizedBox(height: 10),
        TextField(
          controller: passController,
          obscureText: passwordIsUnvisible,
          cursorColor: Styles.inputFocusColor,
          decoration: Styles.createPasswordInputDecoration(
            unvisibility: passwordIsUnvisible,
            tapIconFunction: changePasswordIsUnvisible,
          ),
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          onPressed: _signIn,
          child: const SizedBox(
            width: 300,
            child: Center(
              child: Text(
                'Sign in',
                style: Styles.header2,
              ),
            ),
          ),
        )
      ],
    );
  }

  _signIn() {
    log('Login: ${loginController.text}');
    log('Password: ${passController.text}');
  }
}

class Styles {
  static const header2 = TextStyle(fontSize: 32, color: Colors.white);

  static const inputFocusColor = Colors.white;
  static const inputColor = Colors.grey;

  static const loginInputDecoration = InputDecoration(
    labelText: 'Login',
    // Unfocused
    labelStyle: TextStyle(color: inputColor),
    border: OutlineInputBorder(borderSide: BorderSide(color: inputColor)),
    // Focused
    floatingLabelStyle: TextStyle(color: inputFocusColor),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
  );

  static createPasswordInputDecoration({required unvisibility, required tapIconFunction}) {
    return InputDecoration(
      labelText: 'Password',
      // Unfocused
      labelStyle: TextStyle(color: inputColor),
      border: OutlineInputBorder(borderSide: BorderSide(color: inputColor)),
      // Focused
      floatingLabelStyle: TextStyle(color: inputFocusColor),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      suffixIcon: IconButton(
        icon: Icon(
          unvisibility ? Icons.visibility : Icons.visibility_off,
          color: inputFocusColor,
        ),
        onPressed: tapIconFunction,
      ),
    );
  }
}