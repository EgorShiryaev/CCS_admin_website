import 'package:flutter/material.dart';
import '../../classes/employee.dart';

class BodyMainMenuPage extends StatelessWidget {
  final Employee employee;
  BodyMainMenuPage({Key? key, required this.employee}) : super(key: key);

  final cinemaManagerButtons = [
    Button(title: 'Сотрудники', url: '/employees'),
    Button(title: 'Фильмы', url: '/films'),
    Button(title: 'Сеансы', url: '/sessions'),
    Button(title: 'Выйти', url: 'back'),
  ];

  final bookkeeperButtons = [
    Button(title: 'Создать отчёт', url: '/reports'),
    Button(title: 'Выйти', url: 'back'),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: employee.role == 'Управляющий кинотеатра'
            ? cinemaManagerButtons.map((e) => _buttonConstructor(e, context)).toList()
            : employee.role == 'Бухгалтер'
                ? bookkeeperButtons.map((e) => _buttonConstructor(e, context)).toList()
                : [],
      ),
    );
  }

  Widget _buttonConstructor(Button e, context) {
    return Container(
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
