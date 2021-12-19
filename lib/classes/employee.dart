import 'data_type.dart';

class Employee extends DataType {
  final String login;
  final String password;
  final String name;
  final String surname;
  final String role;

  Employee({
    required this.login,
    required this.password,
    required this.name,
    required this.surname,
    required this.role,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      login: json['login'],
      password: json['password'],
      name: json['name'].split(' ').last,
      surname: json['name'].split(' ').first,
      role: json['role'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'password': password,
      'name': '$surname $name',
      'role': role,
    };
  }

  @override
  List<String> get headersForTable => ['Логин', 'Фамилия', 'Имя', 'Должность'];

  @override
  String get id => login;

  @override
  List<String> get valuesForTable => [login, surname, name, role];
}
