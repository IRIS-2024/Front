import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/view/page/form/basic_form.dart';

class TimeForm extends StatelessWidget {
  final String title;
  final dynamic controller;

  const TimeForm({Key? key, required this.title, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicForm(
        title: '실종 시각',
        isRequired: true,
        widget: Obx(
          () => Column(
            children: [
              OutlinedButton.icon(
                  onPressed: () async {
                    final TimeOfDay? timeOfDay = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (timeOfDay != null) {
                      controller.timeOfDay.value = timeOfDay;
                    }
                  },
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 55),
                      foregroundColor:
                          Theme.of(context).colorScheme.onBackground,
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  icon: const Icon(Icons.access_time),
                  label: Text(controller.timeOfDay.value == null
                      ? '위치 입력'
                      : '${controller.timeOfDay.value?.hour} : ${controller.timeOfDay.value?.hour}')),
              controller.timeOfDay.value == null &&
                      controller.initValidation.value != true
                  ? Column(
                      children: [
                        const Padding(padding: CustomPadding.slimBottom),
                        Text(
                          '시간을 입력해 주세요.',
                          style: CustomTextStyle.small.copyWith(
                              color: Theme.of(context).colorScheme.error),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ));
  }
}
