import 'dart:js';

import 'package:admin_website/widgets/films_page/text_field_constructor.dart';
import 'package:flutter/material.dart';

class FilmForm extends StatelessWidget {
  final GlobalKey<FormState> formGlobalKey;

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController durationController;
  final TextEditingController actorsController;
  final TextEditingController ageLimitController;
  final TextEditingController budgetController;
  final TextEditingController countryController;
  final TextEditingController filmmakerController;
  final TextEditingController ratingController;
  final TextEditingController yearController;

  final Function titleValidator;
  final Function descriptionValidator;
  final Function durationValidator;
  final Function actorsValidator;
  final Function ageLimitValidator;
  final Function budgetValidator;
  final Function countryValidator;
  final Function filmmakerValidator;
  final Function ratingValidator;
  final Function yearValidator;

  final String genre;
  final Function setGenre;
  final bool isSelectedFilmIsNotNull;
  final List<String> genres;

  FilmForm({
    Key? key,
    required this.formGlobalKey,
    required this.titleController,
    required this.descriptionController,
    required this.durationController,
    required this.titleValidator,
    required this.descriptionValidator,
    required this.durationValidator,
    required this.genre,
    required this.setGenre,
    required this.isSelectedFilmIsNotNull,
    required this.genres,
    required this.actorsController,
    required this.ageLimitController,
    required this.budgetController,
    required this.countryController,
    required this.filmmakerController,
    required this.ratingController,
    required this.yearController,
    required this.actorsValidator,
    required this.ageLimitValidator,
    required this.budgetValidator,
    required this.countryValidator,
    required this.filmmakerValidator,
    required this.ratingValidator,
    required this.yearValidator,
  }) : super(key: key);

  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();
  final focus5 = FocusNode();
  final focus6 = FocusNode();
  final focus7 = FocusNode();
  final focus8 = FocusNode();
  final focus9 = FocusNode();
  final focus10 = FocusNode();
  final focus11 = FocusNode();
  final focus12 = FocusNode();
  final focus13 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formGlobalKey,
      child: FocusTraversalGroup(
        policy: OrderedTraversalPolicy(),
        child: Column(
          children: [
            TextFieldConstructor(
              maxLines: 1,
              controller: titleController,
              label: 'Название',
              validator: titleValidator,
              focusNode: focus1,
              nextFocusNode: focus2,
            ),
            TextFieldConstructor(
              maxLines: 3,
              controller: descriptionController,
              label: 'Описание',
              validator: descriptionValidator,
              focusNode: focus2,
              nextFocusNode: focus3,
            ),
            TextFieldConstructor(
              maxLines: 1,
              controller: ratingController,
              label: 'Рейтинг',
              validator: ratingValidator,
              focusNode: focus3,
              nextFocusNode: focus4,
            ),
            TextFieldConstructor(
              maxLines: 1,
              controller: yearController,
              label: 'Год',
              validator: yearValidator,
              focusNode: focus4,
              nextFocusNode: focus5,
            ),
            TextFieldConstructor(
              maxLines: 1,
              controller: countryController,
              label: 'Страна',
              validator: countryValidator,
              focusNode: focus5,
              nextFocusNode: focus6,
            ),
            _dropdownButtonGenre(context),
            TextFieldConstructor(
              maxLines: 1,
              controller: durationController,
              label: 'Время (мин.)',
              validator: durationValidator,
              focusNode: focus7,
              nextFocusNode: focus8,
            ),
            TextFieldConstructor(
              maxLines: 1,
              controller: budgetController,
              label: 'Бюджет',
              validator: budgetValidator,
              focusNode: focus8,
              nextFocusNode: focus9,
            ),
            TextFieldConstructor(
              maxLines: 1,
              controller: ageLimitController,
              label: 'Возрастное ограничение',
              validator: ageLimitValidator,
              focusNode: focus9,
              nextFocusNode: focus10,
            ),
            TextFieldConstructor(
              maxLines: 1,
              controller: filmmakerController,
              label: 'Режиссер',
              validator: filmmakerValidator,
              focusNode: focus10,
              nextFocusNode: focus11,
            ),
            TextFieldConstructor(
              maxLines: 3,
              controller: actorsController,
              label: 'Актёры',
              validator: actorsValidator,
              focusNode: focus11,
              nextFocusNode: focus1,
            )
          ],
        ),
      ),
    );
  }

  _dropdownButtonGenre(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Жанр',
            style: LocalStyles.headerTextStyle,
          ),
        ),
        SizedBox(
          width: 300,
          child: DropdownButton<String>(
            focusNode: focus6,
            value: genre,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            alignment: AlignmentDirectional.center,
            icon: const Icon(Icons.arrow_downward_sharp),
            underline: Container(
              height: 1,
              color: LocalStyles.focusColor,
            ),
            onChanged: (value) {
              setGenre(value);
            },
            items: genres.map<DropdownMenuItem<String>>((String genre) {
              return DropdownMenuItem<String>(
                value: genre,
                child: SizedBox(
                  width: 276,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      genre,
                      style: LocalStyles.headerTextStyle,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}

class LocalStyles {
  static const inputColor = Colors.grey;
  static const focusColor = Colors.grey;
  static const headerTextStyle = TextStyle(fontSize: 16, color: inputColor);
  static const inactiveTextFieldStyle = TextStyle(color: inputColor);
  static const activeTextFieldStyle = TextStyle(color: focusColor);

  static buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      hintStyle: const TextStyle(color: focusColor),
      labelStyle: const TextStyle(color: inputColor),
      border: const OutlineInputBorder(borderSide: BorderSide(color: focusColor)),
      floatingLabelStyle: const TextStyle(color: focusColor),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: focusColor)),
    );
  }
}
