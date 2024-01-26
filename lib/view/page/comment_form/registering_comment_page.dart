import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/view/controller/comment_form/comment_form_controller.dart';

class RegisteringCommentPage extends StatelessWidget {
  const RegisteringCommentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get.put(CommentFormController());
    // final controller = Get.find<CommentFormController>();

    //TODO: 일치율 판별 완료되면, Get Navigation, SnackBar
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CircularProgressIndicator 추가
              ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg',
                    height: 200,
                    fit: BoxFit.fitHeight,
                  ),
                  // child: Image.file(
                  //   File(controller.images.first.path),
                  //   height: 200,
                  //   fit: BoxFit.fitHeight,
                  ),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              Text('제보 사진의 일치율 판별이 완료되면'),
              Text('제보가 등록됩니다.'),
            ],
          ),
        ),
      ),
    );
  }
}
