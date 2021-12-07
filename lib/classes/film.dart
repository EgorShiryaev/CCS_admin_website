import 'package:admin_website/classes/data_type.dart';

class Film extends DataType {
  final String title;
  final String description;
  final int duration;
  final int genre;
  final String posterUrl;
  final String company;
  final String country;
  final int year;

  Film({
    required this.title,
    required this.description,
    required this.duration,
    required this.genre,
    required this.posterUrl,
    required this.company,
    required this.country,
    required this.year,
  });

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      title: json['about']['title'],
      description: json['about']['description'],
      duration: json['about']['duration'],
      genre: json['about']['genre'],
      posterUrl: json['poster_url'],
      company: json['production']['company'],
      country: json['production']['country'],
      year: json['production']['year'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'about': {
        'title': title,
        'description': description,
        'duration': duration,
        'genre': genre,
      },
      'poster_url': posterUrl,
      'production': {
        'company': company,
        'country': country,
        'year': year,
      },
    };
  }

  @override
  String get id => title;

  @override
  List<String> get keysForTable => ['Title', 'Description', 'Duration', 'Genre', 'Company', 'Country', 'Year'];

  @override
  List get valuesForTable => [title, description, duration, genre, company, country, year];
}
