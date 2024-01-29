import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iris_flutter/view/controller/google_map_service.dart';

class MapController {
  Rx<Position?> position = Rx<Position?>(null); // current location
  RxBool loading = false.obs;
  Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);
  RxString formattedAddress = ''.obs;

  void setInitialPosition() async { // 초기 현 위치 설정
    position.value = await _determinePosition();
    print('print positionValue: ${position.value}');
  }

  void selectLocation(LatLng loc) async { // 위치 선택
    loading.value = true;
    // reverse geocoding process
    formattedAddress.value = await GeocodingServices.getAddrFromLatlng(loc.latitude, loc.longitude);
    loading.value = false;
    selectedLocation.value = loc;
  }

  Future<Position> _determinePosition() async { // 현재 위치 받아오기 (서비스, 권한 확인)
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

}