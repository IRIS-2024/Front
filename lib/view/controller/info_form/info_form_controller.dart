import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/repository/info_repository.dart';
import 'package:iris_flutter/utils/conversion_utils.dart';
import 'package:iris_flutter/view/comm/custom_snackbar.dart';
import 'package:iris_flutter/view/page/form/Info_form/info_form_dialog.dart';
import 'package:iris_flutter/view/page/main/main_page.dart';
import 'package:dio/dio.dart' as dio_package;

class InfoFormController {
  RxList<XFile> images = <XFile>[].obs;
  Rx<TimeOfDay?> timeOfDay = Rx<TimeOfDay?>(null);
  RxBool isChecked = true.obs;

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

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    await picker.pickMultiImage().then((value) {
      images += value;
    });

    print('print imagesFirstPath: ${images.first.path}');
  }

  bool validateRequiredFields(GlobalKey<FormState> formKey) {
    // 필수 값: images, name, gender, age, disappearedAt, address
    // * gender는 기본 값이 정해져 있음
    // * form Key validation 방식으로 name, age 검증함
    // * images, disappearedAt, address null 여부 검증
    return formKey.currentState!.validate() && images.isNotEmpty && timeOfDay.value != null && address.value != null;
  }

  Future<void> saveInfo(BuildContext context) async {
    // TODO 주석 삭제, 통신 확인
    // // request body form data 생성
    // final formData = dio_package.FormData.fromMap({
    //   'name': nameController.text,
    //   'gender': gender.value,
    //   'age': ageController.text,
    //   'height': heightController.text,
    //   'weight': heightController.text,
    //   'address': address.value,
    //   'latitude': latitude.value,
    //   'longitude': longitude.value,
    //   'clothes': clothesController.value,
    //   'details': detailsController.text,
    //   'bookmarked': false, // default
    //   'images': List.generate(images.length,
    //       (index) => dio_package.MultipartFile.fromFile(images[index].path)),
    //   'disappearedAt': combineTimeOfDayWithCurrentDate(timeOfDay.value!),
    //   'createdAt': DateTime.now().toString(),
    //   'updatedAt': null,
    // });
    //
    // final dio = createDio();
    // dio.options.contentType = 'multipart/form-data';
    // InfoRepository infoRepository = InfoRepository(dio);
    // infoRepository.postInfo(formData);

    // 이미지 생성
    createAIImage(context);
  }

  void createAIImage(BuildContext context) {
    infoFormDialog(context);
  }

  void registerInfo(BuildContext context) {
    // TODO 최종 글 등록

    // get navigation, snackBar
    customSnackBar(
        title: '실종 정보 등록', message: '실종 정보 등록이 완료되었습니다.', context: context);
    Get.offAll(() => const MainPage());
  }
}
