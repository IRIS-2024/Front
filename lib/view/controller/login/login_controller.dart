import 'package:get/get.dart';
import 'package:iris_flutter/model/user.dart';

class LoginController extends GetxController {
  Rx<User> user = User(id: '', email: '').obs;

  void updateInfo(User data) {
    user.value = data;
  }

  void deleteInfo() {
    // logout 시 초기화
    user.value = User(id: '', email: '');
  }
}
