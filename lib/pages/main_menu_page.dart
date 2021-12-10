import 'package:admin_website/classes/employee.dart';
import 'package:admin_website/widgets/main_menu_page/body_main_menu_page.dart';
import 'package:flutter/material.dart';

class ConsolePage extends StatelessWidget {
  final Employee user;
  const ConsolePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyMainMenuPage(user: user),
    );
  }
}
