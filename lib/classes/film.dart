import 'package:admin_website/classes/data_type.dart';

class Film extends DataType {
  final String actors;
  final int ageLimit;
  final int budget;
  final String country;
  final String description;
  final int duration;
  final String filmmaker;
  final String genre;
  final double rating;
  final String title;
  final int year;

  Film({
    required this.actors,
    required this.ageLimit,
    required this.budget,
    required this.country,
    required this.filmmaker,
    required this.rating,
    required this.year,
    required this.title,
    required this.description,
    required this.duration,
    required this.genre,
  });

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      actors: json['actors'],
      ageLimit: json['age_limit'],
      budget: json['budget'],
      country: json['country'],
      filmmaker: json['filmmaker'],
      rating: json['rating'],
      year: json['year'],
      title: json['title'],
      description: json['description'],
      duration: json['duration'],
      genre: json['genre'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'rating': rating,
      'year': year,
      'country': country,
      'genre': genre,
      'duration': duration,
      'age_limit': ageLimit,
      'budget': budget,
      'actors': actors,
      'filmmaker': filmmaker,
    };
  }

  @override
  String get id => title;

  @override
  List<String> get headersForTable => [
        'Название',
        'Описание',
        'Рейтинг',
        'Год',
        'Страна',
        'Жанр',
        'Время',
        'Бюджет',
        'Огран.',
        'Режиссер',
        'Актеры',
      ];

  @override
  List<String> get valuesForTable => [
        title,
        description,
        '$rating',
        '$year',
        country,
        genre,
        '$duration мин.',
        '\$${budget / 1000000} млн.',
        '$ageLimit+',
        filmmaker,
        actors,
      ];
}
