abstract class DataType {
  List<String> get headersForTable;

  List<String> get valuesForTable;

  String get id;

  Map<String, dynamic> toJson();
}
