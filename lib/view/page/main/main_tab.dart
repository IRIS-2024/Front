import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/view/comm/custom_snackbar.dart';
import 'package:iris_flutter/view/controller/main/main_controller.dart';
import 'package:iris_flutter/view/page/main/latest_info_tab_view.dart';
import 'package:iris_flutter/view/page/main/map_tab_view.dart';

class MainTab extends StatefulWidget {
  const MainTab({Key? key}) : super(key: key);

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab>
    with TickerProviderStateMixin {
  late TabController _nestedTabController;

  @override
  void initState() {
    _nestedTabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _nestedTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TabBar(
                  labelColor: Theme.of(context).colorScheme.onPrimaryContainer,
                  labelStyle:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  indicator: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  indicatorSize: TabBarIndicatorSize.tab,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 3,
                  ),
                  overlayColor: MaterialStatePropertyAll(Colors.transparent),
                  tabs: [
                    SizedBox(height: 40, child: Tab(text: "최신 글")),
                    SizedBox(height: 40, child: Tab(text: "지도"))
                  ],
                  controller: _nestedTabController,
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 5)),
              IconButton(
                  onPressed: () {
                    // update current location

                    // updated
                    customSnackBar(title: '위치 갱신', message: '현 위치를 갱신하였습니다.', context: context);
                  },
                  icon: Icon(Icons.my_location)),
            ],
          ),

          // tab View
          Expanded(
            child: TabBarView(
              controller: _nestedTabController,
              children: [
                // 최신 글
                LatestInfoTabView(),
                // 지도
                MapTabView()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
