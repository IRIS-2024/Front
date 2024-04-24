import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationSettingController {
  void saveSetting(bool isSwitched, String selectedRegion1D, String selectedRegion2D) {
    if (isSwitched) { // 알림 on
      log('selectedRegion: ${selectedRegion1D} ${selectedRegion2D}');
      // 설정 저장

      // Topic 구독
      FirebaseMessaging.instance.subscribeToTopic('${selectedRegion1D} ${selectedRegion2D}');
    } else { // 알림 off
      // 저장
      // Topic 구독 취소 -> 이전에 구독한 경우 있을 때만
      FirebaseMessaging.instance.unsubscribeFromTopic('${selectedRegion1D} ${selectedRegion2D}');

    }
  }
}