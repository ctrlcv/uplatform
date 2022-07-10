import 'package:flutter/material.dart';
import 'package:uplatform/components/menu_item.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/dialogs/ask_dialog.dart';
import 'package:uplatform/models/common_model.dart';
import 'package:uplatform/models/user_model.dart';
import 'package:uplatform/page/home/home_page.dart';
import 'package:uplatform/services/login_service.dart';
import 'package:uplatform/services/network.dart';
import 'package:get/get.dart';

import '../../menu/exit_uplatform_page.dart';
import '../expert_edit_profile_page.dart';
import '../income_list_page.dart';
import '../transfer_to_normal_page.dart';

class ExpertProfileTab extends StatefulWidget {
  const ExpertProfileTab({
    Key? key,
    required this.onPressedRequestTab,
  }) : super(key: key);

  final GestureTapCallback onPressedRequestTab;

  @override
  _ExpertProfileTabState createState() => _ExpertProfileTabState();
}

class _ExpertProfileTabState extends State<ExpertProfileTab> {
  UserInfo? _userInfo;

  @override
  void initState() {
    super.initState();

    _userInfo = LoginService().getUserInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadUserInfo() async {
    LoginUser? loginUser = LoginService().getLoginUser();

    if (loginUser != null) {
      UserInfo? userInfo = await Network().reqUserInfo();

      if (userInfo != null) {
        LoginService().setUserInfo(userInfo);
      }

      PartnerInfo? userPartnerInfo = await Network().reqPartnerInfo();

      if (userPartnerInfo != null) {
        LoginService().setUserPartnerInfo(userPartnerInfo);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 16),
              const TextTitle(
                titleText: "프로필",
                cellHeight: 34,
                fontSize: 26,
                fontColor: Colors.black,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 40),
              if (_userInfo != null)
                GestureDetector(
                  onTap: () async {
                    await Get.toNamed(ExpertEditProfilePage.routeName);
                    loadUserInfo();
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 22,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${_userInfo!.name}님",
                              style: const TextStyle(
                                fontSize: 18,
                                height: 1.1,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              if (isKakaoUser() || isNaverUser())
                                Image.asset(
                                  isKakaoUser()
                                      ? "assets/images/icons_login_kakao.png"
                                      : "assets/images/icons_login_naver.png",
                                  width: 17,
                                  height: 17,
                                )
                              else
                                const Icon(
                                  Icons.email_outlined,
                                  size: 20,
                                  color: Color(0xFF323232),
                                ),
                              const SizedBox(width: 6),
                              Text(
                                "${_userInfo!.email}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF898D93),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Expanded(child: Container(color: Colors.transparent, height: 30)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: (_userInfo!.userType == "0") ? const Color(0xFFF5F6F8) : const Color(0xFFF4FAFF),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          (_userInfo!.userType == "0") ? "일반회원" : "전문가회원",
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.1,
                            color:
                                (_userInfo!.userType == "0") ? const Color(0xFF686C73) : const Color(0xFF10A2DC),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF898D93),
                        size: 15,
                      ),
                      const SizedBox(width: 24),
                    ],
                  ),
                ),
              const SizedBox(height: 28),
              kHorizontalLine,
              const SizedBox(height: 15),
              MenuItem(
                iconData: Icons.list_alt,
                title: "서비스 요청내역",
                onPressed: widget.onPressedRequestTab,
              ),
              MenuItem(
                imagePath: "assets/images/icons_won.png",
                iconData: Icons.list_alt,
                title: "정산내역",
                onPressed: () {
                  Get.toNamed(IncomeListPage.routeName);
                },
              ),
              MenuItem(
                iconData: Icons.sync,
                title: "일반회원으로 전환",
                onPressed: () async {
                  String resultStr = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AskDialog(title: "일반회원으로 전환", contents: "일반회원으로 전환하시겠습니까?");
                    },
                    barrierDismissible: false,
                  );

                  if (resultStr != "YES") {
                    return;
                  }

                  AreaInfo? userAreaInfo = await Network().reqAreaInfo();

                  debugPrint("userAreaInfo $userAreaInfo");

                  if (userAreaInfo == null) {
                    await Get.toNamed(TransferToNormalPage.routeName);

                    userAreaInfo = await Network().reqAreaInfo();
                    if (userAreaInfo != null) {
                      LoginService().setUserAreaInfo(userAreaInfo);
                    } else {
                      debugPrint("USER CANCEL transfer return");
                      return;
                    }
                  }

                  Map<String, dynamic> params = {};
                  params['user_type'] = "0";

                  CommonResponse commonResponse = await Network().reqUpdateUserType(params);

                  if (commonResponse.status == "200") {
                    Get.offAllNamed(HomePage.routeName);
                    Get.snackbar('일반회원전환', "일반회원으로 전환되었습니다.",
                        snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 2000));
                  }
                },
              ),
              const SizedBox(height: 15),
              kHorizontalLine,
              const SizedBox(height: 15),
              if (_userInfo != null)
                MenuItem(
                  imagePath: "assets/images/icons_applause.png",
                  iconData: Icons.sync,
                  title: "회원탈퇴",
                  onPressed: () {
                    Get.toNamed(ExitUPlatformPage.routeName, arguments: "expert");
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  bool isKakaoUser() {
    if (_userInfo == null) {
      return false;
    }

    String? snsKey = _userInfo!.snsKey;

    if (snsKey == null || snsKey.isEmpty) {
      return false;
    }

    if (snsKey.contains("kakao_")) {
      return true;
    }

    return false;
  }

  bool isNaverUser() {
    if (_userInfo == null) {
      return false;
    }

    String? snsKey = _userInfo!.snsKey;

    if (snsKey == null || snsKey.isEmpty) {
      return false;
    }

    if (snsKey.contains("naver_")) {
      return true;
    }

    return false;
  }
}
