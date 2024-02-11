import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/view/comm/custom_appbar.dart';
import 'package:iris_flutter/view/controller/main/main_controller.dart';
import 'package:iris_flutter/view/page/main/single_info_item.dart';

class WrittenInfo extends StatefulWidget {
  const WrittenInfo({super.key});

  @override
  State<WrittenInfo> createState() => _WrittenInfoState();
}

class _WrittenInfoState extends State<WrittenInfo> {
  @override
  void initState() {
    Get.put(MainController()).setTmpData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    final mainController = Get.find<MainController>();

    return Scaffold(
        appBar: customAppBar(title: "작성한 실종 정보"),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: mainController.missingInfoList.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.only(top: 5, bottom: 20),
                    itemCount: mainController.missingInfoList.length,
                    itemBuilder: (BuildContext context, int idx) {
                      return SingleInfo(
                          missingInfo: mainController.missingInfoList[idx]);
                    })
                : const Center(
                    child: Text("작성한 실종 정보가 없습니다."),
                  )));
  }
}
