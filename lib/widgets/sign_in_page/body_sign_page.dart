import 'package:flutter/material.dart';

import 'sign_in_form.dart';

class BodySignPage extends StatelessWidget {
  final TextEditingController loginController;
  final TextEditingController passController;
  const BodySignPage({
    Key? key,
    required this.loginController,
    required this.passController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          flex: 2,
          child: SizedBox(),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Welcome to Cinema Control System', style: LocalStyles.header1),
              SizedBox(height: 5),
              Text('Please enter your login and password', style: LocalStyles.header2),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: SignInForm(
            loginController: loginController,
            passController: passController,
          ),
        ),
        const Expanded(
          flex: 2,
          child: SizedBox(),
        ),
      ],
    );
  }
}

class LocalStyles {
  static const color = Colors.grey;
  static const header1 = TextStyle(fontSize: 36, color: color);
  static const header2 = TextStyle(fontSize: 28, color: color);
}
