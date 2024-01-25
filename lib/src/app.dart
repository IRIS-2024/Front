import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iris_flutter/view/page/login/login.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const Login(); // 메인 페이지로 이동
          } else if (snapshot.hasError) {
            print(">> Firebase initialization error: ${snapshot.error}");
            return const Center(
              child: Text("Firebase load fail"),
            );
          }
          return const CircularProgressIndicator();
        });
  }
}
