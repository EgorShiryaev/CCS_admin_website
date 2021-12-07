
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseConfig {
  static get platformOptions {
    if (kIsWeb) {
      return const FirebaseOptions(
        apiKey: "AIzaSyAChfoaIozVx3GWdJ4WVZxuMq_WfMIs0NU",
        authDomain: "cinema-control-system.firebaseapp.com",
        // databaseURL: ,
        projectId: "cinema-control-system",
        storageBucket: "cinema-control-system.appspot.com",
        messagingSenderId: "764973555459",
        appId: "1:764973555459:web:3af96231e3ff5a57d39336",
        // measurementId: 
      );
    } 
    // else if (Platform.isIOS || Platform.isMacOS) {
    //   return const FirebaseOptions(
    //     apiKey: apiKey,
    //     appId: appId,
    //     messagingSenderId: messagingSenderId,
    //     projectId: projectId,
    //   );
    // } else {
    //   return const FirebaseOptions(
    //     apiKey: apiKey,
    //     appId: appId,
    //     messagingSenderId: messagingSenderId,
    //     projectId: projectId,
    //   );
    // }
  }

  static get users => 'users';
  static get genres => 'genres';
  static get films => 'films';
}
