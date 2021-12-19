import 'package:admin_website/classes/data_type.dart';
import 'package:flutter/material.dart';

class Session extends DataType {
  final DateTime date;
  final TimeOfDay time;
  final String cinemaHall;
  final String film;
  final int freeSeats;
  final int ticketPrice;

  Session({
    required this.date,
    required this.time,
    required this.cinemaHall,
    required this.film,
    required this.freeSeats,
    required this.ticketPrice,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    final time = TimeOfDay(
      hour: int.parse(json['datetime']!.split('T').last.split('-')[0]),
      minute: int.parse(json['datetime']!.split('T').last.split('-')[1]),
    );
    final date = DateTime.parse(json['datetime']!.split('T').first);
    return Session(
      date: date,
      time: time,
      cinemaHall: json['cinema_hall']!,
      film: json['film']!,
      freeSeats: json['free_seats'],
      ticketPrice: json['ticket_price'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    String dateString = date.toString().split(' ').first;
    String timeString = time.toString().split('(').last.split(')').first.replaceAll(':', '-');
    return {
      'cinema_hall': cinemaHall,
      'film': film,
      'datetime': '${dateString}T$timeString',
      'free_seats': freeSeats,
      'ticket_price': ticketPrice,
    };
  }

  @override
  String get id =>
      '${date.toIso8601String().split('T').first}T${time.toString().split('(').last.split(')').first.replaceAll(':', '-')}|$film';

  @override
  List<String> get headersForTable => [
        'Время',
        'Дата',
        'Фильм',
        'Зал',
        'Стоимость билета',
        'Свободные места',
      ];

  @override
  List<String> get valuesForTable => [
        time.toString().split('(').last.split(')').first,
        '${date.day}.${date.month}.${date.year}',
        film,
        cinemaHall,
        '$ticketPrice ₽',
        '$freeSeats',
      ];
}
