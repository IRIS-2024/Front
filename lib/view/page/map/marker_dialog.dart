import 'package:flutter/material.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/custom_text_style.dart';

class MarkerDialog extends StatefulWidget {
  final dynamic controller;
  const MarkerDialog({Key? key, required this.controller}) : super(key: key);

  @override
  State<MarkerDialog> createState() => _MarkerDialogState();
}

class _MarkerDialogState extends State<MarkerDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          // 이름
          Text(
            widget.controller.nameController.text,
            style: CustomTextStyle.basicBold.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          // 사진 - 추후 추가
          // 상세 내용
          _titleAndInfo(
              title: '인적사항',
              contents:
              '${widget.controller.selectedGender.value == Gender.man ? Config.man : Config.woman} / ${widget.controller.agewidget.controller.text}세 / ${widget.controller.heightwidget.controller.text == '' ? '' : '${widget.controller.heightwidget.controller.text}cm'} / ${widget.controller.weightwidget.controller.text == '' ? '' : '${widget.controller.weightwidget.controller.text}kg'}'),
          _titleAndInfo(title: '마지막 위치', contents: widget.controller.location.value!),
          _titleAndInfo(title: '옷차림', contents: widget.controller.clotheswidget.controller.text),
          _titleAndInfo(title: '특이사항', contents: widget.controller.notewidget.controller.text),
          ElevatedButton(onPressed: () {}, child: Text('닫기')),
          ElevatedButton(onPressed: () {}, child: Text('보기')),
        ],
      ),
    );
  }

  _titleAndInfo({required String title, required String contents}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(
            title,
            style: TextStyle(color: Colors.grey),
          ),
        ),
        const Padding(padding: EdgeInsets.only(right: 5)),
        SizedBox(
            width: 180,
            child: Text(
              contents,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )),
      ],
    );
  }
}
