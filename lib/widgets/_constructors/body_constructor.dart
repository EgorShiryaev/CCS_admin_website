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
      children: [
        Container(
          padding: const EdgeInsets.all(25),
          width: 350,
          child: SingleChildScrollView(child: form),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: table,
                        ),
                      ),
                    ],
                  ),
                ),
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
