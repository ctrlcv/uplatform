import 'package:flutter/material.dart';

import '../../components/border_rounded_button.dart';
import '../../components/custom_appbar.dart';
import '../../constants/constants.dart';
import 'package:get/get.dart';

import 'login_email_page.dart';

class FindPasswordFinishPage extends StatefulWidget {
  const FindPasswordFinishPage({Key? key}) : super(key: key);

  static const routeName = '/FindPasswordFinishPage';

  @override
  _FindPasswordFinishPageState createState() => _FindPasswordFinishPageState();
}

class _FindPasswordFinishPageState extends State<FindPasswordFinishPage> {
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
                        "비밀번호 찾기가 완료되었어요.",
                        style: TextStyle(
                          fontSize: 24,
                          height: 1.1,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "변경하신 비밀번호로 로그인하세요.",
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.1,
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
                text: "로그인",
                active: true,
                buttonColor: kMainColor,
                onPressed: () async {
                  Get.back();
                }
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
