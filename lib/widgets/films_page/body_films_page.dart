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
  Film? selectFilm;
  setSelectFilm(Film? e) {
    setState(() => selectFilm = e);
    widget.titleController.text = selectFilm != null ? selectFilm!.title : '';
    widget.descriptionController.text = selectFilm != null ? selectFilm!.description : '';
    widget.durationController.text = selectFilm != null ? '${selectFilm!.duration}' : '';
    widget.actorsController.text = selectFilm != null ? selectFilm!.actors : '';
    widget.ageLimitController.text = selectFilm != null ? '${selectFilm!.ageLimit}' : '';
    widget.budgetController.text = selectFilm != null ? '${selectFilm!.budget}' : '';
    widget.countryController.text = selectFilm != null ? selectFilm!.country : '';
    widget.filmmakerController.text = selectFilm != null ? selectFilm!.filmmaker : '';
    widget.ratingController.text = selectFilm != null ? '${selectFilm!.rating}' : '';
    widget.yearController.text = selectFilm != null ? '${selectFilm!.year}' : '';
    selectGenre = selectFilm != null ? selectFilm!.genre : widget.genres.last;
  }

  String selectGenre = '';
  setSelectGenre(String genre) => setState(() => selectGenre = genre);

  @override
  void initState() {
    selectGenre = widget.genres.last;
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
      genre: selectGenre,
      setGenre: setSelectGenre,
      isSelectedFilmIsNotNull: selectFilm != null,
      genres: widget.genres,
    );

    final table = TableConstructor(
      datas: widget.films,
      setSelectedData: setSelectFilm,
      selectData: selectFilm,
    );
    return BodyConstructor(
      form: form,
      table: table,
      add: _create,
      update: _update,
      delete: _delete,
      isSelect: selectFilm != null,
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
      setSelectFilm(null);
    }
  }

  _update() {
    if (_emptyValidator(widget.descriptionController.text) == null &&
        _intValidator(widget.durationController.text) == null) {
      final film = _createFilm();
      BlocProvider.of<FilmsCubit>(context).update(film);
      setSelectFilm(null);
    } else {
      widget.globalKey.currentState!.validate();
    }
  }

  _delete() {
    BlocProvider.of<FilmsCubit>(context).delete(selectFilm!.id);
    setSelectFilm(null);
  }

  _createFilm() {
    return Film(
      title: widget.titleController.text,
      description: widget.descriptionController.text,
      duration: int.parse(widget.durationController.text),
      genre: selectGenre,
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
