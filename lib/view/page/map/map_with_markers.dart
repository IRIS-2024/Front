import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/view/controller/main/main_controller.dart';

class MapWithMarkers extends StatefulWidget {
  const MapWithMarkers({Key? key}) : super(key: key);

  @override
  State<MapWithMarkers> createState() => _MapWithMarkersState();
}

class _MapWithMarkersState extends State<MapWithMarkers> {
  late LatLng cameraPosition;

  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    final mainController = Get.find<MainController>();

    return Obx(() => mainController.initPosition.value == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                      mainController.initPosition.value!.latitude,
                      mainController.initPosition.value!.longitude,
                    ),
                    zoom: Config.initZoom),
                // min max zoom 제한
                minMaxZoomPreference:
                    MinMaxZoomPreference(Config.minZoom, Config.maxZoom),
                // 기울기 제스처 false
                tiltGesturesEnabled: false,
                // 현재 위치 표시 버튼 true
                myLocationButtonEnabled: true,
                // 현재 위치 표시 true
                myLocationEnabled: true,
                // 위치 버튼과 신고하기 floatingButton 겹치지 않게 padding 설정
                padding: const EdgeInsets.only(bottom: 55),
                markers: mainController.postList
                    .map((shortPost) => Marker(
                          markerId: MarkerId('${shortPost.pid}'),
                          position:
                              LatLng(shortPost.latitude, shortPost.longitude),
                          infoWindow: InfoWindow(
                              title: shortPost.name,
                              snippet:
                                  '${Config().getGenderText(shortPost.gender)} / ${shortPost.age}세/ ${shortPost.address}',
                              onTap: () {
                                Get.dialog(const Dialog(
                                  child: Text('MarkerDialog'),
                                ));
                              }),
                        ))
                    .toSet(),
                onCameraMove: (CameraPosition position) {
                  setState(() {
                    cameraPosition = position.target;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                    onPressed: () {
                      print('print: 실종 정보 재로딩');
                      mainController.loadPostList(
                          cameraPosition.latitude, cameraPosition.longitude);
                    },
                    child: const Text('이 위치에서 재검색하기')),
              )
            ],
          ));
  }
}
