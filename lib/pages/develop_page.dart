import 'package:admin_website/classes/user.dart';
import 'package:admin_website/widgets/console_page/body_console_page.dart';
import 'package:flutter/material.dart';

import '../widgets/users_page/body_users_page.dart';

class DevelopPage extends StatelessWidget {
  const DevelopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BodyUsersPage(),
    );
  }
}
