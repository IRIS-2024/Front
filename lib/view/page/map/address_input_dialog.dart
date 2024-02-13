import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/view/controller/map/map_controller.dart';

void addressInputDialog(dynamic controller) {
  Get.dialog(AddressInputMap(
    controller: controller,
  ));
}

class AddressInputMap extends StatefulWidget {
  final dynamic controller;
  const AddressInputMap({Key? key, required this.controller}) : super(key: key);

  @override
  State<AddressInputMap> createState() => _AddressInputMapState();
}

class _AddressInputMapState extends State<AddressInputMap> {
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
                          style: CustomTextStyle.small,),
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
    final mapController = Get.put(MapController());
    // 주소 저장
    widget.controller.address.value = mapController.formattedAddress.value!;
    // 위도, 경도 저장
    widget.controller.latitude.value = mapController.selectedLocation.value?.latitude;
    widget.controller.longitude.value = mapController.selectedLocation.value?.longitude;
    Get.back();
  }
}
