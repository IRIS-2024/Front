import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/config/region_list.dart';
import 'package:iris_flutter/view/comm/custom_appbar.dart';
import 'package:iris_flutter/view/comm/custom_snackbar.dart';
import 'package:iris_flutter/view/controller/my_page/notification_setting_controller.dart';
import 'package:iris_flutter/view/page/form/submit_button.dart';

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({super.key});

  @override
  State<NotificationSetting> createState() =>
      _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  String selectedRegion1D = '';
  String selectedRegion2D = '';
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: '알림 설정',
          actions: SubmitButton(
            onPressed: selectedRegion2D != '' ||
                    region1DepthWithout2Depth.contains(selectedRegion1D) || isSwitched == false
                ? () {
                    Get.put(NotificationSettingController()).saveSetting(isSwitched, selectedRegion1D, selectedRegion2D);

                    // customSnackBar(title: '설정 저장', message: '설정 저장이 완료되었습니다.');
                  }
                : null,
          )),
      body: Padding(
        padding: CustomPadding.pageInsets,
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('실종 정보 등록'),
              subtitle: const Text('관심 지역의 새로운 실종 정보'),
              value: isSwitched,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              tileColor: Theme.of(context).colorScheme.surfaceVariant,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                  selectedRegion1D = '';
                  selectedRegion2D = '';
                });
              },
            ),

            // 관심 지역 설정 리스트
            if (isSwitched)
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 25, left: 10, bottom: 5),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('관심 지역 선택')),
                  ),
                  Column(
                    children: [
                      // 제목
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant
                                .withOpacity(0.4),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0))),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              titleWidget('시﹒도'),
                              VerticalDivider(
                                width: 0,
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                              ),
                              titleWidget('시﹒군﹒구'),
                            ],
                          ),
                        ),
                      ),
                      // 리스트
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0))),
                        child: IntrinsicHeight(
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // 시도
                              Flexible(
                                flex: 1,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height - 310,
                                  child: ListView.builder(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      itemCount: region1DepthList.length,
                                      itemBuilder:
                                          (BuildContext context, int idx) {
                                        bool isSelected = selectedRegion1D ==
                                            region1DepthList[idx];

                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedRegion1D =
                                                  region1DepthList[idx];
                                              selectedRegion2D = '';
                                            });
                                          },
                                          child: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              color: isSelected
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                      .withOpacity(0.5)
                                                  : Colors.transparent,
                                              height: 40,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                region1DepthList[idx],
                                                style: CustomTextStyle.basic
                                                    .copyWith(
                                                        color: isSelected
                                                            // ? Colors.white
                                                            ? Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onPrimary
                                                            : Colors.black),
                                              )),
                                        );
                                      }),
                                ),
                              ),
                              VerticalDivider(
                                width: 0,
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                              ),
                              // 시군구
                              Flexible(
                                flex: 1,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height - 310,
                                  child: selectedRegion1D != ''
                                      ? region1DepthWithout2Depth
                                              .contains(selectedRegion1D) // 시단구 단위 없는 경우
                                          ? Container(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .outlineVariant,
                                              height: 40,
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                '-', style: CustomTextStyle.basic.copyWith(
                                                  color: Theme.of(
                                                      context)
                                                      .colorScheme
                                                      .outline
                                                      ),), )
                                          : ListView.builder(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              itemCount:
                                                  regionMap[selectedRegion1D]
                                                      .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int idx) {
                                                bool isSelected =
                                                    selectedRegion2D ==
                                                        regionMap[
                                                                selectedRegion1D]
                                                            [idx];

                                                return InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      selectedRegion2D = regionMap[
                                                              selectedRegion1D]
                                                          [idx];
                                                    });
                                                  },
                                                  child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      color: isSelected
                                                          ? Theme.of(context)
                                                              .colorScheme
                                                              .primary
                                                              .withOpacity(0.3)
                                                          : Colors.transparent,
                                                      height: 40,
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(
                                                        '${regionMap[selectedRegion1D][idx]}',
                                                        style: CustomTextStyle.basic.copyWith(
                                                            color: isSelected
                                                                ? Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary
                                                                : Colors
                                                                    .black),
                                                      )),
                                                );
                                              })
                                      : const SizedBox(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  titleWidget(String text) {
    return SizedBox(
      height: 45,
      width: 100,
      child: Center(
        child: Text(
          text,
          style: CustomTextStyle.basicBold,
        ),
      ),
    );
  }
}
