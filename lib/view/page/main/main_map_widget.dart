import 'package:flutter/material.dart';

class MainMapWidget extends StatefulWidget {
  const MainMapWidget({Key? key}) : super(key: key);

  @override
  State<MainMapWidget> createState() => _MainMapWidgetState();
}

class _MainMapWidgetState extends State<MainMapWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 20),
      child: Column(
        children: [
          Text('지도 탭 뷰')
        ],
      ),
    );
  }
}
