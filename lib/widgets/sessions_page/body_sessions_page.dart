import 'package:admin_website/classes/cinema_halls.dart';
import 'package:admin_website/classes/session.dart';
import 'package:admin_website/providers/sessions_cubit.dart';
import 'package:admin_website/widgets/_constructors/body_constructor.dart';
import 'package:admin_website/widgets/_constructors/table_constructor.dart';
import 'package:admin_website/widgets/sessions_page/session_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodySessionsPage extends StatefulWidget {
  final List<String> films;
  final List<CinemaHall> cinemaHalls;
  final List<Session> sessions;

  BodySessionsPage({
    Key? key,
    required this.films,
    required this.cinemaHalls,
    required this.sessions,
  }) : super(key: key);

  final freeSeatsController = TextEditingController();
  final ticketPriceController = TextEditingController();

  final globalKey = GlobalKey<FormState>();

  @override
  State<BodySessionsPage> createState() => _BodySessionsPageState();
}

class _BodySessionsPageState extends State<BodySessionsPage> {
  Session? selectedSession;
  setSelectedSession(Session? e) {
    setState(() => selectedSession = e);
    widget.freeSeatsController.text = selectedSession != null ? '${selectedSession!.freeSeats}' : '';
    widget.ticketPriceController.text = selectedSession != null ? '${selectedSession!.ticketPrice}' : '';

    selectedDate = selectedSession != null ? selectedSession!.date : DateTime.now();

    selectedTime = selectedSession != null ? selectedSession!.time : const TimeOfDay(hour: 12, minute: 0);

    selectedFilm = selectedSession != null ? selectedSession!.film : widget.films.last;

    selectedCinemaHall = selectedSession != null
        ? widget.cinemaHalls.firstWhere((element) => selectedSession!.cinemaHall == element.name)
        : widget.cinemaHalls.last;
  }

  late DateTime selectedDate;
  setSelectedDate(DateTime date) => setState(() => selectedDate = date);

  late TimeOfDay selectedTime;
  setSelectedTime(TimeOfDay time) => setState(() => selectedTime = time);

  late String selectedFilm;
  setSelectedFilm(String film) => setState(() => selectedFilm = film);

  late CinemaHall selectedCinemaHall;
  setSelectedCinemaHall(String cinemaHall) => setState(
        () => selectedCinemaHall = widget.cinemaHalls.firstWhere((element) => cinemaHall == element.name),
      );

  @override
  void initState() {
    selectedDate = DateTime.now();
    selectedTime = const TimeOfDay(hour: 12, minute: 0);
    selectedFilm = widget.films.last;
    selectedCinemaHall = widget.cinemaHalls.last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final form = SessionForm(
      globalKey: widget.globalKey,
      freeSeatsController: widget.freeSeatsController,
      ticketPriceController: widget.ticketPriceController,
      freeSeatsValidator: freeSeatsValidator,
      ticketPriceValidator: ticketPriceValidator,
      film: selectedFilm,
      setFilm: setSelectedFilm,
      films: widget.films,
      cinemaHall: selectedCinemaHall.name,
      setCinemaHall: setSelectedCinemaHall,
      cinemaHalls: widget.cinemaHalls.map((e) => e.name).toList(),
      isSelectedSessionIsNotNull: selectedSession != null,
      date: selectedDate,
      setDate: setSelectedDate,
      time: selectedTime,
      setTime: setSelectedTime,
    );

    final table = TableConstructor(
      data: widget.sessions,
      selectData: selectedSession,
      setSelectedData: setSelectedSession,
    );
    return BodyConstructor(
      form: form,
      table: table,
      add: add,
      update: update,
      delete: delete,
      isSelect: selectedSession != null,
    );
  }

  add() {
    if (widget.globalKey.currentState!.validate()) {
      final session = createSession();
      BlocProvider.of<SessionsCubit>(context).create(session);
    }
  }

  update() {
    if (widget.globalKey.currentState!.validate()) {
      final session = createSession();
      BlocProvider.of<SessionsCubit>(context).update(session);
      setSelectedSession(null);
    }
  }

  delete() {
    BlocProvider.of<SessionsCubit>(context).delete(selectedSession!.id);
    setSelectedSession(null);
  }

  createSession() {
    return Session(
      date: selectedDate,
      time: selectedTime,
      cinemaHall: selectedCinemaHall.name,
      film: selectedFilm,
      freeSeats: int.parse(widget.freeSeatsController.text),
      ticketPrice: int.parse(widget.ticketPriceController.text),
    );
  }

  freeSeatsValidator(String value) {
    int? n = int.tryParse(value);
    if (n == null) {
      return 'Некорректное число';
    }
    if (n < 0) {
      return 'Кол-во билетов не может быть отрицательным';
    }
    if (n > selectedCinemaHall.nSeats) {
      return 'Кол-во мест не может быть больше ${selectedCinemaHall.nSeats}';
    }
    return null;
  }

  ticketPriceValidator(String value) {
    int? n = int.tryParse(value);
    if (n == null) {
      return 'Некорректное число';
    }
    return null;
  }
}
