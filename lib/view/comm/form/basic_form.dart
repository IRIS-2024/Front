
// form : title + widget

import 'package:flutter/cupertino.dart';
import 'package:iris_flutter/view/comm/form/form_title.dart';

class BasicForm extends StatelessWidget {
  final Widget widget;
  const BasicForm({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        formTitle(title: '성별', isRequired: true),
        widget,
        const Padding(padding: EdgeInsets.only(bottom: 15)),
      ],
    );
  }
}
