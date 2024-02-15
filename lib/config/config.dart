import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/view/page/post/post_page.dart';
import 'package:iris_flutter/view/page/form/comment_form/comment_form_page.dart';
import 'package:localstorage/localstorage.dart';

// token 저장하는 secure storage
FlutterSecureStorage tokenStorage = const FlutterSecureStorage();
// 회원 정보 저장하는 local storage: id, email, nickName
LocalStorage userStorage = LocalStorage('user');

class Config {
  // gender
  static bool man = false;
  static bool woman = true;

  String getGenderText(bool gender) {
    return gender == Config.woman ? '여자' : '남자';
  }

  // info, comment form
  static int maxImagesLength = 3;

  // Google Map zoom
  static double minZoom = 16;
  static double maxZoom = 19;
  static double initZoom = 17;

  static final routers = [
    GetPage(
        name: routerPost,
        page: () => const PostPage(),
        transition: Transition.noTransition),
    GetPage(
        name: routerCommentForm,
        page: () => const CommentFormPage(),
        transition: Transition.noTransition),
  ];
  // routers name
  static String routerPost = '/detail_info';
  static String routerCommentForm = '/comment_form';

  // storage 이름
  static String id = 'id';
  static String email = 'email';
  static String nickName = 'nickName';
  static String social = 'social';
  static String google = 'google';
}
