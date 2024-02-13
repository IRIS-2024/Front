import 'package:get/get.dart';
import 'package:iris_flutter/view/page/post/post_page.dart';
import 'package:iris_flutter/view/page/form/comment_form/comment_form_page.dart';

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
}
