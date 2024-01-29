import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/theme.dart';
import 'package:iris_flutter/view/page/Info_form/info_form_page.dart';
import 'package:iris_flutter/view/page/comment_form/comment_form_page.dart';
import 'package:iris_flutter/view/page/main/main_page.dart';
import 'package:iris_flutter/view/page/detail_info/info_page.dart';
import 'package:iris_flutter/view/page/map/map_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/config/.env");

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
      home: const MapPage(),
    );
  }
}