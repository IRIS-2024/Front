import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iris_flutter/config/config.dart';

class InfoFormController {
  RxList<XFile> images = <XFile>[].obs;

  RxBool initValidation = true.obs;
  TextEditingController nameController = TextEditingController();
  Rx<Gender> selectedGender = Gender.woman.obs;
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  RxString location = Config.enterLocation.obs;
  TextEditingController clothesController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  // 생성 시간
  // 수정 시간

  void registerInfo() {
    print('print nameControllerText: ${nameController.text}');
    print('print selectedGender: ${selectedGender.value}');
    print('print ageControllerText: ${ageController.text}');
    print('print heightControllerText: ${heightController.text}');
    print('print weightControllerText: ${weightController.text}');
    print('print locationControllerText: ${location.value}');
    print('print dressControllerText: ${clothesController.text}');
    print('print noteController: ${noteController.text}');
    //사진 저장 +

    // 이미지 생성
  }



  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    await picker.pickMultiImage().then((value) {
      images += value;
    });
  }
}
