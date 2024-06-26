import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/view/controller/main/main_controller.dart';
import 'package:iris_flutter/view/page/main/single_post_item.dart';
import 'package:intl/intl.dart';

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

    return FutureBuilder(
      future: mainController.getPositionAndPostList(),
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return mainController.shortPostList.isNotEmpty
            ? ListView.builder(
                itemCount: mainController.shortPostList.length,
                itemBuilder: (BuildContext context, int idx) {
                  return SinglePostItem(
                    post: mainController.shortPostList[idx],
                    controller: mainController,
                  );
                })
            : Center(child: Text(Intl.message('emptyInfo')));
      },
    );
  }
}
