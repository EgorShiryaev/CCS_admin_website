import 'package:flutter/material.dart';

import '../widgets/users_page/body_users_page.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BodyUsersPage(),
    );
  }
}
