import 'package:admin_website/_config/firebase_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../classes/employee.dart';
import '../../classes/film.dart';

class BodyMainMenuPage extends StatefulWidget {
  final Employee user;
  const BodyMainMenuPage({Key? key, required this.user}) : super(key: key);

  @override
  State<BodyMainMenuPage> createState() => _BodyMainMenuPageState();
}

class _BodyMainMenuPageState extends State<BodyMainMenuPage> {
  final buttons = [
    Button(title: 'Сотрудники', url: '/users'),
    Button(title: 'Фильмы', url: '/'),
    Button(title: 'Сеансы', url: '/'),
    Button(title: 'Создать отчёт', url: '/'),
    Button(title: 'Выйти', url: 'back'),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: buttons
              .map((e) => Container(
                    width: 450,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: OutlinedButton(
                      style: LocalStyles.buttonStyle,
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Text(
                          e.title,
                          style: LocalStyles.buttonTextStyle,
                        ),
                      ),
                      onPressed: () {
                        if (e.url == 'back') {
                          Navigator.pop(context);
                        } else {
                          Navigator.pushNamed(context, e.url);
                        }
                      },
                    ),
                  ))
              .toList()),
    );
  }

  // _filmGenresStreemBuilder() {
  //   final Stream<QuerySnapshot<Data>> _filmGenresStreem = FirebaseFirestore.instance
  //       .collection(DefaultFirebaseConfig.filmGenres)
  //       .withConverter(
  //         fromFirestore: (snapshot, _) => Data.fromJson(snapshot.data()!, DefaultFirebaseConfig.filmGenres),
  //         toFirestore: (data, _) => {},
  //       )
  //       .snapshots();

  //   return StreamBuilder<QuerySnapshot<Data>>(
  //     stream: _filmGenresStreem,
  //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //       if (snapshot.hasError) {
  //         return _errorStateBuilder(snapshot.error.toString());
  //       }
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return _loadingStateBuilder();
  //       }

  //       List dataDynamic = snapshot.data?.docs.first.get(DefaultFirebaseConfig.filmGenres);
  //       List<String> data = dataDynamic.map((e) => e.toString()).toList();
  //       appState.filmGenres = data;
  //       return _filmsStreemBuilder();
  //     },
  //   );
  // }

  // _filmsStreemBuilder() {
  //   final Stream<QuerySnapshot<Film>> _filmsStreem = FirebaseFirestore.instance
  //       .collection(DefaultFirebaseConfig.films)
  //       .withConverter(
  //         fromFirestore: (snap, _) => Film.fromJson(snap.data()!),
  //         toFirestore: (f, _) => {},
  //       )
  //       .snapshots();

  //   return StreamBuilder<QuerySnapshot<Film>>(
  //     stream: _filmsStreem,
  //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Film>> snapshot) {
  //       if (snapshot.hasError) {
  //         return _errorStateBuilder(snapshot.error.toString());
  //       }
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return _loadingStateBuilder();
  //       }

  //       List<Film> dataDynamic = snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
  //       List<String> data = dataDynamic.map((e) => e.title.toString()).toList();
  //       appState.films = data;
  //       return _loadedStateBuilder();
  //     },
  //   );
  // }

  // _cinemaHallsStreemBuilder() {
  //   final Stream<QuerySnapshot<Film>> _cinemaHallsStreem = FirebaseFirestore.instance
  //       .collection(DefaultFirebaseConfig.films)
  //       .withConverter(
  //         fromFirestore: (snap, _) => Film.fromJson(snap.data()!),
  //         toFirestore: (f, _) => {},
  //       )
  //       .snapshots();

  //   return StreamBuilder<QuerySnapshot<Film>>(
  //     stream: _cinemaHallsStreem,
  //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //       if (snapshot.hasError) {
  //         return _errorStateBuilder(snapshot.error.toString());
  //       }
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return _loadingStateBuilder();
  //       }

  //       List dataDynamic = snapshot.data?.docs.map((e) => e.get('title')).toList() ?? [];
  //       List<String> data = dataDynamic.map((e) => e.toString()).toList();
  //       appState.films = data;
  //       return _filmGenresStreemBuilder();
  //     },
  //   );
  // }

  _loadedStateBuilder() {}
}

class LocalStyles {
  static const inputColor = Colors.grey;
  static final buttonStyle = OutlinedButton.styleFrom(
    side: const BorderSide(width: 1, color: inputColor),
    padding: const EdgeInsets.all(10),
    primary: inputColor,
  );
  static const buttonTextStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
  );
}

class Button {
  final String title;
  final String url;

  Button({
    required this.title,
    required this.url,
  });
}

class Data {
  final List<String> data;

  Data({required this.data});

  factory Data.fromJson(Map<String, dynamic> json, String fieldName) {
    return Data(data: json[fieldName]);
  }
}
