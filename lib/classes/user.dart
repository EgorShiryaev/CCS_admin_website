import 'data_type.dart';

class User extends DataType {
  final String login;
  final String password;
  final String name;
  final Role role;

  User({
    required this.login,
    required this.password,
    required this.name,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['login'],
      password: json['password'],
      name: json['name'],
      role: Role.values[json['role']],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'password': password,
      'name': name,
      'role': Role.values.indexOf(role),
    };
  }

  @override
  List<String> get keysForTable => ['Login', 'Name', 'Role'];

  @override
  String get id => login;

  @override

  List get valuesForTable => [login, name, role];
}

enum Role {
  admin,
  developer,
  employee,
}
