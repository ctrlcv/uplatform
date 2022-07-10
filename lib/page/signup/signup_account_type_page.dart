import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/border_rounded_image_button.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/user_model.dart';
import 'package:uplatform/page/home/home_page.dart';
import 'package:uplatform/page/signup/signup_expert_by_sns_page.dart';
import 'package:uplatform/page/signup/signup_expert_by_uplatform_page.dart';
import 'package:uplatform/page/signup/signup_normal_by_sns_page.dart';
import 'package:uplatform/page/signup/signup_normal_by_uplatform_page.dart';
import 'package:uplatform/services/login_service.dart';
import 'package:uplatform/services/network.dart';

class SignUpAccountTypePage extends StatefulWidget {
  const SignUpAccountTypePage({Key? key}) : super(key: key);

  static const routeName = '/SignUpAccountTypePage';

  @override
  _SignUpAccountTypePageState createState() => _SignUpAccountTypePageState();
}

class _SignUpAccountTypePageState extends State<SignUpAccountTypePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(iconData: Icons.arrow_back),
        body: Column(
          children: [
            const SizedBox(height: 16),
            const TextTitle(
              titleText: "회원가입에 사용할",
              cellHeight: 32,
              fontSize: 24,
              fontColor: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            const TextTitle(
              titleText: "계정을 선택해 주세요.",
              cellHeight: 32,
              fontSize: 24,
              fontColor: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BorderRoundedImageButton(
                imagePath: "assets/images/icons_account_type_kakao.png",
                buttonText: "카카오톡으로 가입하기",
                onPressed: () async {
                  KakaoUser? kakaoUser = await LoginService().loginByKakao();
                  debugPrint('kakaoUser: $kakaoUser');

                  if (kakaoUser != null) {
                    kakaoUser.id = "kakao_" + kakaoUser.id!;

                    Map<String, dynamic> params = {};
                    params['sns_key'] = kakaoUser.id;
                    LoginUser? user = await Network().reqSnsLogIn(params);

                    debugPrint('user: $user');
                    if (user != null) {
                      if (user.status == "200") {
                        user.email = kakaoUser.email;
                        user.snsKey = kakaoUser.id;
                        LoginService().setLoginUser(user);

                        Get.toNamed(HomePage.routeName);
                      } else {
                        LoginService().setKakaoUser(kakaoUser);
                        if (Get.arguments == "isExpertMember") {
                          Get.toNamed(SignUpExpertBySnsPage.routeName, arguments: "KAKAO");
                        } else {
                          Get.toNamed(SignUpNormalBySnsPage.routeName, arguments: "KAKAO");
                        }
                      }
                    }
                  }
                },
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BorderRoundedImageButton(
                imagePath: "assets/images/icons_account_type_naver.png",
                buttonText: "네이버로 가입하기",
                onPressed: () async {
                  NaverUser? naverUser = await LoginService().loginByNaver();

                  if (naverUser != null) {
                    naverUser.id = "naver_" + naverUser.id!;

                    Map<String, dynamic> params = {};
                    params['sns_key'] = naverUser.id;
                    LoginUser? user = await Network().reqSnsLogIn(params);

                    debugPrint('user: $user');
                    if (user != null) {
                      if (user.status == "200") {
                        user.email = naverUser.email;
                        user.snsKey = naverUser.id;
                        LoginService().setLoginUser(user);

                        Get.toNamed(HomePage.routeName);
                      } else {
                        LoginService().setNaverUser(naverUser);
                        if (Get.arguments == "isExpertMember") {
                          Get.toNamed(SignUpExpertBySnsPage.routeName, arguments: "NAVER");
                        } else {
                          Get.toNamed(SignUpNormalBySnsPage.routeName, arguments: "NAVER");
                        }
                      }
                    }
                  }
                },
              ),
            ),
            const SizedBox(height: 23),
            Container(
              height: 16,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Container(height: 1, color: const Color(0xFFF5F6F8))),
                  const SizedBox(width: 16),
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "또는",
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.1,
                        color: Color(0xFFB1B4B7),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(child: Container(height: 1, color: const Color(0xFFF5F6F8))),
                ],
              ),
            ),
            const SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BorderRoundedButton(
                text: "샤이니오 계정으로 가입하기",
                active: true,
                textColor: Colors.black,
                buttonColor: kMainColor,
                onPressed: () {
                  if (Get.arguments == "isExpertMember") {
                    Get.toNamed(SignUpExpertByUPlatformPage.routeName);
                  } else {
                    Get.toNamed(SignUpNormalByUPlatformPage.routeName);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
