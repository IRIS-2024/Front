import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/view/controller/form/comment_form/comment_form_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showCommentFormDialog() {
  Get.dialog(
      barrierDismissible: false,
      const Dialog(
        child: CommentFormDialog(),
      ));
}

class CommentFormDialog extends StatelessWidget {
  const CommentFormDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: CustomPadding.dialogInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.processMatchingRate,
            style: CustomTextStyle.titleBold,
            textAlign: TextAlign.center,
          ),
          const Padding(padding: CustomPadding.mediumBottom),
          Stack(alignment: AlignmentDirectional.center, children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.file(
                  File(Get.put(CommentFormController()).images.first.path),
                  height: 200,
                  fit: BoxFit.fitHeight,
                )),
            const CircularProgressIndicator(),
          ]),
          const Padding(padding: CustomPadding.regularBottom),
          Text(
            AppLocalizations.of(context)!.indicatorMatchingRate,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
