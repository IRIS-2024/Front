import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/repository/comment_repository.dart';
import 'package:iris_flutter/utils/conversion_utils.dart';
import 'package:iris_flutter/view/page/form/comment_form/registering_comment_page.dart';
import 'package:dio/dio.dart' as dio_package;

class CommentFormController {
  Rx<TimeOfDay?> timeOfDay = Rx<TimeOfDay?>(null);

  // validate
  RxBool initValidation = true.obs;

  // 실종 정보 일부 데이터 - 대표 사진, 이름, 성별, 나이, 주소 TODO 이전 화면에서 받아오기
  RxString missingImage =
      'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg'
          .obs;
  RxString missingName = '김말순'.obs;
  RxString missingGender = '여자'.obs;
  RxString missingAge = '85세'.obs;
  RxString missingLocation = '용산구 갈월동'.obs;

  // 제보 댓글 - 제보 사진, 시간, 위치, 옷차림, 상황
  RxList<XFile> images = <XFile>[].obs;
  Rx<String?> address = Rx<String?>(null);
  Rx<double?> latitude = Rx<double?>(null);
  Rx<double?> longitude = Rx<double?>(null);
  TextEditingController clothesController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    await picker.pickMultiImage().then((value) {
      images += value;
    });
  }

  bool validateRequiredFields() {
    // 필수 값: images, discoveredAt, address
    // * null 여부 검증
    return images.isNotEmpty &&
        timeOfDay.value != null &&
        address.value != null;
  }

  Future<void> saveComment() async {
    // TODO 주석 삭제, 통신 확인, pid
    int pid = 0;

    // request body form data 생성
    final formData = dio_package.FormData.fromMap({
      "pid": pid,
      "discoveredAt": combineTimeOfDayWithCurrentDate(timeOfDay.value!),
      "address": address.value,
      "latitude": latitude.value,
      "longitude": longitude.value,
      "clothes": clothesController.text.isEmpty ? null : clothesController.text,
      "details": detailsController.text.isEmpty ? null : clothesController.text,
      "images": List.generate(images.length,
              (index) => dio_package.MultipartFile.fromFile(images[index].path)),
    });

    // final dio = createDio();
    // dio.options.contentType = 'multipart/form-data';
    // CommentRepository commentRepository = CommentRepository(dio);
    // commentRepository.postComment(pid);
  }

  void registerComment() {
    print('print detailsController.text: ${detailsController.text}');

    Get.to(() => RegisteringCommentPage());
  }
}
