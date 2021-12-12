import 'package:flutter/material.dart';

class TextFieldConstructor extends StatelessWidget {
   final int maxLines;
    final TextEditingController controller;
    final String label;
    final Function validator;
    final FocusNode focusNode;
    final FocusNode nextFocusNode;
  const TextFieldConstructor({
    Key? key,
    required this.maxLines,
    required this.controller,
    required this.label,
    required this.validator,
    required this.focusNode,
    required this.nextFocusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     _changeFocus(FocusNode nextFocus) => nextFocus.requestFocus(nextFocus);
    return Container(
      width: 300,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        onSaved: (_) =>_changeFocus(nextFocusNode),
        onFieldSubmitted: (_) =>_changeFocus(nextFocusNode),
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
  static const inputColor = Colors.grey;
  static const focusColor = Colors.grey;
  static const headerTextStyle = TextStyle(fontSize: 16, color: inputColor);
  static const inactiveTextFieldStyle = TextStyle(color: inputColor);
  static const activeTextFieldStyle = TextStyle(color: focusColor);

  static buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      hintStyle: const TextStyle(color: focusColor),
      labelStyle: const TextStyle(color: inputColor),
      border: const OutlineInputBorder(borderSide: BorderSide(color: focusColor)),
      floatingLabelStyle: const TextStyle(color: focusColor),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: focusColor)),
    );
  }
}
