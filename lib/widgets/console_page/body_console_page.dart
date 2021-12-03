import 'package:flutter/material.dart';

import '../../classes/user.dart';

class BodyConsolePage extends StatelessWidget {
  final User user;
  BodyConsolePage({Key? key, required this.user}) : super(key: key);

  final buttons = [
    Button(title: 'Пользователи', url: '/users'),
    Button(title: 'Фильмы', url: '/'),
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
            .toList(),
      ),
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
