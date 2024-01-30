import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iris_flutter/view/page/map/map_controller.dart';

class MapPage extends StatefulWidget {
  final dynamic controller;
  const MapPage({Key? key, required this.controller}) : super(key: key);

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
      () => mapController.position.value == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
            child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                              // mapController.position.value!.latitude,
                              // mapController.position.value!.longitude,
                              // 임시 현 위치
                              // 37.545144,
                              // 126.964381
                              // 임시 현 위치2
                              35.394032,
                              126.676373),
                          zoom: 17),
                      onTap: (loc) {
                        debugPrint(
                            'print locLongitude: ${loc.latitude} ${loc.longitude}');
                        mapController.selectLocation(loc);
                      },
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
                  ),
                  Positioned(
                    bottom: 100,
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: mapController.formattedAddress.value != null
                          ? _onButtonPressed : null,
                          child:
                          Text(mapController.formattedAddress.value ?? '위치를 선택해 주세요.'),
                        ),
                        mapController.formattedAddress.value != null
                        ? const Material(
                          child: Text('이 위치를 등록하시려면 버튼을 눌러주세요.',
                          style: TextStyle(
                            fontSize: 12
                          ),),
                        ) : const SizedBox(height: 17,
                        )
                      ],
                    ),
                  )
                ],
              ),
          ),
    );

  }

  void _onButtonPressed() {
    widget.controller.location.value = Get.put(MapController()).formattedAddress.value!;
    Get.back();
  }
}
