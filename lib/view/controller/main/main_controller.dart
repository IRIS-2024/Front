import 'package:get/get.dart';
import 'package:iris_flutter/model/post_list.dart';

class MainController {
<<<<<<< HEAD
  RxList<Post> missingInfoList = <Post>[].obs;
=======
  RxList<PostList> missingInfoList = <PostList>[].obs;
>>>>>>> main

  setTmpData() {
    print('print DateTime.now(): ${DateTime.now()}');
    missingInfoList.value = [
<<<<<<< HEAD
      Post(
=======
      PostList(pid: 0,
          imgUrl: 'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg',
>>>>>>> main
          name: '김말순',
          age: 85,
          address: '용산구 갈월동',
<<<<<<< HEAD
          latitude: 37.545144,
          longitude: 126.964381,
          clothes: '빨간 숏패딩, 검은 슬랙스, 분홍색 운동화',
          details: '치매가 있으십니다. 보통 모두를 언니라고 칭합니다.',
          bookmarked: false,
          images: [
            'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg',
          ],
          disappearedAt: "2024-02-09T07:11:42.069Z",
          createdAt: "2024-02-09T07:11:42.069Z",
          updatedAt: null),
      Post(
=======
          disappearedAt: "2024-02-12T07:22:56.069Z",
          createdAt: "2024-02-12T07:22:56.069Z",
          updatedAt: null,
          bookmarked: false),
      PostList(pid: 1,
          imgUrl: 'https://cdn.class101.net/images/587ecdf0-4329-4447-ac00-f2b25b23eab8',
>>>>>>> main
          name: '김실종',
          age: 7,
          address: '용산구 왕왕동',
          disappearedAt: "2024-02-12 22:57:05.427963",
          createdAt: "2024-02-12 22:57:05.427963",
          updatedAt: null,
          bookmarked: true),
      PostList(pid: 1,
          imgUrl: 'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg',
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
