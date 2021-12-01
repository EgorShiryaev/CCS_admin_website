import 'package:admin_website/widgets/sign_in_page/popup_sign_page.dart';
import 'package:flutter/material.dart';
import '../widgets/sign_in_page/body_sign_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          BodySignPage(),
          PopupSignPage(),
        ],
      ),
    );
  }
}
