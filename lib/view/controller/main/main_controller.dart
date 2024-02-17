import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/model/short_post.dart';
import 'package:iris_flutter/repository/post_repository.dart';
import 'package:iris_flutter/view/controller/map/map_service.dart';

class MainController {
  RxList<ShortPost> postList = <ShortPost>[].obs;
  Rx<Position?> initPosition = Rx<Position?>(null); // current location
  Rx<String?> shortAddress = Rx<String?>(null);

  Future getPositionAndPostList() async {
    await getCurrentPosition();
    getShortAddress(initPosition.value!);
    loadPostList(initPosition.value!.latitude, initPosition.value!.latitude);
  }

  // 현 위치 얻어오기
  Future getCurrentPosition() async {
    initPosition.value = await MapService.determinePosition();
  }

  // 가공된 (행정) 주소 받아오기
  void getShortAddress(Position currentPosition) async {
    // 전체 (행정) 주소 fullAddress
    final fullAddress = await MapService.getAddrFromLatlng(
        currentPosition.latitude, currentPosition.longitude);
    // 가공
    final fullAddressList = fullAddress.split(' ');
    shortAddress.value = '${fullAddressList[1]} ${fullAddressList[2]}';
  }

  void loadPostList(double latitude, double longitude) async {
    final dio = createDio();
    PostRepository postRepository = PostRepository(dio);
    await postRepository
        .getPostList(latitude, longitude, null, null, null)
        .then((resp) {
      postList.value = resp;
    }).catchError((error) {
      print('[catchError]: $error');
    });
  }

  setTmpData(double latitude, double longitude) {
    print('setTmpData lat: $latitude, lng: $longitude');

    postList.value = [
      ShortPost(
          pid: 0,
          imgUrl:
              'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg',
          name: '김말순',
          gender: true,
          age: 85,
          address: '용산구 갈월동',
          latitude: latitude + 0.0022,
          longitude: longitude + 0.0004,
          bookmarked: false,
          disappearedAt: "2024-02-09T07:11:42.069Z",
          createdAt: "2024-02-09T07:11:42.069Z",
          updatedAt: null,
          author: true),
      ShortPost(
          pid: 0,
          imgUrl:
              'https://cdn.class101.net/images/587ecdf0-4329-4447-ac00-f2b25b23eab8',
          name: '김실종',
          gender: false,
          age: 7,
          address: '용산구 왕왕동',
          latitude: latitude + 0.0052,
          longitude: longitude + 0.0020,
          disappearedAt: "2024-02-12 22:57:05.427963",
          createdAt: "2024-02-12 22:57:05.427963",
          updatedAt: null,
          bookmarked: true,
          author: false),
      ShortPost(
          pid: 1,
          imgUrl:
              'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg',
          name: '김무무',
          gender: true,
          age: 9,
          address: '용산구 왕왕동',
          latitude: latitude + 0.0070,
          longitude: longitude + 0.0040,
          disappearedAt: "2024-02-09T07:11:42.069Z",
          createdAt: "2024-02-09T07:11:42.069Z",
          updatedAt: null,
          bookmarked: true,
          author: false),
      ShortPost(
          pid: 1,
          imgUrl:
              'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg',
          name: '김무무',
          gender: true,
          age: 9,
          address: '용산구 왕왕동',
          latitude: latitude + 0.0010,
          longitude: longitude + 0.0020,
          disappearedAt: "2024-02-09T07:11:42.069Z",
          createdAt: "2024-02-09T07:11:42.069Z",
          updatedAt: null,
          bookmarked: true,
          author: false),
    ];
  }
}
