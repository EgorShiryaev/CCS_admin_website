import 'package:admin_website/providers/films_cubit.dart';
import 'package:admin_website/widgets/_constructors/body_constructor.dart';
import 'package:admin_website/widgets/_constructors/table_constructor.dart';
import 'package:admin_website/widgets/films_page/film_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final actorsController = TextEditingController();
  final ageLimitController = TextEditingController();
  final budgetController = TextEditingController();
  final countryController = TextEditingController();
  final filmmakerController = TextEditingController();
  final ratingController = TextEditingController();
  final yearController = TextEditingController();

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
    widget.durationController.text = selectedFilm != null ? '${selectedFilm!.duration}' : '';
    widget.actorsController.text = selectedFilm != null ? selectedFilm!.actors : '';
    widget.ageLimitController.text = selectedFilm != null ? '${selectedFilm!.ageLimit}' : '';
    widget.budgetController.text = selectedFilm != null ? '${selectedFilm!.budget}' : '';
    widget.countryController.text = selectedFilm != null ? selectedFilm!.country : '';
    widget.filmmakerController.text = selectedFilm != null ? selectedFilm!.filmmaker : '';
    widget.ratingController.text = selectedFilm != null ? '${selectedFilm!.rating}' : '';
    widget.yearController.text = selectedFilm != null ? '${selectedFilm!.year}' : '';
    selectedGenre = selectedFilm != null ? selectedFilm!.genre : widget.genres.last;
  }

  late String selectedGenre;
  setSelectedGenre(String genre) => setState(() => selectedGenre = genre);

  @override
  void initState() {
    selectedGenre = widget.genres.last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final form = FilmForm(
      formGlobalKey: widget.globalKey,
      titleController: widget.titleController,
      descriptionController: widget.descriptionController,
      durationController: widget.durationController,
      actorsController: widget.actorsController,
      ageLimitController: widget.ageLimitController,
      budgetController: widget.budgetController,
      countryController: widget.countryController,
      filmmakerController: widget.filmmakerController,
      ratingController: widget.ratingController,
      yearController: widget.yearController,
      titleValidator: _titleValidator,
      descriptionValidator: _emptyValidator,
      durationValidator: _intValidator,
      actorsValidator: _emptyValidator,
      ageLimitValidator: _intValidator,
      budgetValidator: _intValidator,
      countryValidator: _emptyValidator,
      filmmakerValidator: _emptyValidator,
      ratingValidator: _ratingValidator,
      yearValidator: _intValidator,
      genre: selectedGenre,
      setGenre: setSelectedGenre,
      isSelectedFilmIsNotNull: selectedFilm != null,
      genres: widget.genres,
    );

    final table = TableConstructor(
      data: widget.films,
      setSelectedData: setSelectedFilm,
      selectData: selectedFilm,
    );
    return BodyConstructor(
      form: form,
      table: table,
      add: _create,
      update: _update,
      delete: _delete,
      isSelect: selectedFilm != null,
    );
  }

  _titleValidator(String value) {
    for (var film in widget.films) {
      if (film.title == value) {
        return 'Это название занято';
      }
    }
    return _emptyValidator(value);
  }

  _intValidator(String value) {
    final n = int.tryParse(value);
    if (n == null) {
      return 'Некорректное число';
    }
    return _emptyValidator(value);
  }

  _ratingValidator(String value) {
    final n = double.tryParse(value);
    if (n == null) {
      return 'Некорректное число';
    }
    if (n > 10) {
      return 'Рейтинг не может быть больше 10';
    }
    if (n < 0) {
      return 'Рейтинг не может быть меньше 0';
    }
    return _emptyValidator(value);
  }

  _emptyValidator(String value) {
    return value.isEmpty ? 'Введите данные' : null;
  }

  _create() {
    if (widget.globalKey.currentState!.validate()) {
      final film = _createFilm();
      BlocProvider.of<FilmsCubit>(context).create(film);
      setSelectedFilm(null);
    }
  }

  _update() {
    if (_emptyValidator(widget.descriptionController.text) == null &&
        _intValidator(widget.durationController.text) == null) {
      final film = _createFilm();
      BlocProvider.of<FilmsCubit>(context).update(film);
      setSelectedFilm(null);
    } else {
      widget.globalKey.currentState!.validate();
    }
  }

  _delete() {
    BlocProvider.of<FilmsCubit>(context).delete(selectedFilm!.id);
    setSelectedFilm(null);
  }

  _createFilm() {
    return Film(
      title: widget.titleController.text,
      description: widget.descriptionController.text,
      duration: int.parse(widget.durationController.text),
      genre: selectedGenre,
      actors: widget.actorsController.text,
      ageLimit: int.parse(widget.ageLimitController.text),
      budget: int.parse(widget.budgetController.text),
      country: widget.countryController.text,
      filmmaker: widget.filmmakerController.text,
      rating: double.parse(widget.ratingController.text),
      year: int.parse(widget.yearController.text),
    );
  }
}
