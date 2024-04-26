import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iris_flutter/config/region_list.dart';
import 'package:iris_flutter/utils/conversion_utils.dart';
import 'package:iris_flutter/view/comm/custom_snackbar.dart';
import 'package:iris_flutter/view/controller/map/reverse_geocoding_service.dart';
import 'package:iris_flutter/view/controller/map/map_service.dart';

class FormMapController {
  Rx<Position?> initPosition = Rx<Position?>(null); // current location
  Rx<LatLng?> selectedPosition = Rx<LatLng?>(null);
  Rx<String?> address = Rx<String?>(null);
  Rx<String?> notiRegion = Rx<String?>(null);

  void setInitialPosition() async {
    // 초기 현 위치 설정
    initPosition.value = await MapService.determinePosition();
  }

  void getAddressForSelectedPosition(LatLng loc) async {
    // reverse geocoding process
    final result = await ReverseGeocodingService.getAddrFromLatlng(
        loc.longitude, loc.latitude);
    if (result != null) {
      address.value = convertRegionNameToShort(result.address_name);
      selectedPosition.value = loc;

      final shortRegion1D = convertRegionNameToShort(result.region_1depth_name);
      if (region1DepthWithout2Depth.contains(shortRegion1D)) {
        notiRegion.value = shortRegion1D;
      } else {
        notiRegion.value = '${shortRegion1D} ${result.region_2depth_name}';
      }

      log('address.value: ${address.value}');
      log('notiRegion.value: ${notiRegion.value}');
    } else {
      customErrorSnackBar(title: '반환된 주소 없음', message: '근처 위치로 다시 시도 해주세요.');
      address.value = null;
      selectedPosition.value = null;
      notiRegion.value = null;
    }
  }
}
