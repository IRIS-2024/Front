import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iris_flutter/firebase_options.dart';
import 'package:iris_flutter/view/page/login/home.dart';

class LoginInit extends StatelessWidget {
  const LoginInit({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(">> Firebase initialization error: ${snapshot.error}");
            return const Center(
              child: Text("Firebase load fail"),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            // initializeApp 완료
            return const Home();
          }

          return const CircularProgressIndicator();
        });
  }
}
