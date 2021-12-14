import 'package:admin_website/widgets/_constructors/dropdown_button_constructor.dart';
import 'package:admin_website/widgets/_constructors/text_field_constructor.dart';
import 'package:flutter/material.dart';

class SessionForm extends StatelessWidget {
  final GlobalKey<FormState> globalKey;

  final TextEditingController freeSeatsController;
  final TextEditingController ticketPriceController;

  final Function freeSeatsValidator;
  final Function ticketPriceValidator;

  final String film;
  final Function setFilm;
  final List<String> films;

  final String cinemaHall;
  final Function setCinemaHall;
  final List<String> cinemaHalls;

  final DateTime date;
  final Function setDate;

  final TimeOfDay time;
  final Function setTime;

  final bool isSelectedSessionIsNotNull;

  const SessionForm({
    Key? key,
    required this.globalKey,
    required this.freeSeatsController,
    required this.ticketPriceController,
    required this.freeSeatsValidator,
    required this.ticketPriceValidator,
    required this.film,
    required this.setFilm,
    required this.films,
    required this.cinemaHall,
    required this.setCinemaHall,
    required this.cinemaHalls,
    required this.isSelectedSessionIsNotNull,
    required this.date,
    required this.setDate,
    required this.time,
    required this.setTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: FocusTraversalGroup(
        policy: OrderedTraversalPolicy(),
        child: Column(
          children: [
            _buttonPicker(
              function: _datePicker,
              value: '${date.day}.${date.month}.${date.year}',
              ruName: 'дату',
              context: context,
            ),
            const SizedBox(height: LocalStyles.dividerHeight),
            _buttonPicker(
              function: _timePicker,
              value: time.toString().split('(').last.split(')').first,
              ruName: 'время',
              context: context,
            ),
            const SizedBox(height: LocalStyles.dividerHeight),
            TextFieldConstructor(
              controller: freeSeatsController,
              label: 'Свободные места',
              validator: freeSeatsValidator,
            ),
            const SizedBox(height: LocalStyles.dividerHeight),
            TextFieldConstructor(
              controller: ticketPriceController,
              label: 'Цена за билет',
              validator: ticketPriceValidator,
            ),
            const SizedBox(height: LocalStyles.dividerHeight),
            DropdownButtonConstructor(
              title: 'Фильм',
              value: film,
              values: films,
              setValue: setFilm,
            ),
            const SizedBox(height: LocalStyles.dividerHeight),
            DropdownButtonConstructor(
              title: 'Кинозал',
              value: cinemaHall,
              values: cinemaHalls,
              setValue: setCinemaHall,
            ),
          ],
        ),
      ),
    );
  }

  _buttonPicker(
      {required Function function, required String value, required String ruName, required BuildContext context}) {
    return OutlinedButton(
      style: LocalStyles.buttonStyle,
      onPressed: () => function(context),
      child: SizedBox(
        width: 300,
        child: Column(
          children: [
            Text(value, style: LocalStyles.headerTextStyle),
            Text(
              'Изменить $ruName',
              style: LocalStyles.descriptionTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  _datePicker(BuildContext context) {
    final now = DateTime.now();

    showDatePicker(
      context: context,
      initialDate: date,
      firstDate: now,
      lastDate: DateTime(now.year, now.month + 1, now.day),
    ).then((date) => setDate(date));
  }

  _timePicker(BuildContext context) {
    showTimePicker(context: context, initialTime: time).then((time) => setTime(time));
  }
}

class LocalStyles {
  static const double dividerHeight = 10;
  static const headerTextStyle = TextStyle(fontSize: 18, color: Colors.white);
  static final descriptionTextStyle = TextStyle(fontSize: 12, color: Colors.grey.shade300);
  static final buttonStyle = OutlinedButton.styleFrom(
    side: const BorderSide(width: 1, color: Colors.grey),
    padding: const EdgeInsets.symmetric(vertical: 15),
    primary: Colors.grey,
  );
}
