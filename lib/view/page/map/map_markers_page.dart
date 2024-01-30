import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/view/page/map/map_controller.dart';

class MapMarkersPage extends StatefulWidget {
  const MapMarkersPage({Key? key}) : super(key: key);

  @override
  State<MapMarkersPage> createState() => _MapMarkersPageState();
}

class _MapMarkersPageState extends State<MapMarkersPage> {
  @override
  void initState() {
    Get.put(MapController()).setInitialPosition();
    // 마커 받아오기
    Get.put(MapController()).getMarkersDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(MapController());
    final mapController = Get.find<MapController>();

    return Obx(() => mapController.position.value == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : GoogleMap(
            padding: const EdgeInsets.only(bottom: 55),
            initialCameraPosition: CameraPosition(
                target: LatLng(
                    // mapController.position.value!.latitude,
                    // mapController.position.value!.longitude,
                    // 임시 현 위치
                    37.545144,
                    126.964381
                    // 임시 현 위치2
                    // 35.394032,
                    // 126.676373
                    ),
                zoom: 17),
            onTap: (loc) {
              debugPrint(
                  'print locLongitude: ${loc.latitude} ${loc.longitude}');
              mapController.selectLocation(loc);
            },
            markers: mapController.markersList
                .map((location) => Marker(
                    markerId: MarkerId(location.location_id.toString()),
                    position: LatLng(location.latitude, location.longitude),
                    infoWindow:
                        InfoWindow(title: location.address, snippet: '얍'),
                    onTap: () {
                      Get.dialog(Dialog(
                        child: Text('MarkerDialog'),
                      ));
                    }))
                .toSet(),
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
          ));
  }
}
