import 'package:admin_website/pages/films_page.dart';
import 'package:admin_website/pages/main_menu_page.dart';
import 'package:admin_website/pages/reports_page.dart';
import 'package:admin_website/pages/sessions_page.dart';
import 'package:admin_website/pages/sign_in_page.dart';
import 'package:admin_website/pages/employees_page.dart';
import 'package:admin_website/providers/films_cubit.dart';
import 'package:admin_website/providers/sessions_cubit.dart';
import 'package:admin_website/providers/sign_in/sign_in_cubit.dart';
import 'package:admin_website/providers/employees_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'classes/employee.dart';

class AdminWebsite extends StatelessWidget {
  const AdminWebsite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignInCubit>(create: (context) => SignInCubit()),
        BlocProvider<EmployeesCubit>(create: (context) => EmployeesCubit()),
        BlocProvider<FilmsCubit>(create: (context) => FilmsCubit()),
        BlocProvider<SessionsCubit>(create: (context) => SessionsCubit()),
      ],
      child: MaterialApp(
        title: 'Admin website',
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/reports',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/signIn':
              return MaterialPageRoute(builder: (_) => const SignInPage());
            case '/mainMenu':
              // Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
              final user = Employee(login: 'login', password: 'password', name: 'name', role: 'role');
              return MaterialPageRoute(builder: (_) => MainMenuPage(user: user));
            case '/employees':
              return MaterialPageRoute(builder: (_) => EmployeesPage());
            case '/films':
              return MaterialPageRoute(builder: (_) => FilmsPage());
            case '/sessions':
              return MaterialPageRoute(builder: (_) => SessionsPage());
            case '/reports':
              return MaterialPageRoute(builder: (_) => const ReportsPage());
            default:
              return null;
          }
        },
      ),
    );
  }
}

class ScreenArguments {
  final Employee user;

  ScreenArguments({required this.user});
}
