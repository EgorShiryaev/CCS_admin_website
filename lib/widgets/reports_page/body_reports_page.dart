import 'dart:convert';
import 'dart:developer';
import 'package:admin_website/classes/session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:universal_html/html.dart';
import '../../_config/firebase_config.dart';
import '../../classes/cinema_halls.dart';
import '../state_builder.dart';

class BodyReportsPage extends StatelessWidget {
  BodyReportsPage({Key? key}) : super(key: key);

  final Stream<QuerySnapshot<CinemaHall>> _cinemaHallsStream = FirebaseFirestore.instance
      .collection(DefaultFirebaseConfig.cinemaHalls)
      .withConverter<CinemaHall>(
        fromFirestore: (snap, _) => CinemaHall.fromJson(snap.data()!),
        toFirestore: (cinemahalls, _) => cinemahalls.toJson(),
      )
      .snapshots();

  final Stream<QuerySnapshot<Session>> _sessionStream = FirebaseFirestore.instance
      .collection(DefaultFirebaseConfig.sessions)
      .withConverter<Session>(
        fromFirestore: (snap, _) => Session.fromJson(snap.data()!),
        toFirestore: (session, _) => session.toJson(),
      )
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return _cinemaHallsStreamBuilder(context);
  }

  _cinemaHallsStreamBuilder(context) {
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
        Map<String, int> cinemaHallMap = {};
        for (var hall in cinemaHalls) {
          cinemaHallMap.addAll({hall.name: hall.nSeats});
        }

        return _sessionsStreamBuilder(cinemaHallMap, context);
      },
    );
  }

  _sessionsStreamBuilder(Map<String, int> cinemaHallMap, context) {
    return StreamBuilder<QuerySnapshot<Session>>(
      stream: _sessionStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Session>> snapshot) {
        if (snapshot.hasError) {
          return StateBuilder.error(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return StateBuilder.loading();
        }
        List<Session> sessions = snapshot.data!.docs.map((e) => e.data()).toList();
        return _body(cinemaHallMap, sessions, context);
      },
    );
  }

  final buttons = [
    ButtonInfo(
      title: 'Статистика посещения',
      fun: Report.weekdayVisitStatisticsReport,
    ),
    ButtonInfo(
      title: 'Отчет по выручке',
      fun: Report.profitReport,
    ),
    ButtonInfo(title: 'Выйти', fun: () {})
  ];

  _body(Map<String, int> cinemaHallMap, List<Session> sessions, context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: buttons
            .map(
              (e) => Container(
                width: 450,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: OutlinedButton(
                  style: LocalStyles.buttonStyle,
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Text(e.title, style: LocalStyles.buttonTextStyle),
                  ),
                  onPressed: () => e.title == 'Выйти' ? Navigator.pop(context) : e.fun(cinemaHallMap, sessions),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class LocalStyles {
  static const color = Colors.grey;
  static final buttonStyle = OutlinedButton.styleFrom(
    side: const BorderSide(width: 1, color: color),
    padding: const EdgeInsets.all(10),
    primary: color,
  );
  static const buttonTextStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
  );
}

class Report {
  static weekdayVisitStatisticsReport(Map<String, int> cinemaHallMap, List<Session> sessions) {
    List<WeekdayInfo> week = [
      WeekdayInfo(soldTicket: 0, allTicket: 0, sesions: 0), // Monday[soldTicket, allTicket, sessions]
      WeekdayInfo(soldTicket: 0, allTicket: 0, sesions: 0),
      WeekdayInfo(soldTicket: 0, allTicket: 0, sesions: 0),
      WeekdayInfo(soldTicket: 0, allTicket: 0, sesions: 0),
      WeekdayInfo(soldTicket: 0, allTicket: 0, sesions: 0),
      WeekdayInfo(soldTicket: 0, allTicket: 0, sesions: 0),
      WeekdayInfo(soldTicket: 0, allTicket: 0, sesions: 0), // Sunday[soldTicket, allTicket, sessions]
    ];

    for (var sess in sessions) {
      week[sess.date.weekday - 1].soldTicket += (cinemaHallMap[sess.cinemaHall]! - sess.freeSeats);
      week[sess.date.weekday - 1].allTicket += cinemaHallMap[sess.cinemaHall]!;
      week[sess.date.weekday - 1].sesions += 1;
    }

    final grid = PdfGrid();

    grid.columns.add(count: 4);
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    headerRow.cells[0].value = 'День недели';
    headerRow.cells[1].value = 'Кол-во проданных билетов';
    headerRow.cells[2].value = 'Кол-во сеансов';
    headerRow.cells[3].value = 'Процент';

    headerRow.style.font = PdfCjkStandardFont(PdfCjkFontFamily.monotypeSungLight, 12, style: PdfFontStyle.bold);

    List<String> content = [
      'Понедельник:',
      'Вторник:',
      'Среда:',
      'Четверг:',
      'Пятница:',
      'Суббота:',
      'Воскресенье:',
    ];

    PdfGridRowCollection rows = grid.rows;

    for (var i = 0; i < 7; i++) {
      final row = rows.add();
      row.style.font = PdfCjkStandardFont(PdfCjkFontFamily.sinoTypeSongLight, 10);
      row.cells[0].value = content[i];
      row.cells[1].value = week[i].soldTicket.toString();
      row.cells[2].value = week[i].sesions.toString();
      final percent = ((week[i].soldTicket / week[i].allTicket) * 100).toStringAsFixed(0);
      row.cells[3].value = percent == 'NaN' ? '0%' : '$percent%';
    }

    grid.style.cellPadding = PdfPaddings(left: 5, top: 5);

    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    const header = 'Статистика посещений по дням неделям';
    PdfTextElement(
            text: header,
            font: PdfCjkStandardFont(PdfCjkFontFamily.monotypeSungLight, 12, style: PdfFontStyle.bold),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 0, page.getClientSize().width, page.getClientSize().height),
            format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;

    grid.draw(page: page, bounds: Rect.fromLTWH(0, 22, page.getClientSize().width, page.getClientSize().height));

    saveAndLaunchFile(document.save(), '$header.pdf');
  }

  static profitReport(Map<String, int> cinemaHallMap, List<Session> sessions) {
    final profitWeek = ProfitInfo(current: 0, last: 0);
    final profitMonth = ProfitInfo(current: 0, last: 0);
    final profitQuarter = ProfitInfo(current: 0, last: 0);
    final profitYear = ProfitInfo(current: 0, last: 0);

    final nowTime = DateTime.now();
    final now = DateTime(nowTime.year, nowTime.month, nowTime.day);

    profitPerSession(Session session) {
      return session.ticketPrice * (cinemaHallMap[session.cinemaHall]! - session.freeSeats);
    }

    const weekInHour = 7 * 24;
    const monthInDay = 31;

    final currentMonth = now.month;
    final lastMonth = currentMonth == 1 ? 12 : currentMonth - 1;

    final currentQuarter = (now.month - 1) ~/ 3 + 1;
    final lastQuarter = currentQuarter == 1 ? 4 : currentQuarter - 1;

    for (var sess in sessions) {
      final differenceInHour = now.difference(sess.date).inHours;

      if (differenceInHour < weekInHour * 2) {
        if (differenceInHour < weekInHour) {
          profitWeek.current += profitPerSession(sess);
        } else {
          profitWeek.last += profitPerSession(sess);
        }
      }

      final differenceInDays = now.difference(sess.date).inDays;
      if (differenceInDays < monthInDay * 2) {
        final sessMonth = sess.date.month;
        if (sessMonth == currentMonth) {
          profitMonth.current += profitPerSession(sess);
        } else if (sessMonth == lastMonth) {
          profitMonth.last += profitPerSession(sess);
        }
      }

      if (differenceInDays < monthInDay * 6) {
        final sessQuarter = (sess.date.month - 1) ~/ 3 + 1;
        if (sessQuarter == currentQuarter) {
          profitQuarter.current += profitPerSession(sess);
        } else if (sessQuarter == lastQuarter) {
          profitQuarter.last += profitPerSession(sess);
        }
      }

      if (sess.date.year == now.year) {
        profitYear.current += profitPerSession(sess);
      } else if (sess.date.year == now.year - 1) {
        profitYear.last += profitPerSession(sess);
      }
    }

    List<String> content = [
      'Текущая неделя',
      'Прошлая неделя',
      'Текущый месяц $currentMonth.${now.year}г',
      'Прошлый месяц $lastMonth.${lastMonth + 1 == currentMonth ? now.year : now.year - 1}г',
      'Текущый квартал $currentQuarter ${now.year}г',
      'Прошлый квартал $lastQuarter ${lastQuarter + 1 == currentQuarter ? now.year : now.year - 1}г',
      'Текущый год ${now.year}г',
      'Прошлый год ${now.year - 1}г',
    ];

    const header = 'Отчет по выручке';

    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    final PdfLayoutResult layoutResult = PdfTextElement(
            text: header,
            font: PdfCjkStandardFont(PdfCjkFontFamily.monotypeSungLight, 18, style: PdfFontStyle.bold),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 0, page.getClientSize().width, page.getClientSize().height),
            format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;

    final grid = PdfGrid();

    grid.columns.add(count: 2);
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    headerRow.cells[0].value = 'Временной период';
    headerRow.cells[1].value = 'Выручка (руб)';

    headerRow.style.font = PdfCjkStandardFont(PdfCjkFontFamily.monotypeSungLight, 12, style: PdfFontStyle.bold);

    PdfGridRowCollection rows = grid.rows;

    createRow(String period, int prf) {
      final row = rows.add();
      row.style.font = PdfCjkStandardFont(PdfCjkFontFamily.sinoTypeSongLight, 10);
      row.cells[0].value = period;
      row.cells[1].value = '$prf';
    }

    List<ProfitInfo> profits = [
      profitWeek,
      profitMonth,
      profitQuarter,
      profitYear,
    ];

    for (var i = 0; i < 4; i++) {
      createRow(content[2 * i], profits[i].current);
      createRow(content[2 * i + 1], profits[i].last);
    }

    grid.style.cellPadding = PdfPaddings(left: 5, top: 5);

    grid.draw(page: page, bounds: Rect.fromLTWH(0, 25, page.getClientSize().width, page.getClientSize().height));

    saveAndLaunchFile(document.save(), '$header.pdf');
  }

  static Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    AnchorElement(href: 'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
      ..setAttribute('download', fileName)
      ..click();
  }
}

class ButtonInfo {
  final String title;
  final Function fun;

  ButtonInfo({
    required this.title,
    required this.fun,
  });
}

class ProfitInfo {
  int current;
  int last;

  ProfitInfo({
    required this.current,
    required this.last,
  });
}

class WeekdayInfo {
  int soldTicket;
  int allTicket;
  int sesions;

  WeekdayInfo({
    required this.soldTicket,
    required this.allTicket,
    required this.sesions,
  });
}
