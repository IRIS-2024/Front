import 'package:get/get.dart';
import 'package:iris_flutter/model/post.dart';
import 'package:iris_flutter/model/short_post.dart';

class MainController {
  RxList<ShortPost> postList = <ShortPost>[].obs;

  setTmpData() {
    postList.value = [
      ShortPost(
          pid: 0,
          imgUrl:
              'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg',
          name: '김말순',
          age: 85,
          address: '용산구 갈월동',
          bookmarked: false,
          disappearedAt: "2024-02-09T07:11:42.069Z",
          createdAt: "2024-02-09T07:11:42.069Z",
          updatedAt: null),
      ShortPost(
          pid: 0,
          imgUrl:
              'https://cdn.class101.net/images/587ecdf0-4329-4447-ac00-f2b25b23eab8',
          name: '김실종',
          age: 7,
          address: '용산구 왕왕동',
          disappearedAt: "2024-02-12 22:57:05.427963",
          createdAt: "2024-02-12 22:57:05.427963",
          updatedAt: null,
          bookmarked: true),
      ShortPost(
          pid: 1,
          imgUrl:
              'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg',
          name: '김무무',
          age: 9,
          address: '용산구 왕왕동',
          disappearedAt: "2024-02-09T07:11:42.069Z",
          createdAt: "2024-02-09T07:11:42.069Z",
          updatedAt: null,
          bookmarked: true),
    ];
  }
}
