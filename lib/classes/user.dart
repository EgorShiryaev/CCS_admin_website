class User {
  final String login;
  final String password;
  final String name;

  User({
    required this.login,
    required this.password,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['login'],
      password: json['password'],
      name: json['name'],
    );
  }

  toJson() {
    return {
      'login': login,
      'password': password,
      'name': name,
    };
  }
}