import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/view/comm/custom_appbar.dart';
import 'package:iris_flutter/view/controller/form/comment_form/comment_form_controller.dart';
import 'package:iris_flutter/view/page/form/address_form.dart';
import 'package:iris_flutter/view/page/form/image_carousel_form.dart';
import 'package:iris_flutter/view/page/form/submit_button.dart';
import 'package:iris_flutter/view/page/form/text_form.dart';
import 'package:iris_flutter/view/page/form/time_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommentFormPage extends StatefulWidget {
  const CommentFormPage({Key? key}) : super(key: key);

  @override
  State<CommentFormPage> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentFormPage> {
  @override
  void initState() {
    log('Get.arguments: ${Get.arguments}');
    Get.put(CommentFormController()).savePostData(Get.arguments);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(CommentFormController());
    final commentController = Get.find<CommentFormController>();

    return Scaffold(
      appBar: customAppBar(
          title: AppLocalizations.of(context)!.submitTip,
          actions: SubmitButton(onPressed: () {
            // validate image, time, location
            commentController.initValidation.value = false;
            if (commentController.validateRequiredFields()) {
              commentController.submitComment();
            }
          })),
      body: SingleChildScrollView(
        child: Padding(
          padding: CustomPadding.pageInsets,
          child: Column(
            children: [
              // 실종 정보 글 간략 정보 보여주는 Card
              Card(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          commentController.postImage.value,
                          height: 45,
                          width: 45,
                        ),
                      ),
                      const Padding(padding: CustomPadding.regularRight),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 120,
                        child: Text(
                            '${commentController.postName.value} / ${Config().getGenderText(commentController.postGender.value)} / ${commentController.postAge.value}${AppLocalizations.of(context)!.ageunit} / ${commentController.postAddress.value}',
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
                title: AppLocalizations.of(context)!.comment,
                controller: commentController,
              ),
              // 발견 당시 시간
              TimeForm(
                  title: AppLocalizations.of(context)!.commentTime,
                  controller: commentController),
              // 발견 당시 위치
              AddressForm(
                  title: AppLocalizations.of(context)!.commentLocation,
                  controller: commentController),
              // 발견 당시 옷차림
              TextForm(
                  textEditingController: commentController.clothesController,
                  title: AppLocalizations.of(context)!.commentClothing,
                  isRequired: false,
                  hintText: AppLocalizations.of(context)!.commentClothingHint,
                  maxLength: 20),
              // 발견 당시 상황
              TextForm(
                textEditingController: commentController.detailsController,
                title: AppLocalizations.of(context)!.commentCircumstances,
                isRequired: false,
                hintText:
                    AppLocalizations.of(context)!.commentCircumstancesHint,
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
