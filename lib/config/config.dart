import 'package:get/get.dart';
import 'package:iris_flutter/view/page/detail_info/post_page.dart';

class Config {
  // gender
  static bool man = false;
  static bool woman = true;

  String getGenderText(bool gender) {
    return gender == Config.woman ? '여자' : '남자';
  }

  // info, comment form
  static int maxImagesLength = 3;

  static final routers = [
    GetPage(
        name: routerDetailInfo,
        page: () => const PostPage(),
        transition: Transition.noTransition),
  ];
  // routers name
  static String routerDetailInfo = '/detail_info';
}
