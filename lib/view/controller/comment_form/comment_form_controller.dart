import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/view/page/form/comment_form/registering_comment_page.dart';

class CommentFormController {
  // validate
  RxBool initValidation = true.obs;

  // 실종 정보 일부 데이터 - 대표 사진, 이름, 성별, 나이, 주소
  RxString missingImage = 'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg'.obs;
  RxString missingName = '김말순'.obs;
  RxString missingGender = '여자'.obs;
  RxString missingAge = '85세'.obs;
  RxString missingLocation = '용산구 갈월동'.obs;

  // 제보 댓글 - 제보 사진, 시간, 위치, 옷차림, 상황
  RxList<XFile> images = <XFile>[].obs;
  RxString time = Config.enterTime.obs;
  Rx<String?> location = Rx<String?>(null);
  RxString clothes = ''.obs;
  TextEditingController clothesController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  void registerComment() {
    print('print : regesterComment');
    Get.to(()=>RegisteringCommentPage());
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    await picker.pickMultiImage().then((value) {
      images += value;
    });
  }
}