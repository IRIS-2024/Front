
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/view/controller/info_form/info_form_controller.dart';

void infoFormDialog(BuildContext context) {
  Get.put(InfoFormController());
  final controller = Get.find<InfoFormController>();

  if (controller.dialogIndex.value == 0) { // 1: AI 이미지 생성 여부 묻기
    Get.dialog(Obx(
        ()=> Dialog(
          child: Padding(
            padding: CustomPadding.dialogInsets,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '작성하신 정보를 바탕으로\n이미지를 생성하시겠습니까?',
                  style: CustomTextStyle.titleBold,
                ),
                const Padding(padding: CustomPadding.mediumBottom),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    controller.nameController.text,
                    style: CustomTextStyle.basicBold.copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                const Padding(padding: CustomPadding.slimBottom),
                _titleAndInfo(
                  context: context,
                    title: '인적사항',
                    contents:
                    '${controller.selectedGender.value == Gender.man ? Config.man : Config.woman} / ${controller.ageController.text}세 / ${controller.heightController.text == '' ? '' : '${controller.heightController.text}cm'} / ${controller.weightController.text == '' ? '' : '${controller.weightController.text}kg'}'),
                _titleAndInfo(
                    context: context,
                    title: '마지막 위치', contents: controller.location.value!),
                _titleAndInfo(
                    context: context,
                    title: '옷차림', contents: controller.clothesController.text),
                _titleAndInfo(
                    context: context,
                    title: '특이사항', contents: controller.noteController.text),
                const Padding(padding: CustomPadding.thickBottom),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      _goToNextDialog(context);
                    }, child: Text('AI 이미지 생성하기'),style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),)),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      controller.registerInfo(context);
                    }, child: Text('AI 이미지 없이 등록하기'),)),
              ],
            ),
          )),
    ));
  } else if (controller.dialogIndex.value == 1) { // 2. 이미지 생성 중
    Get.dialog(Obx(
      ()=> Dialog(
          child: Padding(
            padding: CustomPadding.dialogInsets,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '작성하신 정보를 바탕으로\n이미지를 생성하는 중 입니다...',
                  style: CustomTextStyle.titleBold,
                ),
                const Padding(padding: CustomPadding.mediumBottom),
                // CircularProgressIndicator 추가
                ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.file(
                      File(controller.images.first.path),
                      height: 200,
                      fit: BoxFit.fitHeight,
                    )),
                ElevatedButton(onPressed: () {
                  _goToNextDialog(context);
                }, child: Text('임시 Dialog'))
              ],
            ),
          )),
    ));

  } else if (controller.dialogIndex.value == 2) { //3. 이미지 생성 완료 & 최종 등록
    Get.dialog(Obx(
      ()=> Dialog(
          child: Padding(
            padding: CustomPadding.dialogInsets,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '생성된 이미지를 함께\n등록하시겠습니까?',
                  style: CustomTextStyle.titleBold,
                ),
                const Padding(padding: CustomPadding.mediumBottom),
                ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.file(
                      File(controller.images[1].path),
                      height: 200,
                      fit: BoxFit.fitHeight,
                    )),
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {
                    }),
                    Text('대표 이미지로 사용')
                  ],
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      // AI 이미지 추가
                      controller.registerInfo(context);
                    }, child: Text('AI 이미지를 사용하여 등록하기'),style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),)),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      controller.registerInfo(context);
                    }, child: Text('AI 이미지 없이 등록하기'),)),
              ],
            ),
          )),
    ));

  }
}

_goToNextDialog(BuildContext context) {
  final controller = Get.find<InfoFormController>();
  Get.back();
  controller.dialogIndex.value += 1;
  infoFormDialog(context);
}

_titleAndInfo({required BuildContext context, required String title, required String contents}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 70,
        child: Text(
          title,
          style: TextStyle(color: Theme.of(context).colorScheme.outline),
        ),
      ),
      const Padding(padding: CustomPadding.slimRight),
      SizedBox(
          width: 180,
          child: Text(
            contents,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )),
    ],
  );
}