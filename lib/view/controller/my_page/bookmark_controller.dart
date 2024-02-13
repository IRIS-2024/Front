import 'package:get/get.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/model/short_post.dart';
import 'package:iris_flutter/repository/bookmark_repository.dart';

class BookmarkController {
  RxList<shortPost> postList = <shortPost>[].obs;

  void loadData() {
    List<shortPost> tmpData = [
      shortPost(
          pid: 1,
          imgUrl:
              'https://images.unsplash.com/photo-1580654712603-eb43273aff33?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
          name: '임시1',
          age: 10,
          address: '서울시 동대문구 한천로 1가 11',
          disappearedAt: "",
          createdAt: "2024-02-09T07:11:42.069Z",
          updatedAt: "2024-02-09T07:11:42.069Z",
          bookmarked: true)
    ];
    postList.value = tmpData;
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
