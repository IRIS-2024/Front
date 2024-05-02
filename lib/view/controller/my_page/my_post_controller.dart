import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/model/short_post.dart';
import 'package:iris_flutter/repository/post_repository.dart';
import 'package:iris_flutter/view/comm/custom_snackbar.dart';
import 'package:intl/intl.dart';

class MyPostController {
  RxList<ShortPost> postList = <ShortPost>[].obs;

  Future<void> loadData() async {
    final dio = createDio();
    PostRepository postRepository = PostRepository(dio);
    await postRepository.getPostList(0, 0, 'MINE', 0, 6).then((resp) {
      postList.value = resp;
    }).catchError((error) {
      log('[catchError]: $error');
    });
  }

  void deletePost(
      int pid, BuildContext context, Function funcAfterDelete) async {
    final dio = createDio();
    PostRepository postRepository = PostRepository(dio);
    await postRepository.deletePost(pid).then((resp) {
      // Error 발생 안 하면 성공
      customSnackBar(
          title: Intl.message('delReport'),
          message: Intl.message('delReportSnackBar'));
      funcAfterDelete();
    }).catchError((error) {
      log('[catchError]: $error');
    });
  }
}
