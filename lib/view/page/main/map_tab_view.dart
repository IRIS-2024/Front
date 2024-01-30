import 'package:flutter/material.dart';
import 'package:iris_flutter/view/page/map/map_markers_page.dart';

class MapTabView extends StatefulWidget {
  const MapTabView({Key? key}) : super(key: key);

  @override
  State<MapTabView> createState() => _MapTabViewState();
}

class _MapTabViewState extends State<MapTabView> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 20),
      child: MapMarkersPage(),
    );
  }
}
