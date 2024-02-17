import 'dart:developer';

import 'package:get/get.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/model/short_post.dart';
import 'package:iris_flutter/repository/post_repository.dart';

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
}
