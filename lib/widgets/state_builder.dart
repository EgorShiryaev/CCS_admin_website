import 'package:flutter/material.dart';

class StateBuilder {
  static loading() => const Center(child: CircularProgressIndicator(color: progressIndicatorColor));
  static const progressIndicatorColor = Colors.blue;
  static error(String error) => Center(
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: errorMessageDecoration,
          child: Text(error, style: messageTextStyle),
        ),
      );
  static const errorMessageDecoration = BoxDecoration(
    color: errorColor,
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );
  static const errorColor = Colors.red;
  static const messageTextStyle = TextStyle(fontSize: 20, color: messageTextColor);
  static const messageTextColor = Colors.white;
}
