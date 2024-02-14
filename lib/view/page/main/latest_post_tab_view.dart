import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/view/controller/main/main_controller.dart';
import 'package:iris_flutter/view/page/main/single_post_item.dart';

class LatestPostTabView extends StatefulWidget {
  const LatestPostTabView({Key? key}) : super(key: key);

  @override
  State<LatestPostTabView> createState() => _LatestPostTabViewState();
}

class _LatestPostTabViewState extends State<LatestPostTabView> {
  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    final mainController = Get.find<MainController>();

    return mainController.postList.isNotEmpty
        ? SizedBox(
            height: 180,
            child: ListView.builder(
                itemCount: mainController.postList.length,
                itemBuilder: (BuildContext context, int idx) {
                  return SinglePostItem(
                    post: mainController.postList[idx],
                    controller: mainController,
                  );
                }),
          )
        : const SizedBox();
  }
}
