import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/view/controller/form/form_map_contorller.dart';
import 'package:intl/intl.dart';

void showAddressInputMapDialog(dynamic controller) {
  Get.dialog(Dialog(
    child: AddressInputMapDialog(
      controller: controller,
    ),
  ));
}

class AddressInputMapDialog extends StatefulWidget {
  final dynamic controller;
  const AddressInputMapDialog({Key? key, required this.controller})
      : super(key: key);

  @override
  State<AddressInputMapDialog> createState() => _AddressInputMapDialogState();
}

class _AddressInputMapDialogState extends State<AddressInputMapDialog> {
  @override
  void initState() {
    super.initState();
    Get.put(FormMapController()).setInitialPosition();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(FormMapController());
    final formMapController = Get.find<FormMapController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(Intl.message('pickLocation')),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Obx(
          () => formMapController.initPosition.value == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                            formMapController.initPosition.value!.latitude,
                            formMapController.initPosition.value!.longitude,
                          ),
                          zoom: 17),
                      mapToolbarEnabled: false,
                      zoomControlsEnabled: false,
                      // min max zoom 제한
                      minMaxZoomPreference:
                          MinMaxZoomPreference(Config.minZoom, Config.maxZoom),
                      // 기울기 제스처 false
                      tiltGesturesEnabled: false,
                      // 현재 위치 표시 버튼 true
                      myLocationButtonEnabled: true,
                      // 현재 위치 표시 true
                      myLocationEnabled: true,
                      markers: formMapController.selectedPosition.value == null
                          ? {}
                          : {
                              Marker(
                                markerId: const MarkerId('selectedLocation'),
                                position:
                                    formMapController.selectedPosition.value!,
                              ),
                            },
                      onTap: (loc) {
                        log('선택한 위치의 위경도: ${loc.latitude} ${loc.longitude}');
                        formMapController.getAddressForSelectedPosition(loc);
                      },
                    ),
                    Positioned(
                      bottom: 100,
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: formMapController.address.value != null
                                ? _onButtonPressed
                                : null,
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: constraints.maxWidth - 100,
                              ),
                              child: Text(formMapController.address.value ??
                                  Intl.message('pickLocationPlz')),
                            ),
                          ),
                          formMapController.address.value != null
                              ? Material(
                                  child: Text(
                                    Intl.message('checkLocation'),
                                    style: CustomTextStyle.small,
                                  ),
                                )
                              : const SizedBox(
                                  height: 17,
                                )
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  void _onButtonPressed() {
    final formMapController = Get.put(FormMapController());
    // 주소 저장
    widget.controller.address.value = formMapController.address.value!;
    widget.controller.notiRegion.value = formMapController.notiRegion.value!;
    // 위도, 경도 저장
    widget.controller.latitude.value =
        formMapController.selectedPosition.value?.latitude;
    widget.controller.longitude.value =
        formMapController.selectedPosition.value?.longitude;
    Get.back();
  }
}
