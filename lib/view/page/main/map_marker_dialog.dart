import 'package:flutter/material.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';

class MapMarkerDialog extends StatefulWidget {
  final dynamic controller;
  const MapMarkerDialog({Key? key, required this.controller}) : super(key: key);

  @override
  State<MapMarkerDialog> createState() => _MapMarkerDialogState();
}

class _MapMarkerDialogState extends State<MapMarkerDialog> {
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
          _titleAndContent(
              title: '인적사항',
              content:
              '${Config().getGenderText(widget.controller.gender.value)} / ${widget.controller.agewidget.controller.text}세 / ${widget.controller.heightwidget.controller.text == '' ? '' : '${widget.controller.heightwidget.controller.text}cm'} / ${widget.controller.weightwidget.controller.text == '' ? '' : '${widget.controller.weightwidget.controller.text}kg'}'),
          _titleAndContent(title: '마지막 위치', content: widget.controller.address.value!),
          _titleAndContent(title: '옷차림', content: widget.controller.clotheswidget.controller.text),
          _titleAndContent(title: '특이사항', content: widget.controller.notewidget.controller.text),
          ElevatedButton(onPressed: () {}, child: Text('닫기')),
          ElevatedButton(onPressed: () {}, child: Text('보기')),
        ],
      ),
    );
  }

  _titleAndContent({required String title, required String content}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(
            title,
            style: TextStyle(color: Theme.of(context).colorScheme.outline),
          ),
        ),
        const Padding(padding: CustomPadding.slimRight),
        SizedBox(
            width: 180,
            child: Text(
              content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )),
      ],
    );
  }
}
