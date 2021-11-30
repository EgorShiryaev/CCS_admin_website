import 'package:admin_website/widgets/sign_in_widget.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Welcome to Admin console Cinema Control System', style: Styles.header),
                Text('Please enter your login and password', style: Styles.header2),
                SizedBox(height: 50),
                SizedBox(width: 300, child: SignInWidget()),
                SizedBox(height: 300)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Styles {
  static const header = TextStyle(fontSize: 34, color: Colors.white);
  static const header2 = TextStyle(fontSize: 26, color: Colors.white);
}
