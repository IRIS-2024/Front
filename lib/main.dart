import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/theme.dart';
import 'package:iris_flutter/view/page/main/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: MaterialTheme.lightScheme().toColorScheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)
              )
          )
        ),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}