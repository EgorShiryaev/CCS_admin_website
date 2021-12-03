abstract class DataType {
  List<String> get keysForTable;

  List<dynamic> get valuesForTable;

  String get id;

  Map<String, dynamic> toJson();
}
