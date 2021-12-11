import 'package:admin_website/classes/film.dart';
import 'package:admin_website/providers/films_cubit.dart';
import 'package:admin_website/widgets/films_page/body_films_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../_config/firebase_config.dart';
import '../providers/cubit_constructor.dart';
import '../widgets/main_menu_page/body_main_menu_page.dart';
import '../widgets/state_builder.dart';

class FilmsPage extends StatelessWidget {
  FilmsPage({Key? key}) : super(key: key);

  final Stream<DocumentSnapshot<Data>> _filmGenresStreem = FirebaseFirestore.instance
      .collection(DefaultFirebaseConfig.filmGenres)
      .withConverter(
        fromFirestore: (snapshot, _) => Data.fromJson(snapshot.data()!, DefaultFirebaseConfig.filmGenres),
        toFirestore: (data, _) => {},
      )
      .doc(DefaultFirebaseConfig.filmGenres)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FilmsCubit>(context).read();
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot<Data>>(
        stream: _filmGenresStreem,
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Data>> snapshot) {
          if (snapshot.hasError) {
            return StateBuilder.error(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return StateBuilder.loading();
          }
          List dataDynamic = snapshot.data!.get(DefaultFirebaseConfig.filmGenres);
          List<String> genres = dataDynamic.map((e) => e.toString()).toList();
          return BlocBuilder<FilmsCubit, StateCubit>(
            builder: (context, state) {
              if (state is Loading) {
                return StateBuilder.loading();
              }
              if (state is Error) {
                return StateBuilder.error(state.message);
              }
              if (state is Loaded) {
                List<Film> films = state.data as List<Film>;
                return BodyFilmsPage(
                  films: films,
                  genres: genres,
                );
              }
              return StateBuilder.error('Неизвестный state');
            },
          );
        },
      ),
    );
  }
}
