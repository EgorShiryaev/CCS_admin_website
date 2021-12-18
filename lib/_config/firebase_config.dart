import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebaseConfig {
  static get platformOptions {
    if (kIsWeb) {
      return const FirebaseOptions(
        apiKey: "AIzaSyAChfoaIozVx3GWdJ4WVZxuMq_WfMIs0NU",
        authDomain: "cinema-control-system.firebaseapp.com",
        projectId: "cinema-control-system",
        storageBucket: "cinema-control-system.appspot.com",
        messagingSenderId: "764973555459",
        appId: "1:764973555459:web:3af96231e3ff5a57d39336",
      );
    }
  }

  static get employeesRoles => 'roles';
  static get filmGenres => 'genres';
  static get cinemaHalls => 'cinemaHalls';
  static get employees => 'employees';
  static get films => 'films';
  static get sessions => 'sessions';
}
