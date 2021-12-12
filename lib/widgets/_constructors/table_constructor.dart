import 'package:flutter/material.dart';

import '../../classes/data_type.dart';

class TableConstructor extends StatelessWidget {
  final List<DataType> datas;
  final Function setSelectedData;
  final DataType? selectData;

  const TableConstructor({
    Key? key,
    required this.datas,
    required this.setSelectedData,
    required this.selectData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          border: LocalStyles.tableBorder,
          columns: datas.first.keysForTable
              .map((String header) => DataColumn(
                    label: Container(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: Text(header, style: LocalStyles.coloredTextStyle),
                    ),
                  ))
              .toList(),
          rows: getRows(datas),
        ),
      ),
    );
  }

  getRows(List<DataType> datas) {
    return datas
        .map((e) => DataRow(
              selected: selectData != null ? e.id == selectData?.id : false,
              onSelectChanged: (value) {
                if (value != null && value) {
                  setSelectedData(e);
                  return;
                }
                setSelectedData(null);
              },
              cells: getDataCell(e),
            ))
        .toList();
  }

  getDataCell(DataType data) {
    List<String> tableData = data.valuesForTable;
    return tableData.map((value) {
      return DataCell(
        Container(
          constraints: const BoxConstraints(
            maxWidth: 300,
          ),
          child: Text(value, style: LocalStyles.coloredTextStyle),
        ),
      );
    }).toList();
  }
}

class LocalStyles {
  static const color = Colors.grey;
  static const tableBorder = TableBorder(
    top: BorderSide(color: LocalStyles.color),
    bottom: BorderSide(color: LocalStyles.color),
    left: BorderSide(color: LocalStyles.color),
    right: BorderSide(color: LocalStyles.color),
    horizontalInside: BorderSide(color: LocalStyles.color),
  );
  static const containerDecoration = BoxDecoration(
    border: Border(
      top: BorderSide(color: LocalStyles.color),
      bottom: BorderSide(color: LocalStyles.color),
      left: BorderSide(color: LocalStyles.color),
      right: BorderSide(color: LocalStyles.color),
    ),
  );
  static const coloredTextStyle = TextStyle(color: color);
}
