import 'package:flutter/material.dart';
import 'package:uplatform/components/text_paragraph.dart';

import '../../components/border_rounded_button.dart';
import '../../components/custom_appbar.dart';
import '../../components/input_edit_text_underline.dart';
import '../../components/text_title.dart';
import '../../constants/constants.dart';
import '../../models/user_model.dart';
import '../../services/network.dart';
import 'package:get/get.dart';

import 'find_password_finish_page.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({Key? key}) : super(key: key);

  static const routeName = '/NewPasswordPage';

  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'NewPasswordPage');

  final TextEditingController _newPasswordEditController = TextEditingController();
  final FocusNode _newPasswordEditFocus = FocusNode();

  final TextEditingController _rePasswordEditController = TextEditingController();
  final FocusNode _rePasswordEditFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _newPasswordEditController.dispose();
    _newPasswordEditFocus.dispose();

    _rePasswordEditController.dispose();
    _rePasswordEditFocus.dispose();

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
                titleText: "본인확인이 완료되었습니다.",
                cellHeight: 32,
                fontSize: 24,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 6),
              const TextParagraph(
                paraText: "새 비밀번호를 설정해 주세요.",
                fontSize: 15,
                fontColor: Color(0xFF898D93),
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(height: 6),
              const TextParagraph(
                paraText: "영문,숫자,특수기호 입력해 주시면\n안전한 비밀번호를 만드실 수 있습니다.",
                fontSize: 15,
                fontColor: Color(0xFF898D93),
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(height: 40),
              InputEditTextUnderline(
                editingController: _newPasswordEditController,
                focusNode: _newPasswordEditFocus,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                title: "새 비밀번호",
                hintText: "8자 이상 영문, 숫자, 특수기호 혼합",
                isRequired: false,
                isObscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "비밀번호를 입력하세요.";
                  }

                  if (!RegExp(r"^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,}$")
                      .hasMatch(value)) {
                    return "8자 이상 영문, 숫자, 특수기호 혼합";
                  }

                  return null;
                },
                onSubmitted: (value) {
                  _rePasswordEditFocus.requestFocus();
                },
              ),
              InputEditTextUnderline(
                editingController: _rePasswordEditController,
                focusNode: _rePasswordEditFocus,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                title: "비밀번호 확인",
                hintText: "비밀번호 재입력",
                isRequired: false,
                isObscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "비밀번호를 입력하세요.";
                  }

                  if (value != _newPasswordEditController.text) {
                    return "비밀번호가 일치하지 않습니다.";
                  }

                  return null;
                },
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BorderRoundedButton(
                  text: "확인",
                  active: true,
                  buttonColor: kMainColor,
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      if (_newPasswordEditController.text.isEmpty) {
                        _newPasswordEditFocus.requestFocus();
                        return;
                      }

                      if (_rePasswordEditController.text.isEmpty) {
                        _rePasswordEditFocus.requestFocus();
                        return;
                      }

                      return;
                    }

                    Map<String, dynamic> params = {};
                    params['phone'] = Get.arguments;
                    params['new_password'] = _rePasswordEditController.text;

                    PasswordResponse result = await Network().reqChangePasswordByPhone(params);

                    if (result.status == "200") {
                      Get.offNamed(FindPasswordFinishPage.routeName);
                    } else {
                      Get.snackbar('변경 실패', result.message!,
                          snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
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
