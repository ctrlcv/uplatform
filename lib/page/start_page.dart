import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/user_model.dart';
import 'package:uplatform/page/signin/login_email_page.dart';
import 'package:uplatform/page/signin/permission_page.dart';
import 'package:uplatform/page/signup/signup_terms_page.dart';
import 'package:uplatform/services/firebase_service.dart';
import 'package:uplatform/services/login_service.dart';
import 'package:uplatform/services/network.dart';
import 'package:uplatform/services/service_list.dart';
import 'package:uplatform/services/shared_preference.dart';

import 'expert/expert_home_page.dart';
import 'home/home_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  static const routeName = '/StartPage';

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();

    FirebaseService().initialize();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      if (!UniversalPlatform.isWeb) {
        if (await checkPermission(context) == true) {
          return;
        }
      }

      if (await checkAutoLogin() == true) {
        return;
      }

      if (await checkKakaoLogin() == true) {
        await autoLoginByKakao();
        return;
      }

      if (await checkNaverLogin() == true) {
        debugPrint("checkNaverLogin() return true");
        await autoLoginByNaver();
      }
    });

    ServiceList().loadItems();
  }

  Future<bool> checkAutoLogin() async {
    bool isAutoLogin = await SharedPreference().getKeepMeLogIn();

    if (isAutoLogin) {
      String userId = await SharedPreference().getUserId();
      String password = await SharedPreference().getPassword();

      Map<String, dynamic> params = {};
      params['email'] = userId;
      params['password'] = password;

      LoginUser? user = await Network().reqLogIn(params);

      if (user != null) {
        if (user.status == "200") {
          user.email = userId;
          LoginService().setLoginUser(user);

          if (user.type == "0") {
            Get.offAllNamed(HomePage.routeName);
          } else {
            Get.offAllNamed(ExpertHomePage.routeName);
          }

          return true;
        } else {
          Get.snackbar(
            '로그인 오류',
            user.message!,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(milliseconds: 1500),
          );

          return false;
        }
      }
    }
    return false;
  }

  Future<bool?> checkKakaoLogin() async {
    if (UniversalPlatform.isWeb) {
      return false;
    }

    return (await AuthApi.instance.hasToken() == false);
  }

  Future autoLoginByKakao() async {
    KakaoUser? kakaoUser = await LoginService().loginByKakaoWithToken();
    if (kakaoUser != null) {
      await startWithKakaoUser(kakaoUser);
    }
  }

  Future<bool?> checkNaverLogin() async {
    if (UniversalPlatform.isWeb) {
      return false;
    }

    return await FlutterNaverLogin.isLoggedIn;
  }

  Future autoLoginByNaver() async {
    NaverUser? naverUser = await LoginService().loginByNaverWithToken();

    if (naverUser != null) {
      await startWithNaverUser(naverUser);
    }
  }

  Future<bool?> checkPermission(BuildContext context) async {
    bool sharedCheckedPermission = await SharedPreference().getCheckedPermission();
    debugPrint("initState() sharedCheckedPermission: $sharedCheckedPermission");

    if (!sharedCheckedPermission) {
      bool permitted = await checkIfPermissionGranted(context);

      debugPrint("initState() permitted: $permitted");
      if (!permitted) {
        Get.toNamed(PermissionPage.routeName);
        return true;
      }

      return false;
    }

    return false;
  }

  Future<bool> checkIfPermissionGranted(BuildContext context) async {
    if (UniversalPlatform.isIOS) {
      var cameraStatus = await Permission.camera.status;
      var photosStatus = await Permission.photos.status;

      return (photosStatus.isGranted && cameraStatus.isGranted);
    } else {
      var cameraStatus = await Permission.camera.status;
      var storageStatus = await Permission.storage.status;

      return (cameraStatus.isGranted && storageStatus.isGranted);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        body: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/title.png",
                      width: 180,
                      fit: BoxFit.fitWidth,
                    ),
                    const SizedBox(height: 23),
                    const SizedBox(
                      height: 22,
                      child: Text(
                        "빛나는 일상, 윤택한 공간",
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.0,
                          color: Color(0xFF686C73),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                      child: Text(
                        "샤이니오!",
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.0,
                          color: Color(0xFF686C73),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 48),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: const Color(0xFFE4E7ED),
                        ),
                      ),
                      const SizedBox(width: 17),
                      const Text(
                        "다음 계정으로 로그인",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 17),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: const Color(0xFFE4E7ED),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (UniversalPlatform.isAndroid)
                        GestureDetector(
                          onTap: () async {
                            KakaoUser? kakaoUser = await LoginService().loginByKakao();
                            debugPrint('kakaoUser: $kakaoUser');

                            if (kakaoUser != null) {
                              bool started = await startWithKakaoUser(kakaoUser);

                              if (!started) {
                                Get.toNamed(SignUpTermsPage.routeName, arguments: "KAKAO");
                              }
                            }
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/icons_login_kakao.png",
                                width: 60,
                                height: 60,
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 16,
                                alignment: Alignment.center,
                                child: const Text(
                                  "카카오톡",
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 1.0,
                                    color: Color(0xFF686C73),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (UniversalPlatform.isAndroid) const SizedBox(width: 24),
                      if (UniversalPlatform.isAndroid)
                        GestureDetector(
                          onTap: () async {
                            NaverUser? naverUser = await LoginService().loginByNaver();

                            if (naverUser != null) {
                              bool started = await startWithNaverUser(naverUser);

                              if (!started) {
                                Get.toNamed(SignUpTermsPage.routeName, arguments: "NAVER");
                              }
                            }
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/icons_login_naver.png",
                                width: 60,
                                height: 60,
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 16,
                                alignment: Alignment.center,
                                child: const Text(
                                  "네이버",
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 1.0,
                                    color: Color(0xFF686C73),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (UniversalPlatform.isAndroid) const SizedBox(width: 24),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(LoginEmailPage.routeName);
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFFE4E7ED), width: 1),
                                borderRadius: BorderRadius.circular(60.0),
                              ),
                              child: const Icon(
                                Icons.email_outlined,
                                color: Color(0xFF323232),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 16,
                              alignment: Alignment.center,
                              child: const Text(
                                "이메일",
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.0,
                                  color: Color(0xFF686C73),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "아직 회원이 아니신가요?",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF898D93),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(SignUpTermsPage.routeName);
                          },
                          child: const Text(
                            "회원가입",
                            style: TextStyle(
                              fontSize: 13,
                              color: kBlueColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            ),
            buildBottomBar
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      actions: [
        GestureDetector(
          onTap: () {
            Get.offAllNamed(HomePage.routeName);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 16,
            alignment: Alignment.center,
            child: const Text(
              "둘러보기",
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF898D93),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<bool> startWithKakaoUser(KakaoUser kakaoUser) async {
    if (kakaoUser.id!.contains("kakao_") == false) {
      kakaoUser.id = "kakao_" + kakaoUser.id!;
      LoginService().setKakaoUser(kakaoUser);
    }

    Map<String, dynamic> params = {};
    params['sns_key'] = kakaoUser.id;
    LoginUser? user = await Network().reqSnsLogIn(params);

    debugPrint('user: $user');
    if (user != null) {
      if (user.status == "200") {
        user.email = kakaoUser.email;
        user.snsKey = kakaoUser.id;
        LoginService().setLoginUser(user);

        if (user.type == "1") {
          Get.offAllNamed(ExpertHomePage.routeName);
        } else {
          Get.offAllNamed(HomePage.routeName);
        }
        return true;
      }
    }

    return false;
  }

  Future<bool> startWithNaverUser(NaverUser naverUser) async {
    if (naverUser.id!.contains("naver_") == false) {
      naverUser.id = "naver_" + naverUser.id!;
      LoginService().setNaverUser(naverUser);
    }

    Map<String, dynamic> params = {};
    params['sns_key'] = naverUser.id;
    LoginUser? user = await Network().reqSnsLogIn(params);

    debugPrint('user: $user');
    if (user != null) {
      if (user.status == "200") {
        user.email = naverUser.email;
        user.snsKey = naverUser.id;
        LoginService().setLoginUser(user);

        if (user.type == "1") {
          Get.offAllNamed(ExpertHomePage.routeName);
        } else {
          Get.offAllNamed(HomePage.routeName);
        }
        return true;
      }
    }

    return false;
  }
}
