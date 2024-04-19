import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/model/short_post.dart';
import 'package:iris_flutter/repository/post_repository.dart';
import 'package:iris_flutter/view/controller/map/reverse_geocoding_service.dart';
import 'package:iris_flutter/view/controller/map/map_service.dart';

class MainController {
  RxList<ShortPost> shortPostList = <ShortPost>[].obs;
  Rx<Position?> initPosition = Rx<Position?>(null); // current location
  Rx<String?> shortAddress = Rx<String?>(null);

  Future getPositionAndPostList() async {
    await getCurrentPosition();
    getShortAddress(initPosition.value!);
    await loadPostList(
        initPosition.value!.latitude, initPosition.value!.longitude);
  }

  // 현 위치 얻어오기
  Future getCurrentPosition() async {
    initPosition.value = await MapService.determinePosition();
  }

  // 일부 행정 주소(시도,구 단위) 받아오기
  void getShortAddress(Position currentPosition) async {
    final result = await ReverseGeocodingService.getAddrFromLatlng( currentPosition.longitude, currentPosition.latitude);
    if (result != null) {
      shortAddress.value = '${result.region_1depth_name} ${result.region_2depth_name}';
    }
  }

  Future loadPostList(double latitude, double longitude) async {
    // final dio = createDio();
    //   PostRepository postRepository = PostRepository(dio);
    //   await postRepository
    //       .getPostList(latitude, longitude, 'ALL', 0, 0)
    //       .then((resp) {
    //     shortPostList.value = resp;
    //   }).catchError((error) {
    //     log('[catchError]: $error');
    //   });

    List<ShortPost> dummy = [
      ShortPost(
          pid: 1,
          imgUrl:
              'https://plus.unsplash.com/premium_photo-1664203067979-47448934fd97?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          name: '윤여희',
          gender: true,
          age: 52,
          address: '대한민국 서울특별시 숙명여대후문.이봉창활동터',
          latitude: 37.545687433529,
          longitude: 126.963227391242,
          disappearedAt: '2024-04-16T11:56:52.588Z',
          createdAt: "2024-04-16T11:56:52.588Z",
          updatedAt: "2024-04-16T11:56:52.588Z",
          bookmarked: false,
          author: false),
      ShortPost(
          pid: 2,
          imgUrl:
              'https://images.unsplash.com/photo-1687163959049-47b29f23e548?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          name: '장원이',
          gender: true,
          age: 52,
          address: '대한민국 서울특별시 용산구 청파동2가 1-170',
          latitude: 37.546694655077,
          longitude: 126.965193785727,
          disappearedAt: "2024-04-16T12:08:48.897Z",
          createdAt: "2024-04-16T12:08:48.897Z",
          updatedAt: "2024-04-16T12:08:48.897Z",
          bookmarked: true,
          author: false),
      ShortPost(
          pid: 3,
          imgUrl:
              'https://images.unsplash.com/photo-1499996860823-5214fcc65f8f?q=80&w=1066&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          name: '조진우',
          gender: true,
          age: 22,
          address: '대한민국 서울특별시 용산구 청파동3가 132-171',
          latitude: 37.5425585534826,
          longitude: 126.964674778282,
          disappearedAt: "2024-04-16T12:12:46.365Z",
          createdAt: "2024-04-16T12:12:46.365Z",
          updatedAt: "2024-04-16T12:12:46.365Z",
          bookmarked: true,
          author: true)
    ];

    shortPostList.value = dummy;
  }
}
