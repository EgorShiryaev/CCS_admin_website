import 'package:flutter/material.dart';

import '../widgets/films_page/body_films_page.dart';

class FilmsPage extends StatelessWidget {
  const FilmsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BodyFilmsPage(),
    );
  }
}
