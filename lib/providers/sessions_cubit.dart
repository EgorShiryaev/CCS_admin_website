import 'package:admin_website/_config/firebase_config.dart';
import 'package:admin_website/classes/session.dart';
import 'package:admin_website/providers/cubit_constructor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SessionsCubit extends CubitConstructor<Session> {
  SessionsCubit()
      : super(
          collectionRef: FirebaseFirestore.instance.collection(DefaultFirebaseConfig.sessions).withConverter<Session>(
                fromFirestore: (snap, _) => Session.fromJson(snap.data()!),
                toFirestore: (session, _) => session.toJson(),
              ),
        );
}
