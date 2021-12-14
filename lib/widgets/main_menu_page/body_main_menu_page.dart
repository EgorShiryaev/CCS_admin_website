import 'package:flutter/material.dart';
import '../../classes/employee.dart';

class BodyMainMenuPage extends StatefulWidget {
  final Employee user;
  const BodyMainMenuPage({Key? key, required this.user}) : super(key: key);

  @override
  State<BodyMainMenuPage> createState() => _BodyMainMenuPageState();
}

class _BodyMainMenuPageState extends State<BodyMainMenuPage> {
  final buttons = [
    Button(title: 'Сотрудники', url: '/employees'),
    Button(title: 'Фильмы', url: '/films'),
    Button(title: 'Сеансы', url: '/'),
    Button(title: 'Создать отчёт', url: '/'),
    Button(title: 'Выйти', url: 'back'),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: buttons
              .map((e) => Container(
                    width: 450,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: OutlinedButton(
                      style: LocalStyles.buttonStyle,
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Text(
                          e.title,
                          style: LocalStyles.buttonTextStyle,
                        ),
                      ),
                      onPressed: () {
                        if (e.url == 'back') {
                          Navigator.pop(context);
                        } else {
                          Navigator.pushNamed(context, e.url);
                        }
                      },
                    ),
                  ))
              .toList()),
    );
  }
}

class LocalStyles {
  static const inputColor = Colors.grey;
  static final buttonStyle = OutlinedButton.styleFrom(
    side: const BorderSide(width: 1, color: inputColor),
    padding: const EdgeInsets.all(10),
    primary: inputColor,
  );
  static const buttonTextStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
  );
}

class Button {
  final String title;
  final String url;

  Button({
    required this.title,
    required this.url,
  });
}

class Data {
  final List<String> data;

  Data({required this.data});

  factory Data.fromJson(Map<String, dynamic> json, String fieldName) {
    return Data(data: json[fieldName]);
  }
}
