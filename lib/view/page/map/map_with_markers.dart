import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/view/controller/main/main_controller.dart';
import 'package:iris_flutter/view/controller/map/map_controller.dart';

class MapWithMarkers extends StatefulWidget {
  const MapWithMarkers({Key? key}) : super(key: key);

  @override
  State<MapWithMarkers> createState() => _MapWithMarkersState();
}

class _MapWithMarkersState extends State<MapWithMarkers> {
  @override
  void initState() {
    Get.put(MapController()).setInitialPosition();
    // 마커 받아오기 - 임시
    Get.put(MainController()).setTmpMarkerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(MapController());
    final mapController = Get.find<MapController>();
    Get.put(MainController());
    final mainController = Get.find<MainController>();

    return Obx(() => mapController.position.value == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(
                  mapController.position.value!.latitude,
                  mapController.position.value!.longitude,
                ),
                zoom: Config.initZoom),
            minMaxZoomPreference: MinMaxZoomPreference(Config.minZoom, Config.maxZoom),
            // 기울기 제스처 false
            tiltGesturesEnabled: false,
            // 현재 위치 표시 버튼 true
            myLocationButtonEnabled: true,
            // 현재 위치 표시 true
            myLocationEnabled: true,
            padding: const EdgeInsets.only(bottom: 55),
            markers: mainController.markerList
                .map((post) => Marker(
                      markerId: MarkerId('0'), // pid
                      position: LatLng(post.latitude, post.longitude),
                      infoWindow: InfoWindow(
                          title: post.name,
                          snippet: '성별 / ${post.age}세/ ${post.address}',
                          onTap: () {
                            Get.dialog(const Dialog(
                              child: Text('MarkerDialog'),
                            ));
                          }),
                    ))
                .toSet(),
            onCameraMove: (CameraPosition position) {
              print('print position: ${position}');
            },
            onCameraIdle: () {
              // api 재 출력
              print('print api: 재출력');
            },
          ));
  }
}
