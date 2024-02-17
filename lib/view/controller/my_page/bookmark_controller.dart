import 'dart:developer';

import 'package:get/get.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/model/short_post.dart';
import 'package:iris_flutter/repository/bookmark_repository.dart';
import 'package:iris_flutter/repository/post_repository.dart';

class BookmarkController {
  RxList<ShortPost> shortPostList = <ShortPost>[].obs;

  Future<void> loadData() async {
    final dio = createDio();
    PostRepository postRepository = PostRepository(dio);
    await postRepository
        .getPostList(0, 0, 'BOOKMARKED', 0, 6)
        .then((resp) {
          shortPostList.value = resp;
    }).catchError((error) {
      log('[catchError]: $error');
    });
  }

  // 북마크 추가 or 삭제
  void postAndDeleteBookmark(bool bookmarked, int pid) async {
    if (bookmarked) {
      // true-> false: 삭제
      Get.put(BookmarkController()).deleteBookmark(pid);
    } else {
      // false -> true: 추가
      Get.put(BookmarkController()).postBookmark(pid);
    }
  }

  // 북마크 추가
  void postBookmark(int postId) async {
    log('postBookmark');

    final dio = createDio();
    final BookmarkRepository bookmarkRepository = BookmarkRepository(dio);
    await bookmarkRepository.postBookmark(postId).then((resp) {
      if (resp.statusCode == 200) {
        log('Info deleted successfully.');
      } else {
        // 실패한 경우
        log('Error: ${resp.data?.message ?? 'Unknown error'}');
      }
    }).catchError((error) {
      log('[catchError]: $error');
    });
  }

  // 북마크 삭제
  void deleteBookmark(int postId) async {
    log('deleteBookmark');

    final dio = createDio();
    final BookmarkRepository bookmarkRepository = BookmarkRepository(dio);
    await bookmarkRepository.deleteBookmark(postId).then((resp) {
      if (resp.statusCode == 200) {
        log('Info deleted successfully.');
      } else {
        // 실패한 경우
        log('Error: ${resp.data?.message ?? 'Unknown error'}');
      }
    }).catchError((error) {
      log('[catchError]: $error');
    });
  }
}
