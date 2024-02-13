import 'package:get/get.dart';
import 'package:iris_flutter/model/short_post.dart';

class BookmarkController extends GetxController {
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
}
