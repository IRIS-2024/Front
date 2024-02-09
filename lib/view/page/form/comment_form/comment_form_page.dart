import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/view/comm/custom_appbar.dart';
import 'package:iris_flutter/view/page/form/basic_form.dart';
import 'package:iris_flutter/view/controller/comment_form/comment_form_controller.dart';
import 'package:iris_flutter/view/page/form/image_carousel_form.dart';
import 'package:iris_flutter/view/page/form/register_button.dart';
import 'package:iris_flutter/view/page/form/text_form.dart';
import 'package:iris_flutter/view/page/map/map_page.dart';

class CommentFormPage extends StatefulWidget {
  const CommentFormPage({Key? key}) : super(key: key);

  @override
  State<CommentFormPage> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentFormPage> {
  @override
  Widget build(BuildContext context) {
    Get.put(CommentFormController());
    final commentController = Get.find<CommentFormController>();

    return Scaffold(
      appBar: customAppBar(
          title: '제보하기',
          actions: RegisterButton(onPressed: () {
            // validate image, time, location
            commentController.initValidation.value = false;
            if (commentController.images.isNotEmpty &&
                commentController.time.value != Config.enterTime &&
                commentController.location.value != null) {
              commentController.registerComment();
            }
          })),
      body: SingleChildScrollView(
        child: Padding(
          padding: CustomPadding.pageInsets,
          child: Column(
            children: [
              Card(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          commentController.missingImage.value,
                          height: 45,
                          width: 45,
                        ),
                      ),
                      const Padding(padding: CustomPadding.regularRight),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 120,
                        child: Text(
                            '${commentController.missingName.value} / ${commentController.missingGender.value} / ${commentController.missingAge.value} / ${commentController.missingLocation.value}',
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyle.basic),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(padding: CustomPadding.mediumBottom),
              // 제보 사진 추가
              ImageCarouselForm(
                title: '제보',
                controller: commentController,
              ),
              // 발견 당시 시간
              BasicForm(
                  title: '발견 당시 시간',
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
                              commentController.time.value =
                                  '${timeOfDay?.hour} : ${timeOfDay?.minute}';
                            },
                            style: OutlinedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 55),
                                foregroundColor: Theme.of(context).colorScheme.onBackground,
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            icon: const Icon(Icons.access_time),
                            label: Text(commentController.time.value)),
                        commentController.time.value == Config.enterTime &&
                                commentController.initValidation.value != true
                            ? Padding(
                                padding: CustomPadding.slimBottom,
                                child: Text(
                                  '시간을 입력해 주세요.',
                                  style: CustomTextStyle.small.copyWith(color: Theme.of(context).colorScheme.error),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  )),
              // 발견 당시 위치
              BasicForm(
                  title: '발견 당시 위치',
                  isRequired: true,
                  widget: Obx(
                    () => Column(
                      children: [
                        OutlinedButton.icon(
                            onPressed: () {
                              // 위치 받아온 다음,
                              Get.dialog(MapPage(
                                controller: commentController,
                              ));
                            },
                            style: OutlinedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 55),
                                foregroundColor: Theme.of(context).colorScheme.onBackground,
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            icon: const Icon(Icons.my_location),
                            label: Text(
                                commentController.location.value ?? '위치 입력')),
                        commentController.location.value == null &&
                                commentController.initValidation.value != true
                            ? Padding(
                                padding: CustomPadding.slimBottom,
                                child: Text(
                                  '위치를 입력해 주세요.',
                                  style: CustomTextStyle.small.copyWith(color: Theme.of(context)
                                      .colorScheme
                                      .error),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  )),
              // 발견 당시 옷차림
              TextForm(
                  textEditingController: commentController.clothesController,
                  title: '발견 당시 옷차림',
                  isRequired: false,
                  hintText: '상•하의 모양, 색상, 액세서리 등을 적어주세요.',
                  maxLength: 20),
              // 발견 당시 상황
              TextForm(
                textEditingController: commentController.clothesController,
                title: '발견 당시 상황',
                isRequired: false,
                hintText: '상•하의 모양, 색상, 액세서리 등을 적어주세요.',
                maxLength: 300,
                maxLengths: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
