import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import ' screens/loginscreen.dart';
import 'services/fcm_service.dart';
import 'services/fcm_wipe_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) {
      print("🔥🔥🔥 MENSAJE GLOBAL RECIBIDO 🔥🔥🔥");

      print("Título:");
      print(message.notification?.title);

      print("Body:");
      print(message.notification?.body);

      print("Data:");
      print(message.data);
    },
  );

  await FCMService.initialize();

  await FcmWipeService.init();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Seguro',
      home: const LoginScreen(),
    );
  }
}