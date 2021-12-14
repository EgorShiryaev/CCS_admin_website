import 'package:flutter/material.dart';

import 'button_bar_cud_constructor.dart';

class BodyConstructor extends StatelessWidget {
  final Widget form;
  final Widget table;
  final Function add;
  final Function update;
  final Function delete;
  final bool isSelect;

  const BodyConstructor({
    Key? key,
    required this.form,
    required this.table,
    required this.add,
    required this.update,
    required this.delete,
    required this.isSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              width: 350,
              child: form,
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: LocalStyles.tableContainerDecoration,
                    child: table,
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  height: 50,
                  child: ButtonBarCUDConstuctor(
                    add: add,
                    delete: delete,
                    update: update,
                    isSelect: isSelect,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LocalStyles {
  static final tableContainerDecoration = BoxDecoration(
    border: Border.all(color: Colors.grey, width: 2),
    borderRadius: BorderRadius.circular(5),
  );
}
