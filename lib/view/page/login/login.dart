import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

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
        appBar: AppBar(
          title: const Text("SNS Login"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: signInWithGoogle,
                  child: const Text("Google Login"))
            ],
          ),
        ));
  }
}
