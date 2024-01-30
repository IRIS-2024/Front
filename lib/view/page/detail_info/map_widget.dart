// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
//
// class MapWidget extends StatefulWidget {
//   const MapWidget({super.key});
//
//   @override
//   State<MapWidget> createState() => _MapWidgetState();
// }
//
// class _MapWidgetState extends State<MapWidget> {
//   final Location _locationController = Location();
//
//   static const LatLng _pGooglePlex = LatLng(37.545042, 126.965879);
//   static const LatLng _pParkPlex = LatLng(37.543489, 126.966199);
//   LatLng? _currentP;
//   @override
//   void initState() {
//     super.initState();
//     // getLocationUpdates();  // 사용자의 현재 위치에 기반하여 화면을 바꿀 때
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GoogleMap(
//       initialCameraPosition:
//           const CameraPosition(target: _pGooglePlex, zoom: 17),
//       markers: {
//         const Marker(
//             markerId: MarkerId("_currentLocation"),
//             icon: BitmapDescriptor.defaultMarker,
//             position: _pGooglePlex),
//         const Marker(
//             markerId: MarkerId("_sourceLocation"),
//             icon: BitmapDescriptor.defaultMarker,
//             position: _pParkPlex)
//       },
//     );
//   }
//
//   Future<void> getLocationUpdates() async {
//     // 사용자의 위치에 맞게
//     bool serviceEnabled;
//     PermissionStatus permissionsGranted;
//
//     // 사용자가 위치 사용을 허락했으면
//     serviceEnabled = await _locationController.serviceEnabled();
//     if (serviceEnabled) {
//       serviceEnabled = await _locationController.requestService();
//     } else {
//       return;
//     }
//
//     permissionsGranted = await _locationController.hasPermission();
//     if (permissionsGranted == PermissionStatus.denied) {
//       permissionsGranted = await _locationController.requestPermission();
//
//       if (permissionsGranted != PermissionStatus.granted) {
//         return;
//       }
//     }
//
//     _locationController.onLocationChanged
//         .listen((LocationData currentLocation) {
//       if (currentLocation.latitude != null &&
//           currentLocation.longitude != null) {
//         setState(() {
//           _currentP =
//               LatLng(currentLocation.latitude!, currentLocation.longitude!);
//         });
//         print(_currentP);
//       }
//     });
//   }
// }
