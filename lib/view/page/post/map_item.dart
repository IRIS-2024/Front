import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/view/controller/post/post_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapItem extends StatefulWidget {
  const MapItem({super.key});

  @override
  State<MapItem> createState() => _MapItemState();
}

class _MapItemState extends State<MapItem> {
  PostController postController = Get.find<PostController>();
  late LatLng missingSpot;

  @override
  void initState() {
    super.initState();
    missingSpot = LatLng(postController.post.value.latitude,
        postController.post.value.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GoogleMap(
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
            Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer()),
          },
          initialCameraPosition:
              CameraPosition(target: missingSpot, zoom: Config.initZoom),
          mapToolbarEnabled: false,
          zoomControlsEnabled: false,
          minMaxZoomPreference:
              MinMaxZoomPreference(Config.minZoom, Config.maxZoom),
          // 기울기 제스처 false
          tiltGesturesEnabled: false,
          // 현재 위치 표시 버튼 true
          myLocationButtonEnabled: true,
          // 현재 위치 표시 true
          myLocationEnabled: true,
          markers: {
            Marker(
                markerId: const MarkerId('missing spot'),
                position: missingSpot,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue),
                infoWindow: InfoWindow(
                  title: AppLocalizations.of(context)!.missingLocation,
                  snippet: postController.post.value.address,
                )),
            ...postController.commentMarkers
          }),
    );
  }
}
