import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iris_flutter/view/page/map/map_controller.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    super.initState();
    Get.put(MapController()).setInitialPosition();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(MapController());
    final mapController = Get.find<MapController>();

    return Obx(
      () => Scaffold(
        body: mapController.position.value == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
          alignment: Alignment.center,
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(
                            // mapController.position.value!.latitude,
                            // mapController.position.value!.longitude,
                            // 임시 현 위치
                            // 37.545144,
                            // 126.964381
                            // 임시 현 위치2
                          35.394032,
                          126.676373

                        ),
                        zoom: 17),
                    onTap: (loc) {
                      print(
                          'print locLongitude: ${loc.latitude} ${loc.longitude}');
                      mapController.selectLocation(loc);
                    },
                    // onMapCreated: (GoogleMapController controller) {
                    //   _controller.complete(controller);
                    // },
                    markers: mapController.selectedLocation.value == null
                        ? {}
                        : {
                            Marker(
                              markerId: MarkerId('selectedLocation'),
                              position: mapController.selectedLocation.value!,
                              infoWindow: InfoWindow(
                                title: '선택된 위치',
                                snippet: 'ddd',
                              ),
                            ),
                          },
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                  ),
                  Positioned(
                    bottom: 100,
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Text(mapController.formattedAddress.value == ''
                            ? '위치를 선택해 주세요.'
                            : '${mapController.formattedAddress.value}\n이 위치를 등록하시려면 버튼을 눌러주세요.')),
                  )
                ],
              ),
      ),
    );
  }
}
