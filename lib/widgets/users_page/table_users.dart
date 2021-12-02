import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../classes/user.dart';

class TableUsers extends StatelessWidget {
  final List<User> users;
  final Function setSelectedUser;
  User? selectUser;

  TableUsers({
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
          columns: users.first.toJson().keys.map((String header) {
            String title = header.characters.first.toUpperCase() + header.substring(1);
            return DataColumn(label: Text(title));
          }).toList(),
          rows: getRows(users),
        ),
      ),
    );
  }

  getRows(List<User> users) {
    return users
        .map((e) => DataRow(
              selected: selectUser != null ? e.toJson().toString() == selectUser?.toJson().toString() : false,
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
    final json = user.toJson();
    return json.keys.map((title) {
      return DataCell(
        Text(title == 'role' ? user.role.name : json[title].toString()),
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
