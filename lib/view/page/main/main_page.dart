import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/view/controller/main/main_controller.dart';
import 'package:iris_flutter/view/page/main/main_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: CustomPadding.pageInsets.copyWith(bottom: 0),
            child: Column(
              children: [
                // my page iconButton
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      Get.toNamed(Config.routerMyPage);
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
                              TextSpan(
                                  text: Get.put(MainController())
                                          .shortAddress
                                          .value ??
                                      AppLocalizations.of(context)!
                                          .currentLocation,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                              TextSpan(
                                  text:
                                      "\n${AppLocalizations.of(context)!.main}",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      fontSize: 27))
                            ]),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: CustomPadding.mediumBottom,
                ),

                // main TabBar
                const MainTab(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Get.toNamed(Config.routerPostForm);
            Get.toNamed(Config.routerAgree); // 동의화면부터
          },
          label: Text(AppLocalizations.of(context)!.report),
          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          foregroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
          icon: const Icon(Icons.report_gmailerrorred),
        ));
  }
}
