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
    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(flex: 2, child: SizedBox()),
              const Expanded(flex: 4, child: SizedBox()),
              Expanded(
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.all(20),
                  child: OutlinedButton(
                    style: LocalStyles.buttonStyle(true),
                    onPressed: () => Navigator.pop(context),
                    child: Center(
                      child: Text(
                        'Выйти',
                        style: LocalStyles.header2(true),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: SingleChildScrollView(child: form),
              ),
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
              const Expanded(child: SizedBox())
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}
