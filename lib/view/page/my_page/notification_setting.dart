import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/config/region_list.dart';
import 'package:iris_flutter/view/comm/custom_appbar.dart';
import 'package:iris_flutter/view/controller/my_page/notification_setting_controller.dart';
import 'package:iris_flutter/view/page/form/submit_button.dart';
import 'package:intl/intl.dart';

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({super.key});

  @override
  State<NotificationSetting> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  @override
  void initState() {
    Get.put(NotificationSettingController()).getSetting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationSettingController());
    final notiController = Get.find<NotificationSettingController>();

    return Scaffold(
      appBar: customAppBar(
          title: Intl.message('pushSettings'),
          actions: Obx(() => SubmitButton(
            onPressed: notiController.selectedRegion2D.value != '' ||
                region1DepthWithout2Depth
                    .contains(notiController.selectedRegion1D.value) ||
                notiController.isSwitched.value == false
                ? () {
              Get.put(NotificationSettingController()).saveSetting();
            }
                : null,
          ))),
      body: Padding(
        padding: CustomPadding.pageInsets,
        child: Obx(() => Column(
          children: [
            SwitchListTile(
              title: Text(Intl.message('addMissingPost')),
              subtitle: Text(Intl.message('newMissingPost')),
              value: notiController.isSwitched.value,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              tileColor: Theme.of(context).colorScheme.surfaceVariant,
              onChanged: (value) {
                setState(() {
                  notiController.isSwitched.value = value;
                  notiController.selectedRegion1D.value = '';
                  notiController.selectedRegion2D.value = '';
                });
              },
            ),

            // 관심 지역 설정 리스트
            if (notiController.isSwitched.value)
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25, left: 10, bottom: 5),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(Intl.message('selectInterest'))),
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
                              _titleWidget(Intl.message('firstArea')),
                              VerticalDivider(
                                width: 0,
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                              ),
                              _titleWidget(Intl.message('secondArea')),
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
                                        bool isSelected = notiController
                                            .selectedRegion1D.value ==
                                            region1DepthList[idx];

                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              notiController
                                                  .selectedRegion1D.value =
                                              region1DepthList[idx];
                                              notiController
                                                  .selectedRegion2D.value = '';
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
                                                    colorScheme.background: isSelected
                                                    // ? Colors.white
                                                        ? Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary
                                                        : Colors.black),
                                              )),
                                        )
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
                                  child: notiController
                                      .selectedRegion1D.value !=
                                      ''
                                      ? region1DepthWithout2Depth.contains(
                                      notiController.selectedRegion1D
                                          .value) // 시단구 단위 없는 경우
                                      ? Container(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .outlineVariant,
                                    height: 40,
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      '-',
                                      style: CustomTextStyle.basic
                                          .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outline),
                                    ),
                                  )
                                      : ListView.builder(
                                      padding: const EdgeInsets.only(
                                          bottom: 10),
                                      itemCount: regionMap[
                                      notiController
                                          .selectedRegion1D
                                          .value]
                                          .length,
                                      itemBuilder:
                                          (BuildContext context,
                                          int idx) {
                                        bool isSelected = notiController
                                            .selectedRegion2D
                                            .value ==
                                            regionMap[notiController
                                                .selectedRegion1D
                                                .value][idx];

                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              notiController
                                                  .selectedRegion2D
                                                  .value =
                                              regionMap[notiController
                                                  .selectedRegion1D
                                                  .value][idx];
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
                                              alignment:
                                              Alignment.centerLeft,
                                              child: Text(
                                                '${regionMap[notiController.selectedRegion1D.value][idx]}',
                                                style: CustomTextStyle
                                                    .basic
                                                    .copyWith(
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
        )),
      ),
    );
  }

  _titleWidget(String text) {
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
