import 'package:flutter/cupertino.dart';
import 'package:iris_flutter/view/page/form/form_title.dart';

// form : title + widget
class BasicForm extends StatelessWidget {
  final String title;
  final bool isRequired;
  final Widget widget;

  const BasicForm(
      {Key? key,
      required this.title,
      required this.isRequired,
      required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        formTitle(title: title, isRequired: true),
        widget,
        const Padding(padding: EdgeInsets.only(bottom: 15)),
      ],
    );
  }
}
