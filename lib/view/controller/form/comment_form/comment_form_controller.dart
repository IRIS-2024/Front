import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iris_flutter/model/post.dart';
import 'package:iris_flutter/utils/conversion_utils.dart';
import 'package:iris_flutter/view/comm/custom_snackbar.dart';
import 'package:iris_flutter/view/page/form/comment_form/comment_form_dialog.dart';
import 'package:dio/dio.dart' as dio_package;
import 'package:iris_flutter/view/page/main/main_page.dart';

class CommentFormController {
  Rx<TimeOfDay?> timeOfDay = Rx<TimeOfDay?>(null);

  // validate
  RxBool initValidation = true.obs;

  // 실종 정보 일부 데이터 - 대표 사진, 이름, 성별, 나이, 주소
  RxString postImage = ''.obs;
  RxString postName = ''.obs;
  RxBool postGender = true.obs;
  RxInt postAge = 0.obs;
  RxString postAddress = ''.obs;

  // 제보 댓글 - 제보 사진, 시간, 위치, 옷차림, 상황
  RxList<XFile> images = <XFile>[].obs;
  Rx<String?> address = Rx<String?>(null);
  Rx<double?> latitude = Rx<double?>(null);
  Rx<double?> longitude = Rx<double?>(null);
  TextEditingController clothesController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  void setShortPostCard(Post post) {
    postImage.value = post.images.first;
    postName.value = post.name;
    postGender.value = post.gender;
    postAge.value = post.age;
    postAddress.value = post.address;
  }

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

  Future<void> submitComment() async {
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

    // 등록 Dialog
    // Get.to(() => CommentFormDialog()));
    commentFormDialog();
  }

  Future<void> getMatchingRate() async {
    // 일치율 판별 과정
    // TODO 임시 딜레이
    await Future.delayed(const Duration(milliseconds: 3000));
  }

  void completeRegistration(BuildContext context) {
    customSnackBar(
        title: '제보 댓글 등록', message: '제보 댓글 등록이 완료되었습니다.', context: context);
    Get.offAll(() => const MainPage()); // TODO 그 전의 Info 상세
  }
}
