import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/check_box.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/dot_text_view.dart';
import 'package:uplatform/components/input_bottom_sheet.dart';
import 'package:uplatform/components/input_edit_text_underline.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/common_model.dart';
import 'package:uplatform/services/login_service.dart';
import 'package:uplatform/services/network.dart';

import '../../components/text_title.dart';

class ExitUPlatformPage extends StatefulWidget {
  const ExitUPlatformPage({Key? key}) : super(key: key);

  static const routeName = '/ExitUPlatformPage';

  @override
  _ExitUPlatformPageState createState() => _ExitUPlatformPageState();
}

class _ExitUPlatformPageState extends State<ExitUPlatformPage> {
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _detailEditController = TextEditingController();
  final FocusNode _detailEditFocus = FocusNode();

  bool _isAgreeTerms = false;
  String _exitReason = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();

    _detailEditController.dispose();
    _detailEditFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = (UniversalPlatform.isWeb) ? 800 : MediaQuery.of(context).size.width;

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(iconData: Icons.arrow_back),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              const SizedBox(height: 12),
              const TextTitle(
                titleText: "샤이니오!를",
                cellHeight: 32,
                fontSize: 24,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              const TextTitle(
                titleText: "떠나시나요?",
                cellHeight: 32,
                fontSize: 24,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 6),
              const TextTitle(
                titleText: "잠깐! 회원탈퇴 전 안내사항을 꼭 확인해주세요.",
                cellHeight: 19,
                fontSize: 15,
                fontColor: Color(0xFF898D93),
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(height: 32),
              Container(
                color: const Color(0xFFFAFAFA),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    const DotTextView(textStr: "탈퇴한 회원의 아이디는 재사용이 불가합니다."),
                    const SizedBox(height: 10),
                    const DotTextView(textStr: "회원 탈퇴 시 개인정보 및 서비스 이용기록은 모두 삭제되며, 삭제된 계정은 복구할 수 없습니다. (단, 관련 법령에 의거하여 일정기간 동안 개인 정보를 보유할 필요가 있을 경우 법이 정한 기간동안 개인정보를 처리, 보유합니다.)"),
                    const SizedBox(height: 10),
                    (Get.arguments != null && Get.arguments == "expert") ?
                    const DotTextView(
                        textStr:
                        "샤이니오!를 통해 성사된 컨설팅 및 교육 서비스로 경력 증빙이 필요하신 경우 회원 탈퇴 전 활동 사항을 백업하시기 바랍니다. 서비스 탈퇴 후 고객센터 문의 등을 통한 활동 경력 복구 및 백업은 불가능하다는 점을 안내 드립니다.")
                    : const DotTextView(
                        textStr:
                            "공용게시판에 등록된 댓글, 후기 등 게시물은 탈퇴후에도 삭제되지 않고 유지되므로 사전 삭제 후 탈퇴하시기 바랍니다. SNS 가입의 경우 해당 SNS사이트에서 유플랫폼과 연결된 계정을 직접 해제해야 삭제가 완료됩니다."),
                    const SizedBox(height: 10),
                    const DotTextView(
                        textStr:
                            "공간정리 컨설팅 서비스 진행 중 탈퇴로 인한 경제적 손해 및 법률적 문제에 대한 책임은 모두 회원에게 있으며, 샤이니오!는 해당 사항에 대하여 책임이 없음을 안내 드립니다."),
                    if (Get.arguments != null && Get.arguments == "expert") const SizedBox(height: 10),

                    if (Get.arguments != null && Get.arguments == "expert")
                      const DotTextView(
                          textStr:
                          "공용게시판에 등록된 댓글, 후기 등 게시물은 탈퇴후에도 삭제되지 않고 유지되므로 사전 삭제 후 탈퇴하시기 바랍니다. SNS 가입의 경우 해당 SNS사이트에서 유플랫폼과 연결된 계정을 직접 해제해야 삭제가 완료됩니다."),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              const SizedBox(height: 17),
              GestureDetector(
                onTap: () {
                  _isAgreeTerms = !_isAgreeTerms;
                  if (mounted) {
                    setState(() {});
                  }
                },
                child: Container(
                  height: 20,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CheckBox(isSelected: _isAgreeTerms),
                      const SizedBox(width: 8),
                      Container(
                        height: 20,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 1),
                        child: const Text(
                          "안내 사항을 모두 확인하였습니다.",
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.1,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                height: 12,
                width: screenWidth,
                color: const Color(0xFFF1F2F4),
              ),
              const SizedBox(height: 32),
              const TextTitle(
                titleText: "탈퇴 사유를 알려주세요.",
                cellHeight: 26,
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              const TextTitle(
                titleText: "회원님의 의견을 소중하게 반영하겠습니다.",
                cellHeight: 26,
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 32),
              InputBottomSheet(
                title: "탈퇴 사유",
                padding: const EdgeInsets.symmetric(horizontal: 20),
                items: const ["샤이니오 더 이상 이용 안함", "서비스 기능 불편", "다른 서비스 이용", "샤이오니 정책에 불만", "개인정보 및 보안우려", "기타"],
                selectedItem: _exitReason,
                onChanged: (value) {
                  _exitReason = value;
                  if (mounted) {
                    setState(() {});
                  }
                },
              ),
              const SizedBox(height: 32),
              InputEditTextUnderline(
                editingController: _detailEditController,
                focusNode: _detailEditFocus,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                title: "내용",
                hintText: "내용입력",
                isRequired: false,
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BorderRoundedButton(
                  text: "회원탈퇴",
                  active: isExitButtonEnable(),
                  buttonColor: kMainColor,
                  onPressed: () async {
                    CommonResponse response = await Network().reqLeaveUser();

                    if (response.status == "200") {
                      LoginService().logOut();

                      Get.snackbar('회원탈퇴', "회원탈퇴가 처리되었습니다.",
                          snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 2000));
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

  bool isExitButtonEnable() {
    if (!_isAgreeTerms) {
      return false;
    }

    if (_exitReason.isEmpty) {
      return false;
    }

    // if (_exitReason == "기타" && _detailEditController.text.isEmpty) {
    //   return false;
    // }

    return true;
  }
}
