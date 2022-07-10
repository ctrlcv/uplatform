import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/page/expert/expert_home_page.dart';
import 'package:uplatform/page/home/home_page.dart';

class SignUpFinish extends StatelessWidget {
  const SignUpFinish({Key? key}) : super(key: key);

  static const routeName = '/SignUpFinish';

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
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/icons_face_smile_with_heart.png",
                      width: 60,
                      height: 60,
                    ),
                    const SizedBox(height: 32),
                    Container(
                      height: 32,
                      alignment: Alignment.center,
                      child: const Text(
                        "샤이니오 회원가입이",
                        style: TextStyle(
                          fontSize: 24,
                          height: 1.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      height: 32,
                      alignment: Alignment.center,
                      child: const Text(
                        "완료되었어요!",
                        style: TextStyle(
                          fontSize: 24,
                          height: 1.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (Get.arguments == "isExpertMember")
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    const TextTitle(
                      titleText: "안내사항",
                      cellHeight: 18,
                      fontSize: 15,
                      fontColor: Color(0xFF686C73),
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 18,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Container(
                            width: 2,
                            height: 2,
                            decoration: BoxDecoration(
                              color: const Color(0xFF898D93),
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "전문가(파트너)회원 심사 중입니다.",
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.2,
                              color: Color(0xFF686C73),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 18,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Container(
                            width: 2,
                            height: 2,
                            decoration: BoxDecoration(
                              color: const Color(0xFF898D93),
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "심사 완료까지는 영업일 기준 2일",
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.2,
                              color: Color(0xFF10A2DC),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Text(
                            "이 소요될 예정입니다.",
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.2,
                              color: Color(0xFF686C73),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 18,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Container(
                            width: 2,
                            height: 2,
                            decoration: BoxDecoration(
                              color: const Color(0xFF898D93),
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "승인 완료 후 서비스를 이용하실 수 있습니다.",
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.2,
                              color: Color(0xFF686C73),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 2,
                            height: 18,
                            alignment: Alignment.center,
                            child: Container(
                              width: 2,
                              height: 2,
                              decoration: BoxDecoration(
                                color: const Color(0xFF898D93),
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              "승인 완료 시 카카오톡 일림으로 서비스 이용여부를 확인하실 수 있습니다.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 13,
                                height: 1.2,
                                color: Color(0xFF686C73),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BorderRoundedButton(
                text: "카카오톡으로 문의하기",
                textColor: const Color(0xFF686C73),
                buttonColor: Colors.white,
                onPressed: () {
                  // TODO : 카카오톡 API 연결
                  Get.back();
                },
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BorderRoundedButton(
                text: "샤이니오 둘러보기",
                buttonColor: kMainColor,
                onPressed: () {
                  if (Get.arguments == "isExpertMember") {
                    Get.offAllNamed(ExpertHomePage.routeName);
                  } else {
                    Get.offAllNamed(HomePage.routeName);
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
