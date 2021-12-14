import 'package:admin_website/widgets/_constructors/dropdown_button_constructor.dart';
import 'package:admin_website/widgets/_constructors/text_field_constructor.dart';
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
  final List<String> genres;

  final bool isSelectedFilmIsNotNull;

  const FilmForm({
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formGlobalKey,
      child: FocusTraversalGroup(
        policy: OrderedTraversalPolicy(),
        child: Column(
          children: [
            TextFieldConstructor(
              controller: titleController,
              label: 'Название',
              validator: titleValidator,
            ),
            const SizedBox(height: LocalStyles.dividerHeight),
            TextFieldConstructor(
              maxLines: 3,
              controller: descriptionController,
              label: 'Описание',
              validator: descriptionValidator,
            ),
            const SizedBox(height: LocalStyles.dividerHeight),
            TextFieldConstructor(
              controller: ratingController,
              label: 'Рейтинг',
              validator: ratingValidator,
            ),
            const SizedBox(height: LocalStyles.dividerHeight),
            TextFieldConstructor(
              controller: yearController,
              label: 'Год',
              validator: yearValidator,
            ),
            const SizedBox(height: LocalStyles.dividerHeight),
            TextFieldConstructor(
              controller: countryController,
              label: 'Страна',
              validator: countryValidator,
            ),
            const SizedBox(height: LocalStyles.dividerHeight),
            DropdownButtonConstructor(
              title: 'Жанр',
              value: genre,
              values: genres,
              setValue: setGenre,
            ),
            const SizedBox(height: LocalStyles.dividerHeight),
            TextFieldConstructor(
              controller: durationController,
              label: 'Время (мин.)',
              validator: durationValidator,
            ),
            const SizedBox(height: LocalStyles.dividerHeight),
            TextFieldConstructor(
              controller: budgetController,
              label: 'Бюджет',
              validator: budgetValidator,
            ),
            const SizedBox(height: LocalStyles.dividerHeight),
            TextFieldConstructor(
              controller: ageLimitController,
              label: 'Возрастное ограничение',
              validator: ageLimitValidator,
            ),
            const SizedBox(height: LocalStyles.dividerHeight),
            TextFieldConstructor(
              controller: filmmakerController,
              label: 'Режиссер',
              validator: filmmakerValidator,
            ),
            const SizedBox(height: LocalStyles.dividerHeight),
            TextFieldConstructor(
              maxLines: 3,
              controller: actorsController,
              label: 'Актёры',
              validator: actorsValidator,
            )
          ],
        ),
      ),
    );
  }
}

class TextFieldInfo {
  final int maxLines;
  final TextEditingController controller;
  final String label;
  final Function validator;

  TextFieldInfo({
    required this.maxLines,
    required this.controller,
    required this.label,
    required this.validator,
  });
}

class LocalStyles {
  static const double dividerHeight = 10;
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
