import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/border_rounded_check_button.dart';
import 'package:uplatform/components/check_box.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/page/signin/terms_page.dart';
import 'package:uplatform/page/signup/signup_member_type_page.dart';

class SignUpTermsPage extends StatefulWidget {
  const SignUpTermsPage({Key? key}) : super(key: key);

  static const routeName = '/SignUpTermsPage';

  @override
  _SignUpTermsPageState createState() => _SignUpTermsPageState();
}

class _SignUpTermsPageState extends State<SignUpTermsPage> {
  bool _agreeTerms = false;
  bool _agreeTermsService = false;
  bool _agreeTermsPersonalInfo = false;

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
              titleText: "샤이니오 사용을 위해",
              cellHeight: 32,
              fontSize: 24,
              fontColor: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            const TextTitle(
              titleText: "이용약관에 동의해 주세요.",
              cellHeight: 32,
              fontSize: 24,
              fontColor: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 40),
            BorderRoundedCheckButton(
              text: "전체 내용에 동의합니다.",
              isSelected: _agreeTerms,
              onPressed: () {
                _agreeTerms = !_agreeTerms;

                if (_agreeTerms) {
                  _agreeTermsService = true;
                  _agreeTermsPersonalInfo = true;
                } else {
                  _agreeTermsService = false;
                  _agreeTermsPersonalInfo = false;
                }

                if (mounted) {
                  setState(() {});
                }
              },
            ),
            const SizedBox(height: 30),
            TermsItem(
              title: "(필수) 서비스 약관동의",
              agreeTerms: _agreeTermsService,
              onPressed: () {
                _agreeTermsService = !_agreeTermsService;
                checkAgreeTermsAll();
                if (mounted) {
                  setState(() {});
                }
              },
              onExpand: () {
                Get.toNamed(TermsPage.routeName, arguments: "서비스 이용약관");
              },
            ),
            const SizedBox(height: 24),
            TermsItem(
              title: "(필수) 개인정보 처리방침",
              agreeTerms: _agreeTermsPersonalInfo,
              onPressed: () {
                _agreeTermsPersonalInfo = !_agreeTermsPersonalInfo;
                checkAgreeTermsAll();
                if (mounted) {
                  setState(() {});
                }
              },
              onExpand: () {
                Get.toNamed(TermsPage.routeName, arguments: "개인정보 처리방침");
              },
            ),
            const SizedBox(height: 24),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BorderRoundedButton(
                text: "다음",
                active: _agreeTermsService && _agreeTermsPersonalInfo,
                buttonColor: kMainColor,
                onPressed: () {
                  Get.toNamed(SignUpMemberTypePage.routeName, arguments: Get.arguments);
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

  void checkAgreeTermsAll() {
    _agreeTerms = _agreeTermsService && _agreeTermsPersonalInfo;
  }
}

class TermsItem extends StatelessWidget {
  const TermsItem({
    Key? key,
    this.title = "",
    this.agreeTerms = false,
    required this.onPressed,
    required this.onExpand,
  }) : super(key: key);

  final String title;
  final bool agreeTerms;
  final GestureTapCallback onPressed;
  final GestureTapCallback onExpand;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          GestureDetector(
            onTap: onPressed,
            child: CheckBox(isSelected: agreeTerms),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: onPressed,
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.1,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onExpand,
            child: Container(
              width: 38,
              padding: const EdgeInsets.only(right: 8),
              alignment: Alignment.centerRight,
              child: const Icon(Icons.arrow_forward_ios, size: 18, color: Color(0xFF898D93)),
            ),
          ),
        ],
      ),
    );
  }
}
