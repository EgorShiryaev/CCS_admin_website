import 'package:admin_website/pages/sign_in_page.dart';
import 'package:flutter/material.dart';

class AdminWebsite extends StatefulWidget {
  const AdminWebsite({Key? key}) : super(key: key);

  @override
  State<AdminWebsite> createState() => _AdminWebsiteState();
}

class _AdminWebsiteState extends State<AdminWebsite> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin website',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/SignIn',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/SignIn':
            return MaterialPageRoute(builder: (_) => const SignInPage());
          default:
            return null;
        }
      },
    );
  }
}
