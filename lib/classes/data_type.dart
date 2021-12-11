abstract class DataType {

  List<String> get keysForTable;

  List<String> get valuesForTable;

  String get id;

  Map<String, dynamic> toJson();
}
