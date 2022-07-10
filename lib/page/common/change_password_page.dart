import 'package:flutter/material.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/input_edit_text_underline.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:get/get.dart';
import 'package:uplatform/models/user_model.dart';
import 'package:uplatform/services/network.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  static const routeName = '/ChangePasswordPage';

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'ChangePasswordPage');

  final TextEditingController _passwordEditController = TextEditingController();
  final FocusNode _passwordEditFocus = FocusNode();

  final TextEditingController _newPasswordEditController = TextEditingController();
  final FocusNode _newPasswordEditFocus = FocusNode();

  final TextEditingController _rePasswordEditController = TextEditingController();
  final FocusNode _rePasswordEditFocus = FocusNode();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    _passwordEditController.dispose();
    _passwordEditFocus.dispose();

    _newPasswordEditController.dispose();
    _newPasswordEditFocus.dispose();

    _rePasswordEditController.dispose();
    _rePasswordEditFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(iconData: Icons.close),
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  height: 32,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "비밀번호 변경",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                InputEditTextUnderline(
                  editingController: _passwordEditController,
                  focusNode: _passwordEditFocus,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  title: "현재 비밀번호",
                  hintText: "현재 비밀번호를 입력하세요.",
                  isRequired: true,
                  isObscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "현재 비밀번호를 입력하세요.";
                    }

                    if (!RegExp(r"^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,}$")
                        .hasMatch(value)) {
                      return "8자 이상 영문, 숫자, 특수기호 혼합";
                    }

                    return null;
                  },
                  onSubmitted: (value) {
                    _newPasswordEditFocus.requestFocus();
                  },
                ),
                InputEditTextUnderline(
                  editingController: _newPasswordEditController,
                  focusNode: _newPasswordEditFocus,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  title: "변경 비밀번호",
                  hintText: "8자 이상 영문, 숫자, 특수기호 혼합",
                  isRequired: true,
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
                  isRequired: true,
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
                        if (_passwordEditController.text.isEmpty) {
                          _passwordEditFocus.requestFocus();
                          return;
                        }

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
                      params['old_password'] = _passwordEditController.text;
                      params['new_password'] = _rePasswordEditController.text;

                      PasswordResponse result = await Network().reqChangePassword(params);

                      if (result.status == "200") {
                        Get.back(result: _rePasswordEditController.text);
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
      ),
    );
  }
}
