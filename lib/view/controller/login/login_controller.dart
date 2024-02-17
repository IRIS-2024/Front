import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/config/hidden_config.dart';
import 'package:iris_flutter/model/user.dart';
import 'package:iris_flutter/repository/login_repository.dart';
import 'package:iris_flutter/utils/user_profile_utils.dart';
import 'package:iris_flutter/view/page/login/login_page.dart';
import 'package:iris_flutter/view/page/main/main_page.dart';

class LoginController extends GetxController {
  Rx<User> user = User(id: '', email: '').obs;

  Future<void> loginGoogle() async {
    GoogleSignIn googleSignIn;

    if (Platform.isAndroid) {
      googleSignIn =
      GoogleSignIn(clientId: HiddenConfig.webClientId);
    } else {
      googleSignIn =
      GoogleSignIn(serverClientId: HiddenConfig.webClientId,
      );
    }

    await googleSignIn.signIn().then((result) {
      result?.authentication.then((googleKey) {
        tokenLogin(result.serverAuthCode!);
      }).catchError((err) {
        print('inner error');
      });
    }).catchError((err) {
      print('error occured: $err');
    });
    await userStorage.setItem(Config.social, Config.google);
  }



  Future<void> tokenLogin(String idToken) async {
    final dio = createDioWithoutToken();

    try {
      LoginRepository loginRepository = LoginRepository(dio);
      final resp = await loginRepository.getLogin(idToken);
      // token storage에 token 저장
      await tokenStorage.write(
          key: 'AccessToken', value: resp.accessToken.toString());
      await tokenStorage.write(
          key: 'RefreshToken', value: resp.refreshToken.toString());

      // setUserInfo(); // 유저정보 api로부터 받은 user 정보 local storage에 저장.
      Get.offAll(() => const MainPage()); // api 없어서 임시
    } on DioException catch (e) {
      print('Error tokenLogin ${e.response}');
      return;
    }
  }

  // 최종 로그인
  Future<void> setUserInfo() async {
    try {
      final dio = createDioWithoutToken();
      LoginRepository loginRepository = LoginRepository(dio);
      // 사용자 정보 요청 API
      // final resp = await loginRepository.getLogin(idToken);

      // local storage 에 id, email, nickName 저장
      // await userStorage.setItem(Config.id, resp.id.toString());
      // await userStorage.setItem(Config.email, resp.email.toString());
      // await userStorage.setItem(Config.nickName, resp.nickName.toString());

      Get.offAll(() => const MainPage());
    } on DioException catch (e) {
      print('login $e');
      return;
    }
  }

  // 로그인 여부 확인
  Future<void> checkLogin() async {
    // 토근 재발급
    // 성공 -> 로그인 중. 새로운 토큰 발급 및 저장
    // 실패 -> 로그인 상태 아님. 로그아웃.
    if (getUserEmail().isEmpty) {
      print('checkLogin - No UserEmail 로그인 상태 아님');
      return;
    }

    try {
      final dio = createDioWithoutToken();
      LoginRepository loginRepository = LoginRepository(dio);

      final refreshToken = await getRT();

      final resp = await loginRepository.getRefreshToken(refreshToken);
      final token = resp.accessToken.toString();
      print('checkLogin - 로그인 중: $token');

      // storage 에 새로운 token 저장
      await tokenStorage.write(key: 'AccessToken', value: token);
      // 메인화면으로 이동
      Get.offAll(() => const MainPage());
    } on DioException catch (e) {
      print('checkLogin: $e');

      if (e.response?.statusCode == 401) {
        print('checkLogin - 401 Err 로그인 상태 아님');
        // 로그아웃
        Get.put(LoginController());
        Get.find<LoginController>().handleLogout();
      }
      return;
    }
  }

  // 로그아웃
  void handleLogout() async {
    // 소셜 로그인 플랫폼 로그아웃
    final social = await userStorage.getItem(Config.social);
    print('print social: $social');
    if (social == Config.google) {
      // 구글 로그아웃
      await GoogleSignIn().signOut();
    }

    // 저장해둔 회원 정보 삭제
    await tokenStorage.delete(key: 'AccessToken');
    await tokenStorage.delete(key: 'RefreshToken');

    await userStorage.deleteItem(Config.id);
    await userStorage.deleteItem(Config.email);
    await userStorage.deleteItem(Config.displayName);
    await userStorage.deleteItem(Config.social);

    // 다른 페이지에서 로그아웃 요청 -> 로그인 페이지로 이동
    // 로그인 페이지에서 로그인 여부 확인 후 로그인 상태 아니어서 로그아웃 요청 -> 페이지 이동 x
    if (!Get.currentRoute.contains('/login')) {
      Get.offAll(() => const LoginPage());
    }
  }

  void updateInfo(User data) {
    user.value = data;
  }

  void deleteInfo() {
    // logout 시 초기화
    user.value = User(id: '', email: '');
  }
}
