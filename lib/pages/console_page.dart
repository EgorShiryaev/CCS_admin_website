import 'package:admin_website/classes/user.dart';
import 'package:admin_website/widgets/console_page/body_console_page.dart';
import 'package:flutter/material.dart';

class ConsolePage extends StatelessWidget {
  final User user;
  const ConsolePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyConsolePage(user: user),
    );
  }
}