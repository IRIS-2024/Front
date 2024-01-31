import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/model/missing_info.dart';
import 'package:iris_flutter/view/controller/main/main_controller.dart';

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
            return singleInfo(
                mainController.missingInfoList[idx]);
          }
      ),
    )
    : const SizedBox();

  }

  singleInfo(MissingInfo missingInfo) {
    return Padding(
      padding: CustomPadding.thickBottom,
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset('assets/images/exImage.png', height: 170, width: 380, fit: BoxFit.fitWidth,)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${missingInfo.missingName} / ${missingInfo.missingAge}세 / ${missingInfo.missingLocation}",
                style: CustomTextStyle.title,),
              IconButton(onPressed: () {
              }, icon: const Icon(Icons.bookmark_border_outlined))
            ],
          ),
          Row(
            children: [
              Icon(Icons.access_time, size: 18, color: Theme.of(context).colorScheme.outline,),
              const Padding(padding: CustomPadding.slimRight),
              Text('24분전', style: TextStyle(
                  color: Theme.of(context).colorScheme.outline
              ),),
            ],
          )
        ],
      ),
    );
  }
}
