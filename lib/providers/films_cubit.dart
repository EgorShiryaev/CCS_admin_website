import 'package:admin_website/classes/film.dart';
import 'package:admin_website/providers/cubit_constructor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../_config/firebase_config.dart';

class FilmsCubit extends CubitConstructor<Film>{
  FilmsCubit() : super(
    collectionRef: FirebaseFirestore.instance.collection(FirebaseConfig.films).withConverter<Film>(
                fromFirestore: (snapshot, _) => Film.fromJson(snapshot.data()!),
                toFirestore: (film, _) => film.toJson(),
              ),
  );
}