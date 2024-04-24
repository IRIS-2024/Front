import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/view/controller/main/main_controller.dart';
import 'package:iris_flutter/view/page/main/main_tab.dart';
import 'package:iris_flutter/view/page/my_page/my_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<void> setupInteractedMessage() async { // FCM push alarm
    // interaction when app opens from terminated state
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // interaction when app opens from background state
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (message.notification!.body != '') { // 임시
      // 알림 받은 특정 post로 이동
      log('notification interaction - handleMessage');
      Get.to(() => const MyPage());
    }

    // if (message.data['pid'] != '') {
    //   // 알림 받은 특정 post로 이동
    //   Get.toNamed(Config.routerPost, arguments: message.data['pid']);
    // }
  }

  @override
  void initState() {
    setupInteractedMessage(); // 알림 받고 앱 접속할 때 interaction
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: CustomPadding.pageInsets.copyWith(bottom: 0),
            child: Column(
              children: [
                // my page iconButton
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      Get.toNamed(Config.routerMyPage);
                    },
                    icon: const Icon(Icons.account_circle_outlined),
                  ),
                ),
                // location Text
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Obx(
                          () => RichText(
                        text: TextSpan(
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                            ),
                            children: [
                              TextSpan(text: Get.put(MainController()).shortAddress.value ?? '현 위치',
                                  style: TextStyle(
                                      color: Theme.of(context).colorScheme.primary
                                  )),
                              TextSpan(text: "\n주변의 실종 정보입니다.",
                                  style: TextStyle(
                                      color: Theme.of(context).colorScheme.onBackground,
                                    fontSize: 27
                                  )
                              )
                            ]
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: CustomPadding.mediumBottom,),

                // main TabBar
                const MainTab(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.toNamed(Config.routerPostForm);
          },
          label: const Text('신고하기'),
          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          foregroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
          icon: const Icon(Icons.report_gmailerrorred),
        ));
  }
}
