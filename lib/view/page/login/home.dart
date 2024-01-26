import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iris_flutter/view/page/login/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
              if (!snapshot.hasData) {
                return const LoginPage();
              } else {
                // 로그인 성공
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${snapshot.data?.displayName} 님 환영합니다."),
                      TextButton(
                          onPressed: FirebaseAuth.instance.signOut,
                          child: const Text("로그아웃"))
                    ],
                  ),
                );
              }
            }));
  }
}

class Login {
  const Login();
}
