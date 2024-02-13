import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/repository/post_repository.dart';
import 'package:iris_flutter/utils/conversion_utils.dart';
import 'package:iris_flutter/view/comm/custom_snackbar.dart';
import 'package:iris_flutter/view/page/form/Info_form/info_form_dialog.dart';
import 'package:iris_flutter/view/page/main/main_page.dart';
import 'package:dio/dio.dart' as dio_package;

class InfoFormController {
  RxList<XFile> images = <XFile>[].obs;
  Rx<TimeOfDay?> timeOfDay = Rx<TimeOfDay?>(null);

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

  // Dialog Index
  RxInt dialogIndex = 0.obs;

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
    return formKey.currentState!.validate() &&
        images.isNotEmpty &&
        timeOfDay.value != null &&
        address.value != null;
  }

  Future<void> saveInfo(BuildContext context) async {
    // request body form data 생성
    final formData = dio_package.FormData.fromMap({
      'name': nameController.text,
      'gender': gender.value,
      'age': ageController.text,
      'height': heightController.text,
      'weight': heightController.text,
      'address': address.value,
      'latitude': latitude.value,
      'longitude': longitude.value,
      'clothes': clothesController.value,
      'details': detailsController.text,
      'bookmarked': false, // default
      'images': List.generate(images.length,
          (index) => dio_package.MultipartFile.fromFile(images[index].path)),
      'disappearedAt': combineTimeOfDayWithCurrentDate(timeOfDay.value!),
      'createdAt': DateTime.now().toString(),
      'updatedAt': null,
    });

    final dio = createDio();
    dio.options.contentType = 'multipart/form-data';
    PostRepository infoRepository = PostRepository(dio);
    infoRepository.postInfo(formData);
    // 이미지 생성
    createMontage(context);
  }

  void createMontage(BuildContext context) {
    nameController.text = '김실종';
    gender.value = Config.man;
    ageController.text = '7';
    heightController.text = '120';
    weightController.text = '43';
    address.value = '용산구 왕왕동';
    clothesController.text = '빨간 반팔, 청바지, 은색 운동화, 파랑 캡모자';
    detailsController.text =
        '축구 공을 가지고 놀고 있었습니다. 또래에 비해 체구가 작습니다. 강아지를 쫓아다니는 특이행동을 합니다. 실종 당시 강아지를 쫓아가다 실종 되었습니다.';
    images.value = [
      XFile(
          '/Users/rlaltj/Library/Developer/CoreSimulator/Devices/75911304-00BF-4B3E-8F6A-04D3460640F7/data/Containers/Data/Application/DC5001FD-B911-4E56-82A5-CBE3B93DC278/tmp/image_picker_F2DCFDDB-AA4B-42CC-BDAC-C4B8F78D8B1B-6065-0000022F112E4292.jpg'),
      XFile(
          '/Users/rlaltj/Library/Developer/CoreSimulator/Devices/75911304-00BF-4B3E-8F6A-04D3460640F7/data/Containers/Data/Application/DC5001FD-B911-4E56-82A5-CBE3B93DC278/tmp/image_picker_F2DCFDDB-AA4B-42CC-BDAC-C4B8F78D8B1B-6065-0000022F112E4292.jpg')
    ];

    dialogIndex.value = 0;
    infoFormDialog(context);
    // 이미지 넘기기
  }

  void registerInfo(BuildContext context) {
    // 최종 글 등록
    // get navigation, snackBar
    customSnackBar(
        title: '실종 정보 등록', message: '실종 정보 등록이 완료되었습니다.', context: context);
    Get.offAll(() => const MainPage());
  }
}
