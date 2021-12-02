class User {
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

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'password': password,
      'name': name,
      'role': Role.values.indexOf(role),
    };
  }


  static List<String> get keyForTable => ['Login', 'Name', 'Role'];
}

enum Role {
  admin,
  developer,
  employee,
}
