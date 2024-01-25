import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iris_flutter/view/comm/custom_appbar.dart';
import 'package:iris_flutter/view/comm/register_button.dart';
import 'package:iris_flutter/view/controller/info_form/info_form_controller.dart';

enum Gender { man, woman }

class InfoFormPage extends StatefulWidget {
  const InfoFormPage({Key? key}) : super(key: key);

  @override
  State<InfoFormPage> createState() => _InfoFormPageState();
}

class _InfoFormPageState extends State<InfoFormPage> {
  // Gender selectedGender = Gender.woman;
  final infoFormController = InfoFormController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: customAppBar(
            title: '실종자 등록',
            actions: RegisterButton(onPressed: () {
              // validate location
              if (infoFormController.locationController.text == '위치 입력') {
                infoFormController.validateLocation = true;
              }

              final formKeyState = _formKey.currentState!;
              if (formKeyState.validate()) {
                // formKeyState.save();
                infoFormController.name = infoFormController.nameController.text;
                print('print infoFormControllerNameControllerText: ${infoFormController.dressController.text}');
                print('print infoFormControllerName: ${infoFormController.name}');
              }
              
            })),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 25),
            child: Column(
              children: [
                // 사진
                Text('// 사진'),
                // 실종자 이름
                basicField(
                    textEditingController: infoFormController.nameController,
                    title: '실종자 이름',
                    isRequired: true,
                    hintText: '실종자 이름을 입력해주세요.'),

                // 성별, 만 나이
                Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            fieldTitle(title: '성별', isRequired: true),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                genderButton(title: '여자', gender: Gender.woman),
                                genderButton(title: '남자', gender: Gender.man),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 10)),
                          ],
                        )),
                    const Padding(padding: EdgeInsets.only(right: 10)),
                    Flexible(
                      flex: 1,
                      child: numberField(
                        textEditingController: infoFormController.ageController,
                          title: '만 나이',
                          isRequired: true,
                          hintText: '세.',
                          suffixText: '세'),
                    )
                  ],
                ),
                // 키, 몸무게
                Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: numberField(
                            textEditingController: infoFormController.heightController,
                            title: '키',
                            isRequired: false,
                            hintText: '실종자 키를 입력해 주세요.',
                            suffixText: 'cm')),
                    const Padding(padding: EdgeInsets.only(right: 10)),
                    Flexible(
                        flex: 1,
                        child: numberField(
                            textEditingController: infoFormController.weightController,
                            title: '몸무게',
                            isRequired: false,
                            hintText: '실종자 몸무게를 입력해 주세요.',
                            suffixText: 'kg')),
                  ],
                ),
                // 마지막 위치
                Column(
                  children: [
                    fieldTitle(title: '마지막 위치', isRequired: true),
                    // TextFormField(
                    //   controller: infoFormController.locationController,
                    //   readOnly: true,
                    //   decoration: InputDecoration(
                    //     isDense: true,
                    //     // hintText: hintText,
                    //     border: OutlineInputBorder(
                    //         borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    //         borderSide:
                    //         BorderSide(color: Theme.of(context).colorScheme.outline)),
                    //   ),
                    //   validator: (value) {
                    //     // if (value!.isEmpty && isRequired) {
                    //     //   return '이름을 입력해주세요.';
                    //     // }
                    //     // return null;
                    //   },
                    // ),

                    OutlinedButton.icon(
                        onPressed: () {
                          // 위치 받아온 다음,
                          infoFormController.locationController.text = '새로운 위치';
                        },
                        style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 55),
                            foregroundColor: Colors.black,
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        icon: const Icon(Icons.my_location),
                        // label: Text(infoFormController.locationController.text)),
                        label: Text('위치 입력')), //TODO
                    infoFormController.validateLocation == true ?
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text('위치를 입력해 주세요.', style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.error
                      ),),
                    ) : const SizedBox(),
                    const Padding(padding: EdgeInsets.only(bottom: 15)),
                  ],
                ),

                // 실종 당시 옷차림
                basicField(
                  textEditingController: infoFormController.dressController,
                    title: '실종 당시 옷차림',
                    isRequired: false,
                    hintText: '상•하의 모양, 색상, 액세서리 등을 적어주세요.'),
                // 특이사항
                basicField(
                    textEditingController: infoFormController.noteController,
                    title: '특이사항',
                    isRequired: false,
                    hintText: '실종자의 체격, 얼굴형, 특이 행동, 질병 등을 적어주세요.',
                    maxLengths: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // text Field 의 제목
  Column fieldTitle({
    required String title,
    required bool isRequired,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            isRequired == true
                ? const Text(
                    '*',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.red),
                  )
                : const SizedBox()
          ],
        ),
        const Padding(padding: EdgeInsets.only(bottom: 10)),
      ],
    );
  }

  Column basicField({
    required TextEditingController textEditingController,
    required String title,
    required bool isRequired,
    required String hintText,
    int? maxLengths,
  }) {
    return Column(
      children: [
        fieldTitle(title: title, isRequired: isRequired),
        TextFormField(
          controller: textEditingController,
          maxLines: maxLengths ?? 1,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.outline)),
          ),
          validator: (value) {
            if (value!.isEmpty && isRequired) {
              return '이름을 입력해주세요.';
            }
            return null;
          },
          // onSaved: (value) {
          //   print('print lof: ${value}');
          // },
        ),
        const Padding(padding: EdgeInsets.only(bottom: 15)),
      ],
    );
  }

  Column numberField({
    required TextEditingController textEditingController,
    required String title,
      required bool isRequired,
      required String hintText,
      required String suffixText}) {
    return Column(
      children: [
        fieldTitle(title: title, isRequired: isRequired),
        TextFormField(
          controller: textEditingController,
          maxLength: 3,
          decoration: InputDecoration(
            isDense: true,
            // hintText: '세',
            // hintTextDirection: TextDirection.rtl,
            counterText: '',
            suffix: Text(suffixText),
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.outline)),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value!.isEmpty && isRequired) {
              return '만 나이를 입력해 주세요.';
            }
            return null;
          },
          // onSaved: (value) {
          //   print('print ㄹㄹ: ${value}');
          // },
        ),
        const Padding(padding: EdgeInsets.only(bottom: 15)),
      ],
    );
  }

  Widget genderButton({required String title, required Gender gender}) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          infoFormController.selectedGender = gender;
        });
      },
      style: OutlinedButton.styleFrom(
          fixedSize: const Size(double.infinity, 55),
          textStyle: const TextStyle(fontSize: 16),
          foregroundColor: infoFormController.selectedGender == gender
              ? Theme.of(context).colorScheme.primary
              : Colors.black,
          side: BorderSide(
            color: infoFormController.selectedGender == gender
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
      child: Text(title),
    );
  }
}
