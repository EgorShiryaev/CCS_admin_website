import 'package:admin_website/_config/firebase_config.dart';
import 'package:admin_website/classes/cinema_halls.dart';
import 'package:admin_website/classes/film.dart';
import 'package:admin_website/classes/session.dart';
import 'package:admin_website/providers/cubit_constructor.dart';
import 'package:admin_website/providers/sessions_cubit.dart';
import 'package:admin_website/widgets/sessions_page/body_sessions_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/state_builder.dart';

class SessionsPage extends StatelessWidget {
  SessionsPage({Key? key}) : super(key: key);

  final Stream<QuerySnapshot<CinemaHall>> _cinemaHallsStream = FirebaseFirestore.instance
      .collection(FirebaseConfig.cinemaHalls)
      .withConverter<CinemaHall>(
        fromFirestore: (snap, _) => CinemaHall.fromJson(snap.data()!),
        toFirestore: (cinemahalls, _) => cinemahalls.toJson(),
      )
      .snapshots();

  final Stream<QuerySnapshot<Film>> _filmStream = FirebaseFirestore.instance
      .collection(FirebaseConfig.films)
      .withConverter<Film>(
          fromFirestore: (snap, _) => Film.fromJson(snap.data()!), toFirestore: (film, _) => film.toJson())
      .snapshots();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SessionsCubit>(context).read();
    return Scaffold(body: _filmsStreamBuilder());
  }

  _filmsStreamBuilder() {
    return StreamBuilder<QuerySnapshot<Film>>(
      stream: _filmStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Film>> snapshot) {
        if (snapshot.hasError) {
          return StateBuilder.error(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return StateBuilder.loading();
        }
        List<Film> filmsData = snapshot.data!.docs.map((e) => e.data()).toList();
        List<String> films = filmsData.map((e) => e.title).toList();
        return _cinemaHallsStreamBuilder(films);
      },
    );
  }

  _cinemaHallsStreamBuilder(List<String> films) {
    return StreamBuilder<QuerySnapshot<CinemaHall>>(
      stream: _cinemaHallsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<CinemaHall>> snapshot) {
        if (snapshot.hasError) {
          return StateBuilder.error(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return StateBuilder.loading();
        }
        List<CinemaHall> cinemaHalls = snapshot.data!.docs.map((e) => e.data()).toList();
        return _blocBuilder(films, cinemaHalls);
      },
    );
  }

  _blocBuilder(List<String> films, List<CinemaHall> cinemaHalls) {
    return BlocBuilder<SessionsCubit, CubitState>(
      builder: (context, state) {
        if (state is Loading) {
          return StateBuilder.loading();
        }
        if (state is Error) {
          return StateBuilder.error(state.message);
        }
        if (state is Loaded) {
          List sessions = state.data;
          return BodySessionsPage(films: films, cinemaHalls: cinemaHalls, sessions: sessions as List<Session>);
        }
        return StateBuilder.error('Неизвестный state');
      },
    );
  }
}
