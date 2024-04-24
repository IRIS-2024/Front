import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/local_notifications.dart';
import 'package:iris_flutter/config/theme.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // 최상단에 유지되어야 함 - do not move
  log('receive notification - background');
  log('Message data: ${message.data} / Message Id: ${message.messageId}');

  if (message.notification != null) {
    log('title: ${message.notification!.title}, body: ${message.notification!.body}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // for FCM
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Background Message 수신
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // permission
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  log('User granted permission: ${settings.authorizationStatus}');

  // local notification permission
  LocalNotificationsController localNotificationsController = LocalNotificationsController();
  localNotificationsController.initializeLocalNotifications();

  // Foreground Message 수신
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    log('receive notification - foreground');
    log('Message data: ${message.data} / Message Id: ${message.messageId}');

    if (message.notification != null) {
      log('title: ${message.notification!.title}, body: ${message.notification!.body}');
      localNotificationsController.showLocalNotifications(title: message.notification!.title!, body: message.notification!.body!);
    }
  });

  // localStorage ready
  await userStorage.ready;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MissingYou',
      theme: ThemeData(
        colorScheme: MaterialTheme.lightScheme().toColorScheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)))),
        useMaterial3: true,
      ),
      initialRoute: Config.routerLogin,
      getPages: Config.routers,
    );
  }
}
