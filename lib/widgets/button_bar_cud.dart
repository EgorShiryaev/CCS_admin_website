import 'package:flutter/material.dart';

class ButtonBarCUD extends StatelessWidget {
  final Function add;
  final Function update;
  final Function delete;
  final bool isSelect;
  const ButtonBarCUD({
    Key? key,
    required this.add,
    required this.update,
    required this.delete,
    required this.isSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Function> functions = [add, update, delete];
    List<String> header = ['Добавить', 'Изменить', 'Удалить'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List<Widget>.generate(
        functions.length,
        (index) => Expanded(
          child: OutlinedButton(
            style: LocalStyles.buttonStyle(index == 0 || isSelect),
            onPressed: index == 0 || isSelect ? () => functions[index]() : null,
            child: Center(
              child: Text(header[index], style: LocalStyles.header2(index == 0 || isSelect)),
            ),
          ),
        ),
      ),
    );
  }
}

class LocalStyles {
  static const inputColor = Colors.grey;
  static final inputUnactiveColor = Colors.grey.shade800;
  static const inputActiveColor = Colors.white;
  static final textFieldStyle = TextStyle(color: inputUnactiveColor);
  static header2(bool isSelect) => TextStyle(fontSize: 24, color: isSelect ? inputActiveColor : inputUnactiveColor);
  static buttonStyle(bool isSelect) => OutlinedButton.styleFrom(
        side: BorderSide(width: 1, color: isSelect ? inputActiveColor : inputUnactiveColor),
        padding: const EdgeInsets.all(10),
        primary: isSelect ? inputActiveColor : inputUnactiveColor,
      );
}
