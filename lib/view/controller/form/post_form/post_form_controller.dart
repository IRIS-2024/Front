import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/repository/post_repository.dart';
import 'package:iris_flutter/utils/conversion_utils.dart';
import 'package:iris_flutter/view/comm/custom_snackbar.dart';
import 'package:iris_flutter/view/page/form/post_form/post_form_dialog.dart';
import 'package:iris_flutter/view/page/main/main_page.dart';
import 'package:dio/dio.dart' as dio_package;

class PostFormController {
  RxList<XFile> images = <XFile>[].obs;
  Rx<TimeOfDay?> timeOfDay = Rx<TimeOfDay?>(null);
  RxBool isChecked = true.obs;

  // validate
  RxBool initValidation = true.obs;

  TextEditingController nameController = TextEditingController();
  RxBool gender = Config.woman.obs;
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  Rx<String?> address = Rx<String?>(null);
  Rx<double?> latitude = Rx<double?>(null);
  Rx<double?> longitude = Rx<double?>(null);
  TextEditingController clothesController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  RxString genImage = ''.obs;

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    await picker
        .pickMultiImage(
      maxHeight: 500,
      imageQuality: 30,
    )
        .then((value) {
      images += value;
    }).catchError((error) {
      print('pickImage error: $error');
    });
  }

  bool validateRequiredFields(GlobalKey<FormState> formKey) {
    // 필수 값: images, name, gender, age, disappearedAt, address
    // * gender는 기본 값이 정해져 있음
    // * form Key validation 방식으로 name, age 검증함
    // * images, disappearedAt, address null 여부 검증
    return formKey.currentState!.validate() &&
        images.isNotEmpty &&
        timeOfDay.value != null &&
        address.value != null;
  }

  Future<void> submitPost(dynamic controller) async {
    showPostFormDialog(controller);

  }

  Future<void> postFormAndCreateImg() async {
    // // request body FormData 생성
    final formData = dio_package.FormData.fromMap({
      'name': nameController.text,
      'gender': gender.value,
      'age': ageController.text,
      'height': heightController.text, // * nullable 여부
      'weight': weightController.text,
      'address': address.value,
      'latitude': latitude.value,
      'longitude': longitude.value,
      'disappearedAt': combineTimeOfDayWithCurrentDate(timeOfDay.value!),
      'clothes': clothesController.text,
      'details': detailsController.text.isEmpty ? null : detailsController.text,
    });
    // images 추가
    for (int i = 0; i < images.length; i++) {
      formData.files.add(MapEntry(
        'images',
        await dio_package.MultipartFile.fromFile(images[i].path),
      ));
    }

    final dio = createDio();
    dio.options.contentType = 'multipart/form-data';

    try {
      PostRepository postRepository = PostRepository(dio);
      final resp = await postRepository.postPost(formData);
      genImage.value = resp.genImgUrl;
    } on DioException catch (e) {
      print('Error ${e.response}');
      return;
    }
  }

  void submitFinalPost(BuildContext context) {
    // TODO 최종 글 등록

    // get navigation, snackBar
    customSnackBar(
        title: '실종 정보 등록', message: '실종 정보 등록이 완료되었습니다.', context: context);
    Get.offAll(() => const MainPage());
  }
}

