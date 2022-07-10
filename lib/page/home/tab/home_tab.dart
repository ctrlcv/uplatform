import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/user_model.dart';
import 'package:uplatform/page/booking/booking_education_page.dart';
import 'package:uplatform/page/booking/booking_restaurant_page.dart';
import 'package:uplatform/page/booking/booking_space_page.dart';
import 'package:uplatform/page/home/home_clean_space_detail_page.dart';
import 'package:uplatform/page/home/home_education_detail_page.dart';
import 'package:uplatform/page/home/home_recruit_member_page.dart';
import 'package:uplatform/page/home/home_restaurant_detail_page.dart';
import 'package:uplatform/page/signin/login_email_page.dart';
import 'package:uplatform/services/login_service.dart';

import '../../../components/text_paragraph.dart';
import '../../signin/terms_page.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key, required this.onPressedHelpCenterTab}) : super(key: key);

  final GestureTapCallback onPressedHelpCenterTab;

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  LoginUser? _loginUser;

  @override
  void initState() {
    super.initState();

    _loginUser = LoginService().getLoginUser();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = (UniversalPlatform.isWeb) ? 800 : MediaQuery.of(context).size.width;
    double imageHeight = (screenWidth * 960) / 720;

    return SafeArea(
      top: false,
      bottom: false,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                toolbarHeight: 0,
                title: Container(height: 1),
                pinned: true,
                expandedHeight: imageHeight - 48 - 48,
                backgroundColor: Colors.white,
                elevation: 0.0,
                forceElevated: innerBoxIsScrolled,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Image.asset(
                        "assets/images/home_page_background.png",
                        width: screenWidth,
                        fit: BoxFit.fitWidth,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 26),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            SizedBox(height: 126),
                            TextTitle(
                              titleText: "오! 놀랄 거예요.",
                              cellHeight: 36,
                              fontSize: 28,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.w700,
                              padding: EdgeInsets.symmetric(horizontal: 0),
                            ),
                            TextTitle(
                              titleText: "일상을 빛낼 공간 정리",
                              cellHeight: 36,
                              fontSize: 28,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.w700,
                              padding: EdgeInsets.symmetric(horizontal: 0),
                            ),
                            SizedBox(height: 8),
                            TextTitle(
                              titleText: "먹고 자고 일하며 머무르는 ‘공간’의 변화는",
                              cellHeight: 20,
                              fontSize: 14,
                              fontColor: Color(0xFF686C73),
                              fontWeight: FontWeight.w400,
                              padding: EdgeInsets.symmetric(horizontal: 0),
                            ),
                            TextTitle(
                              titleText: "인생의 변화를 이끌어 냅니다.",
                              cellHeight: 20,
                              fontSize: 14,
                              fontColor: Color(0xFF686C73),
                              fontWeight: FontWeight.w400,
                              padding: EdgeInsets.symmetric(horizontal: 0),
                            ),
                            TextTitle(
                              titleText: "믿을 수 있는 샤이니오! 전문가와 함께 해요.",
                              cellHeight: 20,
                              fontSize: 14,
                              fontColor: Color(0xFF686C73),
                              fontWeight: FontWeight.w400,
                              padding: EdgeInsets.symmetric(horizontal: 0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: Builder(
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: buildHomeTabItems(context),
            );
          },
        ),
      ),
    );
  }

  Widget buildHomeTabItems(BuildContext context) {
    double screenWidth = (UniversalPlatform.isWeb) ? 800 : MediaQuery.of(context).size.width;

    return Container(
      color: const Color(0xFFF9F9F9),
      child: Column(
        children: [
          const SizedBox(height: 120),
          const TextTitle(
            titleText: "샤이니오! 정리 서비스 신청",
            cellHeight: 36,
            fontSize: 20,
            fontColor: Colors.black,
            fontWeight: FontWeight.w700,
            padding: EdgeInsets.symmetric(horizontal: 26),
          ),
          const SizedBox(height: 16),
          Container(
            height: 126,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (_loginUser == null) {
                      Get.toNamed(LoginEmailPage.routeName, arguments: "BookingRestaurantPage");
                      return;
                    }

                    Get.toNamed(BookingRestaurantPage.routeName);
                  },
                  child: Container(
                    width: 102,
                    decoration: BoxDecoration(
                      color: kMainColor,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFFC113).withOpacity(0.30),
                          offset: const Offset(
                            0.0,
                            4.0,
                          ),
                          blurRadius: 8.0,
                          spreadRadius: 0.0,
                        ),
                        const BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/icons_home_restaurant.png",
                          width: 26,
                          height: 26,
                        ),
                        const SizedBox(height: 28),
                        Container(
                          height: 20,
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "음식점",
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.2,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          height: 20,
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "위생정리",
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.2,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    if (_loginUser == null) {
                      Get.toNamed(LoginEmailPage.routeName, arguments: "BookingSpacePage");
                      return;
                    }

                    Get.toNamed(BookingSpacePage.routeName);
                  },
                  child: Container(
                    width: 102,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF16A34),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFF16A34).withOpacity(0.30),
                          offset: const Offset(
                            0.0,
                            4.0,
                          ),
                          blurRadius: 8.0,
                          spreadRadius: 0.0,
                        ),
                        const BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/icons_home_space.png",
                          width: 26,
                          height: 26,
                        ),
                        const SizedBox(height: 48),
                        Container(
                          height: 20,
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "공간정리",
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.2,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    if (_loginUser == null) {
                      Get.toNamed(LoginEmailPage.routeName, arguments: "BookingEducationPage");
                      return;
                    }

                    Get.toNamed(BookingEducationPage.routeName);
                  },
                  child: Container(
                    width: 102,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10A2DC),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF10A2DC).withOpacity(0.30),
                          offset: const Offset(
                            0.0,
                            4.0,
                          ),
                          blurRadius: 8.0,
                          spreadRadius: 0.0,
                        ),
                        const BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/icons_home_education.png",
                          width: 26,
                          height: 26,
                        ),
                        const SizedBox(height: 28),
                        Container(
                          height: 20,
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "정리",
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.2,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          height: 20,
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "전문교육",
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.2,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 38),
          Container(
            height: 28,
            padding: const EdgeInsets.symmetric(horizontal: 26),
            alignment: Alignment.centerLeft,
            child: const Text(
              "샤이니오! 서비스 소개",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset(
              "assets/images/home_page_bg_restaurant.png",
              width: screenWidth - 40,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  height: 26,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "음식점 위생정리 서비스",
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  height: 20,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "식약처 인증 음식점 위생등급",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.0,
                      color: Color(0xFF898D93),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  height: 20,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "샤이니오 전문가가 코치해 드립니다.",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.0,
                      color: Color(0xFF898D93),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(HomeRestaurantDetailPage.routeName);
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6F8),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "자세히 보기",
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.0,
                              color: Color(0xFF686C73),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (_loginUser == null) {
                            Get.toNamed(LoginEmailPage.routeName, arguments: "BookingRestaurantPage");
                            return;
                          }

                          Get.toNamed(BookingRestaurantPage.routeName);
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6F8),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "예약하기",
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.0,
                              color: Color(0xFF686C73),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset(
              "assets/images/home_page_bg_space.png",
              width: screenWidth - 40,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  height: 26,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "공간정리 서비스",
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  height: 20,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "빛나는 일상, 윤택한 공간",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.0,
                      color: Color(0xFF898D93),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  height: 20,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "공간정리전문가의 오! 놀라운 정리",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.0,
                      color: Color(0xFF898D93),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(HomeCleanSpaceDetailPage.routeName);
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6F8),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "자세히 보기",
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.0,
                              color: Color(0xFF686C73),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (_loginUser == null) {
                            Get.toNamed(LoginEmailPage.routeName, arguments: "BookingSpacePage");
                            return;
                          }

                          Get.toNamed(BookingSpacePage.routeName);
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6F8),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "예약하기",
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.0,
                              color: Color(0xFF686C73),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset(
              "assets/images/home_page_bg_education.png",
              width: screenWidth - 40,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  height: 26,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "정리 전문 교육",
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  height: 20,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "요즘 핫한! 정리수납 전문가",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.0,
                      color: Color(0xFF898D93),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  height: 20,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "자격증 취득을 위한 교육, 샤이니오와 함께해요.",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.0,
                      color: Color(0xFF898D93),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(HomeEducationDetailPage.routeName);
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6F8),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "자세히 보기",
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.0,
                              color: Color(0xFF686C73),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (_loginUser == null) {
                            Get.toNamed(LoginEmailPage.routeName, arguments: "BookingEducationPage");
                            return;
                          }

                          Get.toNamed(BookingEducationPage.routeName);
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6F8),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "예약하기",
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.0,
                              color: Color(0xFF686C73),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () {
              Get.toNamed(HomeRecruitMemberPage.routeName);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset(
                "assets/images/home_page_bg_banner.png",
                width: screenWidth - 40,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  Get.toNamed(TermsPage.routeName, arguments: "서비스 이용약관");
                },
                child: const Text(
                  "이용약관",
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.0,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "|",
                style: TextStyle(
                  fontSize: 15,
                  height: 1.0,
                  color: Color(0xFFE4E7ED),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  Get.toNamed(TermsPage.routeName, arguments: "개인정보 처리방침");
                },
                child: const Text(
                  "개인정보 처리방침",
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.0,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "|",
                style: TextStyle(
                  fontSize: 15,
                  height: 1.0,
                  color: Color(0xFFE4E7ED),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: widget.onPressedHelpCenterTab,
                child: const Text(
                  "고객센터",
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.0,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const TextParagraph(
            paraText: "상호명 : (주)유플랫폼",
            fontSize: 13,
            fontColor: Color(0xFF686C73),
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 6),
          const TextParagraph(
            paraText: "사업자등록번호 : 526-87-02331",
            fontSize: 13,
            fontColor: Color(0xFF686C73),
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 6),
          const TextParagraph(
            paraText: "대표자명 : 유정민",
            fontSize: 13,
            fontColor: Color(0xFF686C73),
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 6),
          const TextParagraph(
            paraText: "사업장주소지 : 서울 특별시 구로구 디지털로 31길38-9, 409-16호 (구로동  에이스 테크노타워  1차)",
            fontSize: 13,
            fontColor: Color(0xFF686C73),
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 6),
          const TextParagraph(
            paraText: "고객센터 : 전화번호 02-865-8506",
            fontSize: 13,
            fontColor: Color(0xFF686C73),
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 6),
          const TextParagraph(
            paraText: "이메일 : u-platform@naver.com",
            fontSize: 13,
            fontColor: Color(0xFF686C73),
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 6),
          const TextParagraph(
            paraText: "통신판매업 신고번호 : 2022-서울구로-0472",
            fontSize: 13,
            fontColor: Color(0xFF686C73),
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 32),
          const TextParagraph(
            paraText: "Copyright © Uplatform Corp. 2022 All Rights Reserved",
            fontSize: 13,
            fontColor: Color(0xFF686C73),
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
