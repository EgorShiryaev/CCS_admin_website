import 'package:flutter/material.dart';

class FilmForm extends StatelessWidget {
  final GlobalKey<FormState> formGlobalKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController durationController;
  final Function titleValidator;
  final Function descriptionValidator;
  final Function durationValidator;
  final String genre;
  final Function setGenre;
  final String posterPath;
  final Function setPosterPath;
  final bool isSelectedFilmIsNotNull;
  final List<String> genres;

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
    required this.posterPath,
    required this.setPosterPath,
    required this.isSelectedFilmIsNotNull,
    required this.genres,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formGlobalKey,
      child: Column(
        children: [
          Container(
            width: 300,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              readOnly: isSelectedFilmIsNotNull,
              controller: titleController,
              style: isSelectedFilmIsNotNull ? LocalStyles.activeTextFieldStyle : LocalStyles.inactiveTextFieldStyle,
              cursorColor: LocalStyles.inputColor,
              decoration: LocalStyles.buildInputDecoration('Название'),
              validator: (value) => titleValidator(value),
            ),
          ),
          Container(
            width: 300,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              maxLines: 5,
              controller: descriptionController,
              style: LocalStyles.inactiveTextFieldStyle,
              cursorColor: LocalStyles.inputColor,
              decoration: LocalStyles.buildInputDecoration('Описание'),
              validator: (value) => descriptionValidator(value),
            ),
          ),
          Container(
            width: 300,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              controller: durationController,
              style: LocalStyles.inactiveTextFieldStyle,
              cursorColor: LocalStyles.inputColor,
              decoration: LocalStyles.buildInputDecoration('Продолжительность(в минутах)'),
              validator: (value) => durationValidator(value),
            ),
          ),
          SizedBox(
            width: 300,
            child: DropdownButton<String>(
              value: genre,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              alignment: AlignmentDirectional.center,
              icon: const Icon(Icons.arrow_downward_sharp),
              underline: Container(
                height: 1,
                color: LocalStyles.focusColor,
              ),
              onChanged: (value) => setGenre(value),
              items: genres.map<DropdownMenuItem<String>>((String role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: SizedBox(
                    width: 276,
                    child: Center(
                      child: Text(role),
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

class LocalStyles {
  static const inputColor = Colors.white;
  static const focusColor = Colors.grey;
  static const headerTextStyle = TextStyle(fontSize: 16, color: inputColor);
  static const inactiveTextFieldStyle = TextStyle(color: inputColor);
  static const activeTextFieldStyle = TextStyle(color: focusColor);

  static buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      hintStyle: const TextStyle(color: focusColor),
      // Unfocused
      labelStyle: const TextStyle(color: focusColor),
      border: const OutlineInputBorder(borderSide: BorderSide(color: focusColor)),
      // Focused
      floatingLabelStyle: const TextStyle(color: focusColor),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: focusColor)),
    );
  }
}
