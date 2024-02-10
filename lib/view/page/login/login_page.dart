import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/view/comm/custom_appbar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Future<UserCredential> signInWithGoogle() async {
    // 인증 플로우 시작
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // 요청으로부터 인증 세부 정보 가져오기
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // 새로운 credential 생성
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // 로그인 성공 시, UserCredential 반환
    return await FirebaseAuth.instance.signInWithCredential(credential);
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
                "로그인/회원가입",
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
