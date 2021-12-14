import 'package:admin_website/classes/data_type.dart';

class CinemaHall extends DataType {
  final String name;
  final int nSeats;

  CinemaHall({
    required this.name,
    required this.nSeats,
  });

  factory CinemaHall.fromJson(Map<String, dynamic> json) {
    return CinemaHall(
      name: json['name'],
      nSeats: json['n_seats'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'n_seats': nSeats,
    };
  }

  @override
  String get id => '';

  @override
  List<String> get headersForTable =>[];

  @override
  List<String> get valuesForTable => [];
}
