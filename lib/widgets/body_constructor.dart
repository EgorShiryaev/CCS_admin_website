import 'package:flutter/material.dart';

import 'button_bar_cud.dart';

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
    return Column(
      children: [
        const Expanded(child: SizedBox()),
        Expanded(
          flex: 4,
          child: Row(
            children: [
              Expanded(flex: 2, child: form),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Expanded(
                      flex: 9,
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
                    Expanded(
                      child: ButtonBarCUD(
                        add: add,
                        delete: delete,
                        update: update,
                        isSelect: isSelect,
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox())
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}
