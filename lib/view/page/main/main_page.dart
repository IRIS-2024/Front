import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/view/page/form/post_form/post_form_page.dart';
import 'package:iris_flutter/view/page/main/main_tab.dart';
import 'package:iris_flutter/view/page/map/map_controller.dart';
import 'package:iris_flutter/view/page/my_page/my_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // 현 위치 (Admin District)
    Get.put(MapController()).getAdminDistrictAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: CustomPadding.pageInsets,
            child: Column(
              children: [
                // my page iconButton
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      Get.to(() => const MyPage());
                    },
                    icon: const Icon(Icons.account_circle_outlined),
                  ),
                ),
                // location Text
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Obx(
                          () => RichText(
                        text: TextSpan(
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                            ),
                            children: [
                              TextSpan(text: Get.put(MapController()).regionAddress.value ?? '현 위치 주변',
                                  style: TextStyle(
                                      color: Theme.of(context).colorScheme.primary
                                  )),
                              TextSpan(text: "에서 등록된 실종 정보입니다.",
                                  style: TextStyle(
                                      color: Theme.of(context).colorScheme.onBackground,
                                  )
                              )
                            ]
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: CustomPadding.mediumBottom,),

                // main TabBar
                const MainTab(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(onPressed: () {
          Get.to(() => const PostFormPage());
        }, label: const Text('신고하기'),
          icon: const Icon(Icons.report_gmailerrorred),)
    );

  }
}
