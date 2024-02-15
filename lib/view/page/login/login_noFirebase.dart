import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/model/user.dart';
import 'package:iris_flutter/view/controller/login/login_controller.dart';
import 'package:iris_flutter/view/page/my_page/my_page_noFirebase.dart';

class LoginTest extends StatefulWidget {
  const LoginTest({super.key});

  @override
  State<LoginTest> createState() => _LoginTestState();
}

class _LoginTestState extends State<LoginTest> {
  LoginController controller = Get.put(LoginController());

  void signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      // print('name = ${googleUser.displayName}');
      // print('email = ${googleUser.email}');
      // print('id = ${googleUser.id}');

      User data = User(id: googleUser.id, email: googleUser.email);
      if (googleUser.displayName != null) {
        data.displayName = googleUser.displayName;
      }
      if (googleUser.photoUrl != null) {
        data.photoUrl = googleUser.photoUrl;
      }

      controller.updateInfo(data);

      Get.to(() => const MyPageTest());

      // setState(() {
      //   _loginPlatform = google;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: CustomPadding.pageInsets,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                "No Firebase 로그인/회원가입",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ]),
            const SizedBox(
              height: 48,
            ),
            Image.asset(
              'assets/images/temp_logo.png',
              height: 200,
            ),
            const SizedBox(
              height: 48,
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: signInWithGoogle,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                        'http://pngimg.com/uploads/google/google_PNG19635.png',
                        fit: BoxFit.fitHeight),
                    const SizedBox(width: 6),
                    const Text(
                      "구글로 로그인하기",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
