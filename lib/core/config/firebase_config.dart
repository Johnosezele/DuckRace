import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseConfig {
  static Future<void> init() async {
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.requestPermission();
  }
}
