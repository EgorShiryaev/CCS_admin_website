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
    return Container(
      decoration: LocalStyles.containerDecoration,
      child: SingleChildScrollView(
        child: DataTable(
          border: LocalStyles.tableBorder,
          columns: datas.first.keysForTable.map((String header) => DataColumn(label: Text(header))).toList(),
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
    List<dynamic> tableData = data.valuesForTable;
    return tableData.map((value) {
      String cellData = value.toString();
      if (cellData.contains('.') && cellData.split('.').length == 2) {
        Enum enumValue = value;
        cellData = enumValue.name;
      }
      return DataCell(
        Text(cellData),
      );
    }).toList();
  }
}

class LocalStyles {
  static final color = Colors.grey.shade700;
  static final tableBorder = TableBorder(
    top: BorderSide(color: LocalStyles.color),
    bottom: BorderSide(color: LocalStyles.color),
    left: BorderSide(color: LocalStyles.color),
    right: BorderSide(color: LocalStyles.color),
    horizontalInside: BorderSide(color: LocalStyles.color),
  );
  static final containerDecoration = BoxDecoration(
    border: Border(
      top: BorderSide(color: LocalStyles.color),
      bottom: BorderSide(color: LocalStyles.color),
      left: BorderSide(color: LocalStyles.color),
      right: BorderSide(color: LocalStyles.color),
    ),
  );
}
