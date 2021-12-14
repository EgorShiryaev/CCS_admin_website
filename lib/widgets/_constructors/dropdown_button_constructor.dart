import 'package:flutter/material.dart';

class DropdownButtonConstructor extends StatelessWidget {
  final String title;
  final String value;
  final List<String> values;
  final Function setValue;

  const DropdownButtonConstructor({
    Key? key,
    required this.title,
    required this.value,
    required this.values,
    required this.setValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: LocalStyles.headerTextStyle,
          ),
        ),
        SizedBox(
          width: 300,
          child: DropdownButton<String>(
            value: value,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            alignment: AlignmentDirectional.center,
            icon: const Icon(Icons.arrow_downward_sharp),
            underline: Container(
              height: 1,
              color: LocalStyles.inputColor,
            ),
            onChanged: (value) => setValue(value),
            items: values.map<DropdownMenuItem<String>>((String val) {
              return DropdownMenuItem<String>(
                value: val,
                child: SizedBox(
                  width: 276,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      val,
                      style: LocalStyles.headerTextStyle,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}

class LocalStyles {
  static const inputColor = Colors.white;
  static const headerTextStyle = TextStyle(fontSize: 16, color: inputColor);
}
