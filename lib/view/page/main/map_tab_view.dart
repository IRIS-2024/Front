import 'package:flutter/material.dart';
import 'package:iris_flutter/view/page/map/map_with_markers.dart';

class MapTabView extends StatefulWidget {
  const MapTabView({Key? key}) : super(key: key);

  @override
  State<MapTabView> createState() => _MapTabViewState();
}

class _MapTabViewState extends State<MapTabView> {

  @override
  Widget build(BuildContext context) {
    return const MapWithMarkers();
  }
}
