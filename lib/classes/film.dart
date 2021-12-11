import 'package:admin_website/classes/data_type.dart';

class Film extends DataType {
  final String title;
  final String description;
  final int duration;
  final String genre;
  final String posterUrl;

  Film({
    required this.title,
    required this.description,
    required this.posterUrl,
    required this.duration,
    required this.genre,
  });

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      description: json['description'],
      duration: json['duration'],
      genre: json['genre'],
      posterUrl: json['poster_url'],
      title: json['title'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'duration': duration,
      'genre': genre,
      'poster_url': posterUrl,
    };
  }

  @override
  String get id => title;

  @override
  List<String> get keysForTable => [
        'Название',
        'Описание',
        'Продолжительность',
        'Жанр',
        'Постер',
      ];

  @override
  List<String> get valuesForTable => [title, description, duration.toString(), genre, posterUrl];
}
