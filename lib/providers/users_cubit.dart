import 'package:admin_website/providers/cubit_constructor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../_config/firebase_config.dart';
import '../classes/user.dart';

class UsersCubit extends CubitConstructor {
  UsersCubit()
      : super(
          collectionRef: FirebaseFirestore.instance.collection(DefaultFirebaseConfig.users).withConverter<User>(
                fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
                toFirestore: (user, _) => user.toJson(),
              ),
        );
}
