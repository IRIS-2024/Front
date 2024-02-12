import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/view/controller/info_form/info_form_controller.dart';

void infoFormDialog(BuildContext context) {
  Get.put(InfoFormController());
  final controller = Get.find<InfoFormController>();

  Future<void> createAIImage() async {
    // TODO 임시 딜레이
    await Future.delayed(const Duration(milliseconds: 3000));
  }

  Get.dialog(
    Dialog(
        child: Padding(
      padding: CustomPadding.dialogInsets,
      child: FutureBuilder(
        future: createAIImage(),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '작성하신 정보를 바탕으로',
                  style: CustomTextStyle.titleBold,
                ),
                const Text(
                  '이미지를 생성하는 중 입니다...',
                  style: CustomTextStyle.titleBold,
                ),
                const Padding(padding: CustomPadding.mediumBottom),
                Stack(alignment: AlignmentDirectional.center, children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.file(
                        File(controller.images.first.path),
                        height: 200,
                        fit: BoxFit.fitHeight,
                      )),
                  const CircularProgressIndicator(),
                ]),
              ],
            );
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '생성된 이미지를 함께',
                style: CustomTextStyle.titleBold,
              ),
              const Text(
                '등록하시겠습니까?',
                style: CustomTextStyle.titleBold,
              ),
              const Padding(padding: CustomPadding.mediumBottom),
              ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.file(
                    File(controller.images.first.path),
                    // TODO 생성된 AI 이미지로 변경
                    height: 200,
                    fit: BoxFit.fitHeight,
                  )),
              Obx(
                () => CheckboxMenuButton(
                  value: controller.isChecked.value,
                  onChanged: (value) {
                    controller.isChecked.value = value!;
                  },
                  child: const Text('대표 이미지로 사용하기'),
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // AI 이미지 추가
                      controller.registerInfo(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      foregroundColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    child: const Text('등록하기'),
                  )),
            ],
          );
        },
      ),
    )),
  );
}
