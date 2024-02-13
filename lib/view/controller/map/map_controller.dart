import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iris_flutter/model/location.dart';
import 'package:iris_flutter/view/controller/map/map_service.dart';


class MapController {
  Rx<Position?> position = Rx<Position?>(null); // current location
  RxBool loading = false.obs;
  Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);
  Rx<String?> formattedAddress = Rx<String?>(null);
  Rx<String?> regionAddress = Rx<String?>(null);
  RxList<Location> markersList = <Location>[].obs;

  // * 둘다
  void setInitialPosition() async {
    // 초기 현 위치 설정
    position.value = await MapService.determinePosition();
    debugPrint('초기 현 위치: ${position.value}');
  }

  void selectLocation(LatLng loc) async {
    // reverse geocoding process
    formattedAddress.value = await MapService.getAddrFromLatlng(
        loc.latitude, loc.longitude);
    selectedLocation.value = loc;
  }

  // main map
  void getAdminDistrictAddress() async {
    // 초기 위치 찾기
    Position initPosition = await MapService.determinePosition();
    // (행정) 지역 주소 받아오기
    final fullAddress = await MapService.getAddrFromLatlng(
        initPosition.latitude, initPosition.longitude);

    // // 임시 현 위치 -----------
    // final fullAddress = await GoogleMapService.getAddrFromLatlng(
    //     37.545144, 126.964381);
    // // final fullAddress = await GoogleMapService.getFormattedAddress(
    // //     35.394032, 126.676373);
    // // ---------------

    final fullAddressList = fullAddress.split(' ');
    regionAddress.value =
        '${fullAddressList[1]} ${fullAddressList[2]}';
  }

  // main map
  void getMarkersDetails() {
    // 마커 받아오기
    markersList.value = [
      Location(location_id: 1, latitude: 37.545105, longitude: 126.966237, address: '대한민국 서울특별시 용산구 청파동2가 63-3번지'),
      Location(location_id: 2, latitude: 37.545729, longitude: 126.963611, address: '대한민국 서울특별시 청파동 어쩌구'),
    ];
  }


}
