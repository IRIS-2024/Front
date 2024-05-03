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
    final result = await ReverseGeocodingService.getAddrFromLatlng(
        currentPosition.longitude, currentPosition.latitude);
    if (result != null) {
      shortAddress.value =
          '${result.region_1depth_name} ${result.region_2depth_name}';
    }
  }

  Future loadPostList(double latitude, double longitude) async {
    final dio = createDio();
    PostRepository postRepository = PostRepository(dio);
    await postRepository
        .getPostList(latitude, longitude, 'ALL', 0, 0)
        .then((resp) {
      shortPostList.value = resp;
    }).catchError((error) {
      log('[catchError]: $error');
    });
  }
}
