import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:uplatform/models/common_model.dart';
import 'package:uplatform/models/user_model.dart';
import 'package:uplatform/page/start_page.dart';
import 'package:uplatform/services/shared_preference.dart';

import 'network.dart';

class LoginService {
  static final LoginService _singleton = LoginService._internal();

  factory LoginService() {
    return _singleton;
  }

  LoginService._internal() {
    debugPrint('LoginService(Singleton) was created.');
  }

  LoginUser? _loginUser;
  KakaoUser? _kakaoUser;
  NaverUser? _naverUser;

  UserInfo? _userInfo;
  AreaInfo? _areaInfo;
  PartnerInfo? _partnerInfo;

  int _unReadAlarmCount = 0;

  static const MethodChannel _kakaoChannel = MethodChannel("kakao_flutter_sdk");
  static const MethodChannel _naverChannel = MethodChannel('flutter_naver_login');

  Future<bool> isKakaoTalkInstalled() async {
    final isInstalled = await _kakaoChannel.invokeMethod<bool>("isKakaoTalkInstalled") ?? false;

    return isInstalled;
  }

  Future<KakaoUser?> loginByKakao() async {
    bool kakaoTalkInstalled = await isKakaoTalkInstalled();
    OAuthToken? token;

    debugPrint("loginByKakao() kakaoTalkInstalled $kakaoTalkInstalled");
    // TODO : 카카오톡으로 시작 안되는 문제 수정

    if (kakaoTalkInstalled) {
      token = await _loginWithKakaoTalk();
    } else {
      token = await _loginWithKakaoAccount();
    }

    if (token != null) {
      debugPrint("loginByKakao() token is NOT NULL");
      try {
        User user = await UserApi.instance.me();
        // debugPrint('user - $user');
        return KakaoUser(
          id: user.id.toString(),
          nickName: user.properties!['nickname'],
          email: user.kakaoAccount!.email,
        );
      } on KakaoAuthException catch (e) {
        debugPrint("loginByKakao() on KakaoAuthException e: $e");
      } catch (e) {
        debugPrint("loginByKakao() on Exception e: $e");
      }
    } else {
      debugPrint("loginByKakao() token is null");
    }

    return null;
  }

  Future<KakaoUser?> loginByKakaoWithToken() async {
    try {
      User user = await UserApi.instance.me();

      debugPrint("loginByKakaoWithToken: user $user");

      return KakaoUser(
        id: user.id.toString(),
        nickName: user.properties!['nickname'],
        email: user.kakaoAccount!.email,
      );
    } on KakaoAuthException catch (e) {
      debugPrint("loginByKakao() on KakaoAuthException e: $e");
    } catch (e) {
      debugPrint("loginByKakao() on Exception e: $e");
    }

    return null;
  }

  Future<OAuthToken?> _loginWithKakaoTalk() async {
    try {
      return await UserApi.instance.loginWithKakaoAccount();
    } catch (e) {
      debugPrint('error on _loginWithKakaoTalk: $e');
    }
    return null;
  }

  Future<OAuthToken?> _loginWithKakaoAccount() async {
    try {
      return await UserApi.instance.loginWithKakaoAccount();
    } catch (e) {
      debugPrint('error on _loginWithKakaoAccount: $e');
    }

    return null;
  }

  Future loginByNaver() async {
    NaverLoginResult? result = await FlutterNaverLogin.logIn();

    debugPrint('loginByNaver() - result:$result');
    debugPrint('loginByNaver() ${result.errorMessage}');

    if (result.errorMessage == "errorCode:user_cancel, errorDesc:user_cancel") {
      return null;
    }

    NaverUser naverUser = NaverUser(
        id: result.account.id,
        name: result.account.name,
        nickName: result.account.nickname,
        email: result.account.email);

    NaverAccessToken resToken = await FlutterNaverLogin.currentAccessToken;
    debugPrint('loginByNaver() - resToken:$resToken');

    naverUser.accessToken = resToken.accessToken;
    naverUser.refreshToken = resToken.refreshToken;

    return naverUser;
  }

  Future<NaverUser?> loginByNaverWithToken() async {
    NaverAccountResult? result = await FlutterNaverLogin.currentAccount();

    NaverUser naverUser = NaverUser(
      id: result.id,
      name: result.name,
      nickName: result.nickname,
      email: result.email,
    );

    return naverUser;
  }

  void setLoginUser(LoginUser user) {
    _loginUser = user;
  }

  LoginUser? getLoginUser() {
    return _loginUser;
  }

  void setKakaoUser(KakaoUser user) {
    _kakaoUser = user;
  }

  KakaoUser? getKakaoUser() {
    return _kakaoUser;
  }

  void setNaverUser(NaverUser user) {
    _naverUser = user;
  }

  NaverUser? getNaverUser() {
    return _naverUser;
  }

  void setUserInfo(UserInfo userInfo) {
    _userInfo = userInfo;
  }

  UserInfo? getUserInfo() {
    return _userInfo;
  }

  void setUserAreaInfo(AreaInfo areaInfo) {
    _areaInfo = areaInfo;
  }

  AreaInfo? getUserAreaInfo() {
    return _areaInfo;
  }

  void setUserPartnerInfo(PartnerInfo partnerInfo) {
    _partnerInfo = partnerInfo;
  }

  PartnerInfo? getUserPartnerInfo() {
    return _partnerInfo;
  }

  void logOut() async {
    if (_kakaoUser != null) {
      try {
        await UserApi.instance.logout();
      } catch (e) {
        debugPrint('error on logout at Kakao: $e');
      }
    }

    if (_naverUser != null) {
      try {
        await FlutterNaverLogin.logOut();
      } catch (e) {
        debugPrint('error on logout at naver: $e');
      }
    }

    _loginUser = null;
    _kakaoUser = null;
    _naverUser = null;
    _userInfo = null;
    _areaInfo = null;
    _partnerInfo = null;

    SharedPreference().clear();
    Get.offAllNamed(StartPage.routeName);
  }

  Future calcUnReadAlarmCount() async {
    int lastReadAlarmId = int.parse(await SharedPreference().getLastReadAlarmId());

    List<AlarmItem> alarmItemList = [];
    AlarmItemList? alarmList = await Network().reqAlarmList();

    if (alarmList == null || alarmList.status != "200" || alarmList.count == 0) {
      setUnReadAlarmCount(0);
      return;
    }

    alarmItemList = alarmList.result ?? [];

    int unReadAlarmCount = 0;
    for (int i = 0; i < alarmItemList.length; i++) {
      if (int.parse(alarmItemList[i].alarmId ?? "-1") == -1) {
        continue;
      }

      if (int.parse(alarmItemList[i].alarmId ?? "-1") > lastReadAlarmId) {
        unReadAlarmCount++;
      }
    }

    setUnReadAlarmCount(unReadAlarmCount);
    debugPrint("calcUnReadAlarmCount() $unReadAlarmCount");
  }

  void setUnReadAlarmCount(int count) {
    _unReadAlarmCount = count;

    final controller = Get.put(AlarmCountController());
    controller.setUnReadCount(_unReadAlarmCount);
  }

  int getUnReadAlarmCount() {
    debugPrint("getUnReadAlarmCount() return $_unReadAlarmCount");
    return _unReadAlarmCount;
  }
}

class AlarmCountController extends GetxController {
  int unReadCount = 0;

  void setUnReadCount(int count) {
    unReadCount = count;
    update();
  }
}
