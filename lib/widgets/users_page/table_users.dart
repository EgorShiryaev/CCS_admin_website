import 'package:flutter/material.dart';
import '../../classes/user.dart';

class TableUsers extends StatelessWidget {
  final List<User> users;
  final Function setSelectedUser;
  final User? selectUser;

  const TableUsers({
    Key? key,
    required this.users,
    required this.setSelectedUser,
    required this.selectUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: LocalStyles.containerDecoration,
      child: SingleChildScrollView(
        child: DataTable(
          border: LocalStyles.tableBorder,
          columns: User.keyForTable.map((String header) => DataColumn(label: Text(header))).toList(),
          rows: getRows(users),
        ),
      ),
    );
  }

  getRows(List<User> users) {
    return users
        .map((e) => DataRow(
              selected: selectUser != null ? e.login == selectUser?.login : false,
              onSelectChanged: (value) {
                if (value != null && value) {
                  setSelectedUser(e);
                  return;
                }
                setSelectedUser(null);
              },
              cells: getDataCell(e),
            ))
        .toList();
  }

  getDataCell(User user) {
    final keys = User.keyForTable.map((e) => e.toLowerCase());
    final json = user.toJson();
    return keys.map((key) {
      return DataCell(
        Text(key == 'role' ? user.role.name : json[key].toString()),
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
  ));
}
