import 'package:admin_website/pages/console_page.dart';
import 'package:admin_website/pages/sign_in_page.dart';
import 'package:admin_website/providers/sign_in/sign_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'classes/user.dart';

class AdminWebsite extends StatelessWidget {
  const AdminWebsite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignInCubit>(create: (context) => SignInCubit()),
      ],
      child: MaterialApp(
        title: 'Admin website',
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/signIn',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/signIn':
              return MaterialPageRoute(builder: (_) => const SignInPage());
            case '/console':
              Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(builder: (_) => ConsolePage(user: arguments['user']));
            default:
              return null;
          }
        },
      ),
    );
  }
}

class ScreenArguments {
  final User user;

  ScreenArguments({required this.user});
}
