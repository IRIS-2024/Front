import 'package:get/get.dart';
import 'package:iris_flutter/view/page/detail_info/info_page.dart';

class Config {
  // info form page
  static bool man = false;
  static bool woman = true;

  String getGenderText(bool gender) {
    return gender == Config.woman ? '여자' : '남자';
  }

  // comment form page
  static String enterTime = '시간 입력';

  static int maxImagesLength = 3;

  static final routers = [
    GetPage(
        name: routerDetailInfo,
        page: () => const InfoPage(),
        transition: Transition.noTransition),
  ];
  // routers name
  static String routerDetailInfo = '/detail_info';
}
