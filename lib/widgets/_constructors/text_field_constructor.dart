import 'package:flutter/material.dart';

class TextFieldConstructor extends StatelessWidget {
  final int maxLines;
  final TextEditingController controller;
  final String label;
  final Function validator;

  const TextFieldConstructor({
    Key? key,
    this.maxLines = 1,
    required this.controller,
    required this.label,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextFormField(
        maxLines: maxLines,
        controller: controller,
        style: LocalStyles.inactiveTextFieldStyle,
        cursorColor: LocalStyles.inputColor,
        decoration: LocalStyles.buildInputDecoration(label),
        validator: (value) => validator(value),
      ),
    );
  }
}

class LocalStyles {
  static const inputColor = Colors.white;
  static const focusColor = Colors.grey;
  static const headerTextStyle = TextStyle(fontSize: 16, color: inputColor);
  static const inactiveTextFieldStyle = TextStyle(color: inputColor);
  static const activeTextFieldStyle = TextStyle(color: focusColor);

  static buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      hintStyle: const TextStyle(color: inputColor),
      labelStyle: const TextStyle(color: focusColor),
      border: const OutlineInputBorder(borderSide: BorderSide(color: focusColor)),
      floatingLabelStyle: const TextStyle(color: inputColor),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: focusColor)),
    );
  }
}
