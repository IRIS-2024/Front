import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/view/page/Info_form/info_form_page.dart';

class InfoFormController {
  RxList<XFile> images = <XFile>[].obs;

  RxBool initValidation = true.obs;
  TextEditingController nameController = TextEditingController();
  Rx<Gender> selectedGender = Gender.woman.obs;
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  RxString location = Config.enterLocation.obs;
  TextEditingController dressController = TextEditingController();
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
    print('print dressControllerText: ${dressController.text}');
    print('print noteController: ${noteController.text}');
    //사진 저장 +
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    await picker.pickMultiImage().then((value) {
      images += value;
    });
  }
}
