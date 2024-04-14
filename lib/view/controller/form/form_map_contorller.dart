import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iris_flutter/view/controller/map/kakao_geocoding_service.dart';
import 'package:iris_flutter/view/controller/map/map_service.dart';

class FormMapController {
  Rx<Position?> initPosition = Rx<Position?>(null); // current location
  Rx<LatLng?> selectedPosition = Rx<LatLng?>(null);
  Rx<String?> address = Rx<String?>(null);

  void setInitialPosition() async {
    // 초기 현 위치 설정
    initPosition.value = await MapService.determinePosition();
  }

  void getAddressForSelectedPosition(LatLng loc) async {
    // reverse geocoding process
    final result = await KakaoGeocodingService.getAddrFromLatlng(loc.longitude, loc.latitude);
    if (result != null) {
      address.value = result.address_name;
      selectedPosition.value = loc;

      // 추후 post api에 포함될 값
      log('result.region_1depth_name: ${result.region_1depth_name}');
      log('result.region_2depth_name: ${result.region_2depth_name}');
    }
  }
}