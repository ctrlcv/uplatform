import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/page/signin/login_email_page.dart';

class FindIdFailPage extends StatefulWidget {
  const FindIdFailPage({Key? key}) : super(key: key);

  static const routeName = '/FindIdFailPage';

  @override
  _FindIdFailPageState createState() => _FindIdFailPageState();
}

class _FindIdFailPageState extends State<FindIdFailPage> {
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
                      "assets/images/icons_face_frown.png",
                      width: 60,
                      height: 60,
                    ),
                    const SizedBox(height: 32),
                    Container(
                      height: 32,
                      alignment: Alignment.center,
                      child: const Text(
                        "이런!",
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
                        "아이디 찾기에 실패했어요.",
                        style: TextStyle(
                          fontSize: 24,
                          height: 1.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    if (Get.arguments == null || Get.arguments.isEmpty)
                      Container(
                        height: 21,
                        alignment: Alignment.center,
                        child: const Text(
                          "인증하신 휴대폰으로 가입된 이력이 없습니다.",
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.2,
                            color: Color(0xFF898D93),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    else
                      Container(
                        height: 21,
                        alignment: Alignment.center,
                        child: const Text(
                          "휴대폰으로 인증에 실패하였습니다.",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF898D93),
                            fontWeight: FontWeight.w400,
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
                text: "확인",
                textColor: Colors.black,
                buttonColor: Colors.white,
                onPressed: () {
                  Get.offNamed(LoginEmailPage.routeName);
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
