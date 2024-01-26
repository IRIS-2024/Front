import 'package:flutter/material.dart';
import 'package:iris_flutter/theme.dart';
import 'package:iris_flutter/view/page/Info_form/info_form_page.dart';
import 'package:iris_flutter/view/page/comment_form/comment_form_page.dart';
import 'package:iris_flutter/view/page/main/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: MaterialTheme.lightScheme().toColorScheme(),
        useMaterial3: true,
      ),
      home: const InfoFormPage(),
    );
  }
}