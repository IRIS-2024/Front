import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../view/page/my_page/my_page.dart';

class LocalNotificationsController {
  final FlutterLocalNotificationsPlugin _localPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initializeLocalNotifications() async {
    await _initializeSetting();
    await _requestPermissions();
  }

  Future<void> _initializeSetting() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    // const DarwinInitializationSettings initializationSettingsIOS =
    // DarwinInitializationSettings(
    //   requestAlertPermission: false,
    //   requestBadgePermission: false,
    //   requestSoundPermission: false,
    // );

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsIOS,
    );
    await _localPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse? response) {
        // interaction when notification is clicked - only foreground
        log('${response?.payload}');
        Get.to(() => const MyPage()); //   Get.toNamed(Config.routerPost, arguments: response?.payload]);
        _cancelNotification();
      },
    );
  }

  Future<void> _cancelNotification() async {
    await _localPlugin.cancelAll();
  }

  // 권한 요청
  Future<void> _requestPermissions() async {
    await _localPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> showLocalNotifications({
    required String title,
    required String body,
    int messageId = 1,
  }) async {
    await _localPlugin.show(messageId, title, body, NotificationDetails(
      // iOS: const DarwinNotificationDetails(
      //   presentAlert: true,
      //   presentBadge: true,
      //   presentSound: true,
      //   badgeNumber: 1,
      // ),
      android: AndroidNotificationDetails(
        title,
        body,
        importance: Importance.max,
        priority: Priority.high,
        // ongoing: true,
        // 앱을 실행 해야만 메시지가 사라지도록 설정
        // styleInformation: BigTextStyleInformation(body),
        // icon: 'ic_notification',
      ),
    ), payload: 'pid' // TODO: write payload
    );
  }
}