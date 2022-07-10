import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/page/signin/find_password_page.dart';
import 'package:uplatform/page/signin/login_email_page.dart';

import '../../models/user_model.dart';
import '../../services/login_service.dart';
import '../../services/network.dart';
import '../expert/expert_home_page.dart';
import '../home/home_page.dart';
import '../signup/signup_terms_page.dart';

class FindIdFinishPage extends StatefulWidget {
  const FindIdFinishPage({Key? key}) : super(key: key);

  static const routeName = '/FindIdFinishPage';

  @override
  _FindIdFinishPageState createState() => _FindIdFinishPageState();
}

class _FindIdFinishPageState extends State<FindIdFinishPage> {
  String? _email = "";
  String? _snsKey = "";

  @override
  void initState() {
    super.initState();

    Map<String, dynamic> argumentsParams = Get.arguments;

    _email = argumentsParams['email'];
    _snsKey = argumentsParams['snskey'];

    debugPrint("before _email: $_email");

    List<String> emails = _email!.split("@");
    String name = emails[0];

    if (name.length <= 2) {
      name = name[0] + "*";
    } else if (name.length <= 3) {
      name = name[0] + "**";
    } else if (name.length <= 4) {
      name = name[0] + "***";
    } else if (name.length <= 5) {
      name = name[0] + "***" + name[4];
    } else {
      name = name[0] + name[1] + "***" + name.substring(5, name.length);
    }

    _email = name + "@" + emails[1];

    debugPrint("after _email: $_email");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(iconData: Icons.close),
        body: Column(
          children: [
            const SizedBox(height: 80),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/icons_face_smile.png",
                      width: 60,
                      height: 60,
                    ),
                    const SizedBox(height: 32),
                    Container(
                      height: 32,
                      alignment: Alignment.center,
                      child: const Text(
                        "아이디 찾기가 완료되었어요.",
                        style: TextStyle(
                          fontSize: 24,
                          height: 1.1,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (_snsKey == null || _snsKey!.isEmpty)
                      Container(
                        height: 21,
                        alignment: Alignment.center,
                        child: const Text(
                          "인증하신 휴대폰으로 등록된 계정입니다.",
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.1,
                            color: Color(0xFF898D93),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    else
                      Container(
                        height: 21,
                        alignment: Alignment.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_snsKey == "KAKAO")
                              const Text(
                                "카카오 계정",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF10A2DC),
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            else if (_snsKey == "NAVER")
                              const Text(
                                "네이버 계정",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF10A2DC),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            const Text(
                              "으로 가입되어 있습니다.",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF898D93),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 28),
                    Container(
                      height: 22,
                      alignment: Alignment.center,
                      child: Text(
                        _email ?? "",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BorderRoundedButton(
                text: (_snsKey != null && _snsKey == "KAKAO")
                    ? "카카오로 로그인"
                    : (_snsKey != null && _snsKey == "NAVER")
                        ? "네이버로 로그인"
                        : "로그인",
                active: true,
                buttonColor: kMainColor,
                onPressed: () async {
                  if (_snsKey == null || _snsKey!.isEmpty) {
                    Get.offNamed(LoginEmailPage.routeName);
                  } else if (_snsKey == "KAKAO") {
                    KakaoUser? kakaoUser = await LoginService().loginByKakao();

                    if (kakaoUser != null) {
                      bool started = await startWithKakaoUser(kakaoUser);

                      if (!started) {
                        Get.toNamed(SignUpTermsPage.routeName, arguments: "KAKAO");
                      }
                    }
                  } else if (_snsKey == "NAVER") {
                    NaverUser? naverUser = await LoginService().loginByNaver();

                    if (naverUser != null) {
                      bool started = await startWithNaverUser(naverUser);

                      if (!started) {
                        Get.toNamed(SignUpTermsPage.routeName, arguments: "NAVER");
                      }
                    }
                  }
                },
              ),
            ),
            if (_snsKey == null || _snsKey!.isEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
                child: BorderRoundedButton(
                  text: "비밀번호 찾기",
                  textColor: Colors.black,
                  buttonColor: Colors.white,
                  onPressed: () {
                    Get.offNamed(FindPasswordPage.routeName);
                  },
                ),
              ),
            const SizedBox(height: 32),
            buildBottomBar
          ],
        ),
      ),
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
