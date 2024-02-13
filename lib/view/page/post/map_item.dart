import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iris_flutter/view/controller/post/detail_controller.dart';
import 'package:location/location.dart';

class MapItem extends StatefulWidget {
  const MapItem({super.key});

  @override
  State<MapItem> createState() => _MapItemState();
}

class _MapItemState extends State<MapItem> {
  final Location _locationController = Location();
  DetailController detailController = Get.find<DetailController>();

  LatLng? _currentP;
  late LatLng _pGooglePlex;
  late LatLng _pParkPlex;

  @override
  void initState() {
    super.initState();
    _pGooglePlex = LatLng(detailController.post.value.latitude,
        detailController.post.value.longitude);
    _pParkPlex = LatLng(detailController.post.value.latitude,
        detailController.post.value.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: _pGooglePlex, zoom: 17),
      markers: {
        Marker(
            markerId: const MarkerId("_currentLocation"),
            icon: BitmapDescriptor.defaultMarker,
            position: _pGooglePlex),
        Marker(
            markerId: const MarkerId("_sourceLocation"),
            icon: BitmapDescriptor.defaultMarker,
            position: _pParkPlex)
      },
    );
  }

  Future<void> getLocationUpdates() async {
    // 사용자의 위치에 맞게
    bool serviceEnabled;
    PermissionStatus permissionsGranted;

    // 사용자가 위치 사용을 허락했으면
    serviceEnabled = await _locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    permissionsGranted = await _locationController.hasPermission();
    if (permissionsGranted == PermissionStatus.denied) {
      permissionsGranted = await _locationController.requestPermission();

      if (permissionsGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });
        print(_currentP);
      }
    });
  }
}
