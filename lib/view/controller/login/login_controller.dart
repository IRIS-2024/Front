import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/config/hidden_config.dart';
import 'package:iris_flutter/model/user.dart';
import 'package:iris_flutter/repository/login_repository.dart';
import 'package:iris_flutter/utils/user_profile_utils.dart';

class LoginController extends GetxController {
  Rx<User> user = User(id: '', email: '').obs;

  Future<void> loginGoogle() async {
    GoogleSignIn googleSignIn;
    googleSignIn = GoogleSignIn(serverClientId: HiddenConfig.webClientId);

    await googleSignIn.signIn().then((result) {
      result?.authentication.then((googleKey) {
        tokenLogin(result.serverAuthCode!);
        log('currentUser: ${googleSignIn.currentUser}');
        tempSaveUser(googleSignIn);
      }).catchError((err) {
        log('inner error');
      });
    }).catchError((err) {
      log('error occured: $err');
    });
    await userStorage.setItem(Config.social, Config.google);
  }

  Future<void> tempSaveUser(GoogleSignIn googleSignIn) async {
    log("사용자 정보 임시 저장");
    // local storage 에 id, email, nickName 저장 (임시)
    await userStorage.setItem(Config.id, googleSignIn.currentUser?.id);
    await userStorage.setItem(Config.email, googleSignIn.currentUser?.email);
    await userStorage.setItem(
        Config.displayName, googleSignIn.currentUser?.displayName);
  }

  Future<void> tokenLogin(String idToken) async {
    final dio = createDioWithoutToken();

    try {
      LoginRepository loginRepository = LoginRepository(dio);
      final resp = await loginRepository.getLogin(idToken);
      // token storage에 token 저장
      final at = resp
          .accessToken; // * The variable name 'AT' isn't a lowerCamelCase identifier
      final rt = resp.refreshToken;
      log('tokenLogin resp: \n rt: ${resp.refreshToken} \n at: ${resp.accessToken} ');
      await tokenStorage.write(key: 'AccessToken', value: at);
      await tokenStorage.write(key: 'RefreshToken', value: rt);

      // log("tokenLogin에서의 getUserEmail(): ${getUserEmail()}");

      // setUserInfo(); // 유저정보 api로부터 받은 user 정보 local storage에 저장.
      // Get.offAll(() => const MainPage()); // api 없어서 임시
      Get.offAllNamed(Config.routerMain);
    } on DioException catch (e) {
      log('Error tokenLogin ${e.response}');
      return;
    }
  }

  // 최종 로그인 ->
  // Future<void> setUserInfo() async {
  //   try {
  //     final dio = createDioWithoutToken();
  //     LoginRepository loginRepository = LoginRepository(dio);
  //     // 사용자 정보 요청 API
  //     // final resp = await loginRepository.getLogin(idToken);
  //
  //     // local storage 에 id, email, nickName 저장
  //     // await userStorage.setItem(Config.id, resp.id);
  //     // await userStorage.setItem(Config.email, resp.email);
  //     // await userStorage.setItem(Config.nickName, resp.displayName);
  //
  //     Get.offAll(() => const MainPage());
  //   } on DioException catch (e) {
  //     log('login $e');
  //     return;
  //   }
  // }

  // 로그인 여부 확인
  Future<void> checkLogin() async {
    // 토근 재발급
    // 성공 -> 로그인 중. 새로운 토큰 발급 및 저장
    // 실패 -> 로그인 상태 아님. 로그아웃.

    // if (getUserEmail().isEmpty) {
    //   log('checkLogin - No UserEmail 로그인 상태 아님');
    //   // 로그아웃됨
    //   // 처음 로그인으로
    //   return;
    // } else {
    //   log(">> checkLogin에서의 getUserEmail(): ${getUserEmail()}");
    // }

    try {
      final dio = createDioWithoutToken();
      LoginRepository loginRepository = LoginRepository(dio);

      final refreshToken = await getRT();
      log('요청 전 refreshToken: $refreshToken');

      final resp = await loginRepository.getRefreshToken(refreshToken);
      log('resp: $resp ${resp.accessToken} ${resp.refreshToken}');
      final at = resp.accessToken;
      final rt = resp.refreshToken;

      // storage 에 새로운 token 저장
      await tokenStorage.write(key: 'AccessToken', value: at);
      await tokenStorage.write(key: 'RefreshToken', value: rt);

      // 메인화면으로 이동
      Get.offAllNamed(Config.routerMain);
    } on DioException catch (e) {
      log('checkLogin:: ${e.response}');

      if (e.response?.statusCode == 401) {
        log('checkLogin - 401 Err 로그인 상태 아님');
        // 로그아웃
        handleLogout();
      }
      return;
    }
  }

  // 로그아웃
  void handleLogout() async {
    // 소셜 로그인 플랫폼 로그아웃
    final social = await userStorage.getItem(Config.social);
    log('social Platform: $social');
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
    if (!Get.currentRoute.contains(Config.routerLogin)) {
      Get.offAllNamed(Config.routerLogin);
    }
  }
}
