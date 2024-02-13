import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/view/comm/custom_snackbar.dart';
import 'package:iris_flutter/view/page/main/latest_post_tab_view.dart';
import 'package:iris_flutter/view/page/main/map_tab_view.dart';
import 'package:iris_flutter/view/controller/map/map_controller.dart';

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
                  labelStyle: CustomTextStyle.basicBold,
                  indicator: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  tabs: const [
                    SizedBox(height: 40, child: Tab(text: "최신 글")),
                    SizedBox(height: 40, child: Tab(text: "지도"))
                  ],
                  controller: _nestedTabController,
                ),
              ),
              const Padding(padding: CustomPadding.slimRight),
              IconButton(
                  onPressed: () {
                    // update current location (Admin District)
                    Get.put(MapController()).getAdminDistrictAddress();
                    // updated
                    customSnackBar(title: '위치 갱신', message: '현 위치를 갱신하였습니다.', context: context);
                  },
                  icon: const Icon(Icons.my_location)),
            ],
          ),

          // tab View
          Expanded(
            child: Padding(
              padding: CustomPadding.slimBottom,
              child: TabBarView(
                controller: _nestedTabController,
                children: const [
                  // 최신 글
                  LatestPostTabView(),
                  // 지도
                  MapTabView()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
