import 'package:flutter/material.dart';
import '../../classes/data_type.dart';

class TableConstructor extends StatelessWidget {
  final List<DataType> data;
  final Function setSelectedData;
  final DataType? selectData;

  TableConstructor({
    Key? key,
    required this.data,
    required this.setSelectedData,
    required this.selectData,
  }) : super(key: key);

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return verticalTable();
  }

  verticalTable() {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          border: LocalStyles.tableBorder,
          columns: getColumns(data.first.headersForTable),
          rows: getRows(data),
        ),
      ),
    );
  }

  getColumns(List<String> headers) {
    return headers
        .map(
          (String header) => DataColumn(
            label: Container(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Text(header, style: LocalStyles.coloredTextStyle),
            ),
          ),
        )
        .toList();
  }

  getRows(List<DataType> data) {
    return data
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
  static final borderTableColor = Colors.grey.shade700;
  static const color = Colors.grey;
  static final tableBorder = TableBorder.all(color: borderTableColor);
  static final containerDecoration = BoxDecoration(
    border: Border.all(color: color),
  );
  static final colorText = Colors.grey.shade300;
  static final coloredTextStyle = TextStyle(color: colorText);
}
