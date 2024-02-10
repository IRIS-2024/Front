import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/model/missing_info.dart';
import 'package:iris_flutter/repository/info_repository.dart';
import 'package:iris_flutter/view/comm/custom_snackbar.dart';
import 'package:iris_flutter/view/page/form/Info_form/info_form_dialog.dart';
import 'package:iris_flutter/view/page/main/main_page.dart';

class InfoFormController {
  RxList<XFile> images = <XFile>[].obs;

  RxBool initValidation = true.obs;
  TextEditingController nameController = TextEditingController();
  RxBool selectedGender = Config.woman.obs;
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  Rx<String?> address = Rx<String?>(null);
  TextEditingController clothesController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  // 생성 시간
  // 수정 시간

  // Dialog Index
  RxInt dialogIndex = 0.obs;

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    await picker.pickMultiImage().then((value) {
      images += value;
    });

    print('print imagesFirstPath: ${images.first.path}');
  }

  void saveInfo(BuildContext context) {
    // // FormData formData;
    // final List<MultipartFile> files = images
    //     .map((img) => MultipartFile.fromFileSync(img.path,
    //     // contentType: MediaType("`````image", "jpg")
    // ))
    //     .toList();
    // // formData = FormData.fromMap({"images": files});
    //
    // final formData = FormData.fromMap({
    //   'name': nameController.text,
    //   'gender': true,
    //   'age': 0,
    //   'height': 0,
    //   'weight': 0,
    //   'address': '서울시 용산구 갈월동 24',
    //   'latitude': 0,
    //   'longitude': 0,
    //   'clothes': 'string',
    //   'details': 'string',
    //   'images': [
    //     await MultipartFile.fromFile('path_to_image_1'),
    //     await MultipartFile.fromFile('path_to_image_2'),
    //     // ... add more image files as needed
    //   ],
    // });
    //
    // InfoRepository infoRepository = InfoRepository(createDio());
    // infoRepository.postInfo(
    //   MissingInfo(
    //       name: nameController.text,
    //       gender: selectedGender.value,
    //       age: int.parse(ageController.text),
    //       height: int.parse(heightController.text),
    //       weight: int.parse(weightController.text),
    //       address: address.value!,
    //       latitude: 37.545144,
    //       longitude: 126.964381,
    //       clothes: clothesController.text,
    //       details: detailsController.text,
    //       images: formData
    //   )
    // );
    // 이미지 생성
    createMontage(context);
  }

  void createMontage(BuildContext context) {
    nameController.text = '김실종';
    selectedGender.value = Config.man;
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
