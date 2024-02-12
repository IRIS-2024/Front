import 'package:get/get.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/repository/bookmark_repository.dart';

class BookmarkController {

  // 북마크 추가 or 삭제
  void postAndDeleteBookmark(bool bookmarked, int pid) async {
    if (bookmarked) { // true-> false: 삭제
      Get.put(BookmarkController()).deleteBookmark(pid);
    } else { // false -> true: 추가
      Get.put(BookmarkController()).postBookmark(pid);
    }
  }

  // 북마크 추가
  void postBookmark(int postId) async {
    print('postBookmark');

    // 임시 주석
    final dio = createDio();
    final BookmarkRepository bookmarkRepository = BookmarkRepository(dio);
    await bookmarkRepository.postBookmark(postId).then((resp) {
      if (resp.statusCode == 200) {
        print('Info deleted successfully.');
      } else {
        // 실패한 경우
        print('Error: ${resp.data?.message ?? 'Unknown error'}');
      }
    }).catchError((error) {
      print('print e: $error');
    });
  }

  // 북마크 삭제
  void deleteBookmark(int postId) async {
    print('deleteBookmark');

    // 임시 주석
    final dio = createDio();
    final BookmarkRepository bookmarkRepository = BookmarkRepository(dio);
    await bookmarkRepository.deleteBookmark(postId).then((resp) {
      if (resp.statusCode == 200) {
        print('Info deleted successfully.');
      } else {
        // 실패한 경우
        print('Error: ${resp.data?.message ?? 'Unknown error'}');
      }
    }).catchError((error) {
      print('print e: $error');
    });
  }
}
