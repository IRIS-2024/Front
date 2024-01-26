import 'package:flutter/material.dart';
import 'package:iris_flutter/view/comm/form/form_title.dart';

// form:  title + text
class TextForm extends StatelessWidget {
  final TextEditingController textEditingController;
  final String title;
  final bool isRequired;
  final String hintText;
  final int maxLength;
  final int? maxLengths;

  const TextForm({
    Key? key,
    required this.textEditingController,
    required this.title,
    required this.isRequired,
    required this.hintText,
    required this.maxLength,
    this.maxLengths,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        formTitle(title: title, isRequired: isRequired),
        TextFormField(
          controller: textEditingController,
          maxLines: maxLengths ?? 1,
          maxLength: maxLength,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            // counterText: '',
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
        ),
        const Padding(padding: EdgeInsets.only(bottom: 15)),
      ],
    );

  }
}