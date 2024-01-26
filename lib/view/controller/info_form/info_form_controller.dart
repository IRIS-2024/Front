import 'dart:io';

import 'package:flutter/material.dart';
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

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    await picker.pickMultiImage().then((value) {
      images += value;
    });
  }

  void saveInfo(BuildContext context) {
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
    createMontage(context);
  }

  void createMontage(BuildContext context) {
    createMontageDialog(context);
    // 이미지 넘기고
    // 생성된 이미지 받아오기
  }

  // Dialog
  createMontageDialog(BuildContext context) {
    // 임시 값
    nameController.text = '김실종';
    selectedGender.value = Gender.man;
    ageController.text = '7';
    heightController.text = '120';
    weightController.text = '43';
    location.value = '용산구 왕왕동';
    clothesController.text = '빨간 반팔, 청바지, 은색 운동화, 파랑 캡모자';
    noteController.text =
        '축구 공을 가지고 놀고 있었습니다. 또래에 비해 체구가 작습니다. 강아지를 쫓아다니는 특이행동을 합니다. 실종 당시 강아지를 쫓아가다 실종 되었습니다.';
    images.value = [XFile('/Users/rlaltj/Library/Developer/CoreSimulator/Devices/75911304-00BF-4B3E-8F6A-04D3460640F7/data/Containers/Data/Application/2B2E8C8F-AC6E-4C76-81A7-E6AB5CBE6E26/tmp/image_picker_B32B3B05-0629-4690-85C3-9B1B27CA8BEF-48935-000011AF13421D14.jpg'),
    XFile('/Users/rlaltj/Library/Developer/CoreSimulator/Devices/75911304-00BF-4B3E-8F6A-04D3460640F7/data/Containers/Data/Application/2B2E8C8F-AC6E-4C76-81A7-E6AB5CBE6E26/tmp/image_picker_ED9D880A-841F-4559-B4A7-7362F1436694-48935-000011AF18C43233.jpg')];

    // TODO: 위젯 정리
    Get.dialog(Dialog(
        child: Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '작성하신 정보를 바탕으로\n이미지를 생성하시겠습니까?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 15)),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              nameController.text,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 7)),
          _titleAndInfo(
              title: '인적사항',
              contents:
                  '${selectedGender.value == Gender.man ? Config.man : Config.woman} / ${ageController.text}세 / ${heightController.text == '' ? '' : '${heightController.text}cm'} / ${weightController.text == '' ? '' : '${weightController.text}kg'}'),
          _titleAndInfo(title: '마지막 위치', contents: location.value),
          _titleAndInfo(title: '옷차림', contents: clothesController.text),
          _titleAndInfo(title: '특이사항', contents: noteController.text),
          const Padding(padding: EdgeInsets.only(bottom: 24)),
          SizedBox(
            width: double.infinity,
              child: ElevatedButton(onPressed: () {
                creatingMontageDialog(context);
              }, child: Text('AI 이미지 생성하기'),style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              ),)),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {
                registerInfo();
              }, child: Text('AI 이미지 없이 등록하기'),)),
        ],
      ),
    )));
  }

  _titleAndInfo({required String title, required String contents}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(
            title,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
        const Padding(padding: EdgeInsets.only(right: 5)),
        SizedBox(
            width: 180,
            child: Text(
              contents,
              style: TextStyle(fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )),
      ],
    );
  }

  creatingMontageDialog(BuildContext context) {
    Get.dialog(Dialog(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '작성하신 정보를 바탕으로\n이미지를 생성하는 중 입니다...',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              // CircularProgressIndicator 추가
              ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.file(
                    File(images.first.path),
                    height: 200,
                    fit: BoxFit.fitHeight,
                  )),
              ElevatedButton(onPressed: () {
                registerMontageDialog(context);
              }, child: Text('임시 Dialog'))
            ],
          ),
        )));
  }

  registerMontageDialog(BuildContext context) {
    Get.dialog(Dialog(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '생성된 이미지를 함께\n등록하시겠습니까?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.file(
                    File(images[1].path),
                    height: 200,
                    fit: BoxFit.fitHeight,
                  )),
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value) {
                    print('print value: ${value}');
                  }),
                  Text('대표 이미지로 사용', style: TextStyle(
                    fontSize: 14
                  ),)
                ],
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () {
                    // AI 이미지 추가
                    registerInfo();
                  }, child: Text('AI 이미지를 사용하여 등록하기'),style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),)),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () {
                    registerInfo();
                  }, child: Text('AI 이미지 없이 등록하기'),)),
            ],
          ),
        )));
  }

  registerInfo() {
    // 최종 글 등록
    // get navigation, snackBar
  }
}
