import 'package:flutter/cupertino.dart';
import 'package:iris_flutter/view/page/Info_form/info_form_page.dart';

class InfoFormController {
  String name = '';
  String dress = '';
  String note = '';
  // 임시
  TextEditingController nameController = TextEditingController();
  Gender selectedGender = Gender.woman;
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController locationController = TextEditingController(text:'위치 입력');
  bool validateLocation = false;
  TextEditingController dressController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  // 생성 시간
  // 수정 시간
}