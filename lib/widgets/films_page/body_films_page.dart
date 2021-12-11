import 'package:flutter/material.dart';

import '../../classes/film.dart';

class BodyFilmsPage extends StatefulWidget {
  final List<Film> films;
  final List<String> genres;
  BodyFilmsPage({
    Key? key,
    required this.films,
    required this.genres,
  }) : super(key: key);

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final durationController = TextEditingController();

  final globalKey = GlobalKey<FormState>();

  @override
  _BodyFilmsPageState createState() => _BodyFilmsPageState();
}

class _BodyFilmsPageState extends State<BodyFilmsPage> {
  Film? selectedFilm;
  setSelectedFilm(Film? e) {
    setState(() => selectedFilm = e);
    widget.titleController.text = selectedFilm != null ? selectedFilm!.title : '';
    widget.descriptionController.text = selectedFilm != null ? selectedFilm!.description : '';
    widget.durationController.text = selectedFilm != null ? selectedFilm!.duration.toString() : '0';
  }

  String selectGenre = '';
  setSelectGenre(String genre) => setState(() => selectGenre = genre);

  String selectPoster = '';
  setSelectPoster(String poster) => setState(() => selectPoster = poster);

  @override
  void initState() {
    selectGenre = widget.genres.last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
