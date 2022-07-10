import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/check_box.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/page/signup/signup_account_type_page.dart';
import 'package:uplatform/page/signup/signup_expert_by_sns_page.dart';
import 'package:uplatform/page/signup/signup_expert_by_uplatform_page.dart';
import 'package:uplatform/page/signup/signup_normal_by_sns_page.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:uplatform/page/signup/signup_normal_by_uplatform_page.dart';

class SignUpMemberTypePage extends StatefulWidget {
  const SignUpMemberTypePage({Key? key}) : super(key: key);

  static const routeName = '/SignUpMemberTypePage';

  @override
  _SignUpMemberTypePageState createState() => _SignUpMemberTypePageState();
}

class _SignUpMemberTypePageState extends State<SignUpMemberTypePage> {
  bool _isSelectedNormalMember = false;
  bool _isSelectedProfessionalMember = false;

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
              titleText: "회원 유형을",
              cellHeight: 32,
              fontSize: 24,
              fontColor: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            const TextTitle(
              titleText: "선택해 주세요.",
              cellHeight: 32,
              fontSize: 24,
              fontColor: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _isSelectedNormalMember = true;
                        _isSelectedProfessionalMember = false;
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            const SizedBox(height: 28),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: _isSelectedNormalMember ? kMainColor : const Color(0xFFE4E7ED),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  const SizedBox(height: 28),
                                  Image.asset(
                                    "assets/images/member_normal.png",
                                    width: 44,
                                    height: 44,
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    height: 22,
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "일반회원",
                                      style: TextStyle(
                                        fontSize: 18,
                                        height: 1.1,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    height: 16,
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "공간 정리가",
                                      style: TextStyle(
                                        fontSize: 13,
                                        height: 1.1,
                                        color: Color(0xFF686C73),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 16,
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "필요해요.",
                                      style: TextStyle(
                                        fontSize: 13,
                                        height: 1.1,
                                        color: Color(0xFF686C73),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            CheckBox(isSelected: _isSelectedNormalMember),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _isSelectedNormalMember = false;
                        _isSelectedProfessionalMember = true;
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            const SizedBox(height: 28),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: _isSelectedProfessionalMember ? kMainColor : const Color(0xFFE4E7ED),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  const SizedBox(height: 28),
                                  Image.asset(
                                    "assets/images/member_professional.png",
                                    width: 44,
                                    height: 44,
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    height: 22,
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "전문가회원",
                                      style: TextStyle(
                                        fontSize: 18,
                                        height: 1.1,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    height: 16,
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "공간 정리,",
                                      style: TextStyle(
                                        fontSize: 13,
                                        height: 1.1,
                                        color: Color(0xFF686C73),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 16,
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "맡겨만 주세요!",
                                      style: TextStyle(
                                        fontSize: 13,
                                        height: 1.1,
                                        color: Color(0xFF686C73),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            CheckBox(isSelected: _isSelectedProfessionalMember),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BorderRoundedButton(
                text: "다음",
                active: (_isSelectedNormalMember || _isSelectedProfessionalMember),
                buttonColor: kMainColor,
                onPressed: () {
                  if (!_isSelectedNormalMember && !_isSelectedProfessionalMember) {
                    return;
                  }

                  if (Get.arguments == "KAKAO") {
                    if (_isSelectedProfessionalMember) {
                      Get.toNamed(SignUpExpertBySnsPage.routeName, arguments: "KAKAO");
                    } else {
                      Get.toNamed(SignUpNormalBySnsPage.routeName, arguments: "KAKAO");
                    }
                  } else if (Get.arguments == "NAVER") {
                    if (_isSelectedProfessionalMember) {
                      Get.toNamed(SignUpExpertBySnsPage.routeName, arguments: "NAVER");
                    } else {
                      Get.toNamed(SignUpNormalBySnsPage.routeName, arguments: "NAVER");
                    }
                  } else {
                    if (UniversalPlatform.isAndroid) {
                      Get.toNamed(SignUpAccountTypePage.routeName,
                          arguments: _isSelectedProfessionalMember ? "isExpertMember" : "");
                      return;
                    }

                    if (_isSelectedProfessionalMember) {
                      Get.toNamed(SignUpExpertByUPlatformPage.routeName);
                    } else {
                      Get.toNamed(SignUpNormalByUPlatformPage.routeName);
                    }
                  }
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
}
