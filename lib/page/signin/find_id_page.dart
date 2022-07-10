import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/input_edit_text_underline.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/dialogs/certification_dialog.dart';
import 'package:uplatform/models/common_model.dart';
import 'package:uplatform/services/network.dart';
import 'package:iamport_flutter/model/certification_data.dart';

import '../common/phone_certification.dart';
import 'find_id_fail_page.dart';
import 'find_id_finish_page.dart';

class FindIdPage extends StatefulWidget {
  const FindIdPage({Key? key}) : super(key: key);

  static const routeName = '/FindIdPage';

  @override
  _FindIdPageState createState() => _FindIdPageState();
}

class _FindIdPageState extends State<FindIdPage> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'FindId');

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
                titleText: "아이디를 잊으셨나요?",
                cellHeight: 32,
                fontSize: 24,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 6),
              Container(
                height: 21,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "휴대폰 인증으로 아이디를 찾을 수 있습니다.",
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.1,
                    color: Color(0xFF898D93),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              InputEditTextUnderline(
                editingController: _phoneEditController,
                focusNode: _phoneEditFocus,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                title: "휴대폰 번호",
                hintText: "숫자만 입력",
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
                  active: (_phoneEditController.text.length > 10),
                  buttonColor: kMainColor,
                  onPressed: () async {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    currentFocus.unfocus();

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
                      Get.offNamed(FindIdFailPage.routeName, arguments: "VerifiedFail");
                      return;
                    }

                    _setReadOnly = true;

                    Map<String, dynamic> params = {};
                    params['phone'] = _phoneEditController.text;
                    FindIdResponse? findIdResponse = await Network().reqGetEmail(params);

                    if (findIdResponse != null && findIdResponse.status == "200") {
                      String? email = findIdResponse.email;
                      String? snsKey = findIdResponse.snsKey;

                      if (snsKey != null && snsKey.isNotEmpty) {
                        if (snsKey.contains("naver")) {
                          snsKey = "NAVER";
                        } else if (snsKey.contains("kakao")) {
                          snsKey = "KAKAO";
                        }
                      }

                      Map<String, dynamic> argumentsParams = {};
                      argumentsParams['email'] = email;
                      argumentsParams['snskey'] = snsKey;

                      Get.offNamed(FindIdFinishPage.routeName, arguments: argumentsParams);
                    } else {
                      Get.offNamed(FindIdFailPage.routeName);
                    }
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
