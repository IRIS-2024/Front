import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/config/hidden_config.dart';
import 'package:iris_flutter/model/user.dart';
import 'package:iris_flutter/repository/login_repository.dart';

class LoginController extends GetxController {
  Rx<User> user = User(id: '', email: '').obs;

  Future<void> loginGoogle() async {
    GoogleSignIn googleSignIn =
        GoogleSignIn(clientId: HiddenConfig.webClientId);

    await googleSignIn.signIn().then((result) {
      result?.authentication.then((googleKey) {
        print('accessToken: ${googleKey.accessToken}');
        print('idToken: ${googleKey.idToken}');
        print('serverAuthCode: ${result.serverAuthCode}');
        print(googleSignIn.currentUser?.displayName);
        print('google login 성공: $result');

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
    print(idToken);
    print('tokenLogin 진입');
    final dio = createDioWithoutToken();

    try {
      LoginRepository loginRepository = LoginRepository(dio);
      final resp = await loginRepository.getLogin(idToken);
      print('print resp grantType: ${resp.grantType}');
      print('print resp accessToken: ${resp.accessToken}');
      // token storage

      // 유저정보 api로부터 받은 user 정보 local storage에 저장.
    } on DioException catch (e) {
      print('Error ${e.response}');
      return;
    }
  }

  // 최종 로그인
  // Future<void> handleLogin(String email, String nickName) async {
  //   try {
  //     final dio = createDioWithoutToken();
  //     LoginRepository loginRepository = LoginRepository(dio);

  //     if (nickName.length >= 10) {
  //       nickName = nickName.substring(0, 11); // 닉네임 최대 10글자
  //     }

  //     print('$nickName, $email');
  //     final resp = await loginRepository
  //         .postAuthLogin(UserResponse(email: email, nickName: nickName));
  //     print(
  //         '최종 로그인 성공: ${resp.isNew}, ${resp.id}, ${resp.email}, ${resp.nickName}, ${resp.token}');

  //     // 로그인 성공
  //     // storage 에 token 저장
  //     await tokenStorage.write(key: 'token', value: resp.token.toString());
  //     // local storage 에 id, email, nickName 저장
  //     await userStorage.setItem(Config.id, resp.id.toString());
  //     await userStorage.setItem(Config.email, resp.email.toString());
  //     await userStorage.setItem(Config.nickName, resp.nickName.toString());

  //     if (resp.isNew == true) {
  //       // 회원가입인 경우 - 랜덤 레시피 평점 매기기
  //       Get.offAndToNamed('/login_rating');
  //     } else {
  //       // 메인 페이지 이동
  //       Get.offAndToNamed('/main');
  //     }
  //   } on DioException catch (e) {
  //     print('login $e');
  //     return;
  //   }
  // }

  // 로그인 여부 확인
  // Future<void> checkLogin() async {
  //   // 토근 재발급
  //   // 성공 -> 로그인 중. 새로운 토큰 발급 및 저장
  //   // 실패 -> 로그인 상태 아님. 로그아웃.
  //   if (getUserEmail().isEmpty) {
  //     print('checkLogin - No UserEmail 로그인 상태 아님');
  //     return;
  //   }

  //   try {
  //     final dio = createDioWithoutToken();
  //     LoginRepository loginRepository = LoginRepository(dio);

  //     final resp = await loginRepository.postAuthReissue(getUserEmail());
  //     final token = resp.token.toString();
  //     print('checkLogin - 로그인 중: $token');

  //     // storage 에 새로운 token 저장
  //     await tokenStorage.write(key: 'token', value: token);
  //     // 메인화면으로 이동
  //     Get.offAndToNamed('/main');
  //   } on DioException catch (e) {
  //     print('checkLogin: $e');

  //     if (e.response?.statusCode == 401) {
  //       print('checkLogin - 401 Err 로그인 상태 아님');
  //       // 로그아웃
  //       Get.put(LoginController());
  //       Get.find<LoginController>().handleLogout();
  //     }
  //     return;
  //   }
  // }

  void logoutGoogle() async {
    await GoogleSignIn().signOut();
  }

  // 로그아웃
  // void handleLogout() async {
  //   // 소셜 로그인 플랫폼 로그아웃
  //   final social = await userStorage.getItem(Config.social);
  //   print('print social: $social');
  //   if (social == Config.google) {
  //     // 구글 로그아웃
  //     await GoogleSignIn().signOut();
  //   } else if (social == Config.kakao) {
  //     // 카카오 로그아웃
  //     try {
  //       await UserApi.instance.logout();
  //       print('로그아웃 성공, SDK에서 토큰 삭제');
  //     } catch (error) {
  //       print('로그아웃 실패, SDK에서 토큰 삭제 $error');
  //     }
  //   }

  //   // 저장해둔 회원 정보 삭제
  //   await tokenStorage.delete(key: 'token');

  //   await userStorage.deleteItem(Config.id);
  //   await userStorage.deleteItem(Config.email);
  //   await userStorage.deleteItem(Config.nickName);
  //   await userStorage.deleteItem(Config.social);

  //   // 다른 페이지에서 로그아웃 요청 -> 로그인 페이지로 이동
  //   // 로그인 페이지에서 로그인 여부 확인 후 로그인 상태 아니어서 로그아웃 요청 -> 페이지 이동 x
  //   if (!Get.currentRoute.contains('/login')) {
  //     Get.offAndToNamed('/login');
  //   }
  // }

  void updateInfo(User data) {
    user.value = data;
  }

  void deleteInfo() {
    // logout 시 초기화
    user.value = User(id: '', email: '');
  }
}
