import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/utils/user_profile_utils.dart';
import 'package:iris_flutter/view/comm/custom_appbar.dart';
import 'package:iris_flutter/view/controller/login/login_controller.dart';
import 'package:iris_flutter/view/page/my_page/bookmark_post.dart';
import 'package:iris_flutter/view/page/my_page/my_posts.dart';
import 'package:iris_flutter/view/page/my_page/my_comments.dart';
import 'package:iris_flutter/view/page/my_page/notification_setting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    final controller = Get.find<LoginController>();

    return Scaffold(
        appBar: customAppBar(title: AppLocalizations.of(context)!.mypage),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  tileColor: Theme.of(context).colorScheme.surfaceVariant,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  onTap: () {
                    // 사용자 사진 변경?;
                  },
                  leading: CircleAvatar(
                    backgroundImage: getUserPhoto() != ''
                        ? NetworkImage(getUserPhoto())
                        : const AssetImage('assets/images/logo.png')
                            as ImageProvider,
                  ),
                  title: getUserDisplayName() != ''
                      ? Text(getUserDisplayName())
                      : Text(
                          AppLocalizations.of(context)!.addUserName,
                          style: const TextStyle(color: Colors.grey),
                        ),
                  subtitle: getUserEmail() != ''
                      ? Text(getUserEmail())
                      : const Text(" "),
                ),
                const Padding(padding: CustomPadding.regularBottom),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context)!.postSetting,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 6),
                ListTile(
                  tileColor: Theme.of(context).colorScheme.surfaceVariant,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  onTap: () {
                    Get.to(() => const MyPosts());
                  },
                  leading: Icon(
                    Icons.people,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  title: Text(AppLocalizations.of(context)!.writtenPost),
                  trailing:
                      const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                ),
                ListTile(
                  tileColor: Theme.of(context).colorScheme.surfaceVariant,
                  onTap: () {
                    Get.to(() => const MyComments());
                  },
                  leading: const Icon(Icons.chat),
                  title: Text(AppLocalizations.of(context)!.writtenComment),
                  trailing:
                      const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                ),
                ListTile(
                  tileColor: Theme.of(context).colorScheme.surfaceVariant,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  onTap: () {
                    Get.to(() => const BookmarkPost());
                  },
                  leading: const Icon(Icons.bookmark),
                  title: Text(AppLocalizations.of(context)!.bookmarkPost),
                  trailing:
                      const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                ),
                const SizedBox(
                  height: 24,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context)!.appSetting,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 6),
                ListTile(
                  tileColor: Theme.of(context).colorScheme.surfaceVariant,
                  onTap: () {
                    Get.to(() => const NotificationRegionSetting());
                  },
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  leading: const Icon(Icons.notifications),
                  title: Text(AppLocalizations.of(context)!.pushSetting),
                  trailing:
                      const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                ),
                ListTile(
                  tileColor: Theme.of(context).colorScheme.surfaceVariant,
                  onTap: () {
                    controller.handleLogout();
                  },
                  leading: const Icon(Icons.logout),
                  title: Text(AppLocalizations.of(context)!.logout),
                  trailing:
                      const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                ),
                ListTile(
                  tileColor: Theme.of(context).colorScheme.surfaceVariant,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  onTap: () {
                    print("탈퇴하기");
                  },
                  leading: const Icon(Icons.person_off_rounded),
                  title: Text(AppLocalizations.of(context)!.singout),
                  trailing:
                      const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                )
              ]),
        ));
  }
}
