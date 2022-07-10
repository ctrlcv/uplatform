import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/input_edit_text_underline.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/dialogs/certification_dialog.dart';
import 'package:uplatform/page/signin/new_password_page.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:iamport_flutter/model/certification_data.dart';

import '../../dialogs/notice_dialog.dart';
import '../../models/common_model.dart';
import '../../services/network.dart';
import '../common/phone_certification.dart';

class FindPasswordPage extends StatefulWidget {
  const FindPasswordPage({Key? key}) : super(key: key);

  static const routeName = '/FindPasswordPage';

  @override
  _FindPasswordPageState createState() => _FindPasswordPageState();
}

class _FindPasswordPageState extends State<FindPasswordPage> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'FindId');

  final TextEditingController _emailEditController = TextEditingController();
  final FocusNode _emailEditFocus = FocusNode();

  final TextEditingController _phoneEditController = TextEditingController();
  final FocusNode _phoneEditFocus = FocusNode();

  bool _isVerifiedPhone = false;
  bool _setReadOnly = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailEditController.dispose();
    _emailEditFocus.dispose();

    _phoneEditController.dispose();
    _phoneEditFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(iconData: Icons.close),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 16),
              const TextTitle(
                titleText: "비밀번호를 잊으셨나요?",
                cellHeight: 32,
                fontSize: 24,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "정보 입력 후 비밀번호를 재설정 하실 수 있습니다.",
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.1,
                    color: Color(0xFF898D93),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "소셜 계정으로 이용 중인 경우에는 해당 소셜 서비스에서 비밀번호 찾기가 가능합니다.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: Color(0xFF898D93),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              InputEditTextUnderline(
                editingController: _emailEditController,
                focusNode: _emailEditFocus,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                title: "아이디",
                hintText: "이메일 계정을 입력해 주세요.",
                onChanged: (value) {
                  if (mounted) {
                    setState(() {});
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "이메일을 입력하세요.";
                  }

                  if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                    return "이메일 형식이 맞지 않습니다.";
                  }

                  return null;
                },
                onSubmitted: (value) {
                  _phoneEditFocus.requestFocus();
                },
                isRequired: false,
                inputType: TextInputType.emailAddress,
              ),
              InputEditTextUnderline(
                editingController: _phoneEditController,
                focusNode: _phoneEditFocus,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                title: "휴대폰 번호",
                hintText: "숫자만 입력해 주세요.",
                isReadOnly: _setReadOnly,
                onChanged: (value) {
                  if (mounted) {
                    setState(() {});
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "휴대폰 번호를 입력하세요.";
                  }

                  return null;
                },
                onSubmitted: (value) {},
                isRequired: false,
                inputType: TextInputType.number,
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BorderRoundedButton(
                  text: "휴대전화 인증",
                  active: (_emailEditController.text.isNotEmpty && _phoneEditController.text.length > 10),
                  buttonColor: kMainColor,
                  onPressed: () async {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    currentFocus.unfocus();

                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    dynamic certResult;
                    bool certificationSuccess = false;

                    if (UniversalPlatform.isWeb) {
                      certResult = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CertificationDialog(
                            phoneNumber: _phoneEditController.text,
                          );
                        },
                        barrierDismissible: false,
                      );

                      debugPrint("certResult $certResult");
                      final certResultJson = json.decode(certResult);

                      if (certResultJson != null) {
                        certificationSuccess = certResultJson["success"];
                        debugPrint("certResult certificationSuccess $certificationSuccess");
                      }
                    } else {
                      certResult = await Get.toNamed(
                        PhoneCertification.routeName,
                        arguments: CertificationData(
                          merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}',
                          carrier: "",
                          company: "유플랫폼",
                          name: "",
                          phone: _phoneEditController.text,
                        ),
                      );

                      String isSuccess = "false";
                      if (certResult != null) {
                        isSuccess = certResult['success'];
                      }
                      certificationSuccess = (isSuccess == "true");
                    }

                    debugPrint("휴대폰인증 isSuccess $certificationSuccess");
                    _isVerifiedPhone = certificationSuccess;

                    if (!_isVerifiedPhone) {
                      Get.snackbar('인증실패', '휴대폰 번호 인증에 실패하였습니다.',
                          snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                      return;
                    }

                    _setReadOnly = true;

                    if (mounted) {
                      setState(() {});
                    }

                    Map<String, dynamic> params = {};
                    params['phone'] = _phoneEditController.text;
                    FindIdResponse? findIdResponse = await Network().reqGetEmail(params);

                    if (findIdResponse == null) {
                      Get.snackbar('휴대폰번호 오류', '등록된 휴대폰 번호가 아닙니다.',
                          snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                      return;
                    }

                    if (findIdResponse.status != "200") {
                      Get.snackbar('휴대폰번호 오류', '등록된 휴대폰 번호가 아닙니다.',
                          snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                      return;
                    }

                    if (findIdResponse.email != _emailEditController.text) {
                      Get.snackbar('이메일 오류', '등록된 휴대폰 번호와 일치하는 이메일이 아닙니다.',
                          snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                      return;
                    }

                    if (findIdResponse.snsKey != null && findIdResponse.snsKey!.isNotEmpty) {
                      String snsKey = (findIdResponse.snsKey!.contains("naver")) ? "네이버" : "카카오";

                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NoticeDialog(
                            title: "소셜계정",
                            subTitle: "",
                            contents: "해당 계정은 $snsKey 소셜 계정입니다.\n$snsKey에서 비밀번호 찾기가 가능합니다.",
                          );
                        },
                        barrierDismissible: false,
                      );

                      Get.back();
                    }

                    Get.offNamed(NewPasswordPage.routeName, arguments: _phoneEditController.text);
                  },
                ),
              ),
              const SizedBox(height: 32),
              buildBottomBar
            ],
          ),
        ),
      ),
    );
  }
}
