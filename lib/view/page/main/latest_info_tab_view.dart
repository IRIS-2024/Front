import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/view/controller/main/main_controller.dart';
import 'package:iris_flutter/view/page/main/single_info_item.dart';

class LatestInfoTabView extends StatefulWidget {
  const LatestInfoTabView({Key? key}) : super(key: key);

  @override
  State<LatestInfoTabView> createState() => _LatestInfoTabViewState();
}

class _LatestInfoTabViewState extends State<LatestInfoTabView> {
  @override
  void initState() {
    Get.put(MainController()).setTmpData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    final mainController = Get.find<MainController>();

    return mainController.missingInfoList.isNotEmpty
        ? SizedBox(
            height: 180,
            child: ListView.builder(
                itemCount: mainController.missingInfoList.length,
                itemBuilder: (BuildContext context, int idx) {
                  return SingleInfoItem(
                    info: mainController.missingInfoList[idx],
                    controller: mainController,
                  );
                }),
          )
        : const SizedBox();
  }
}
