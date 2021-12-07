import 'dart:developer';
import 'package:admin_website/providers/sign_in/sign_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../providers/users_cubit.dart';

class SignInForm extends StatefulWidget {
  final TextEditingController loginController;
  final TextEditingController passController;
  const SignInForm({
    Key? key,
    required this.loginController,
    required this.passController,
  }) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool passwordIsUnvisible = true;
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: Form(
          key: formGlobalKey,
          child: Column(
            children: [
              TextFormField(
                controller: widget.loginController,
                style: LocalStyles.textFieldStyle,
                cursorColor: LocalStyles.inputColor,
                decoration: LocalStyles.loginInputDecoration,
                validator: (value) => _emptyValidator(value ?? ''),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: widget.passController,
                style: LocalStyles.textFieldStyle,
                obscureText: passwordIsUnvisible,
                cursorColor: LocalStyles.inputColor,
                decoration: LocalStyles.createPasswordInputDecoration(
                  unvisibility: passwordIsUnvisible,
                  tapIconFunction: _changePasswordIsUnvisible,
                ),
                validator: (value) => _emptyValidator(value ?? ''),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                style: LocalStyles.buttonStyle,
                onPressed: _signIn,
                child: const SizedBox(
                  width: 300,
                  child: Center(
                    child: Text('Sign in', style: LocalStyles.header2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _signIn() {
    log('Login: ${widget.loginController.text}');
    log('Password: ${widget.passController.text}');
    if (formGlobalKey.currentState!.validate()) {
      BlocProvider.of<SignInCubit>(context).signIn(widget.loginController.text, widget.passController.text);
      BlocProvider.of<UsersCubit>(context).read();
    }
  }

  _changePasswordIsUnvisible() {
    setState(() {
      passwordIsUnvisible = !passwordIsUnvisible;
    });
  }

  _emptyValidator(String value) {
    return value.isEmpty ? 'Введите данные' : null;
  }
}

class LocalStyles {
  static const inputColor = Colors.grey;
  static const textFieldStyle = TextStyle(color: inputColor);
  static const header2 = TextStyle(fontSize: 32, color: inputColor);
  static const loginInputDecoration = InputDecoration(
    labelText: 'Login',
    hintStyle: TextStyle(color: inputColor),
    // Unfocused
    labelStyle: TextStyle(color: inputColor),
    border: OutlineInputBorder(borderSide: BorderSide(color: inputColor)),
    // Focused
    floatingLabelStyle: TextStyle(color: inputColor),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: inputColor)),
  );

  static createPasswordInputDecoration({required unvisibility, required tapIconFunction}) {
    return InputDecoration(
      labelText: 'Password',
      // Unfocused
      labelStyle: const TextStyle(color: inputColor),
      border: const OutlineInputBorder(borderSide: BorderSide(color: inputColor)),
      // Focused
      floatingLabelStyle: const TextStyle(color: inputColor),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: inputColor)),
      suffixIcon: IconButton(
        icon: Icon(
          unvisibility ? Icons.visibility : Icons.visibility_off,
          color: inputColor,
        ),
        onPressed: tapIconFunction,
      ),
    );
  }

  static final buttonStyle = OutlinedButton.styleFrom(
    side: const BorderSide(width: 1, color: inputColor),
    padding: const EdgeInsets.all(10),
    primary: inputColor,
  );
}
