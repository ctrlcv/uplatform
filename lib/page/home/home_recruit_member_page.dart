import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/page/signup/signup_account_type_page.dart';
import 'package:uplatform/page/signup/signup_expert_by_uplatform_page.dart';

class HomeRecruitMemberPage extends StatefulWidget {
  const HomeRecruitMemberPage({Key? key}) : super(key: key);

  static const routeName = '/HomeRecruitMemberPage';

  @override
  _HomeRecruitMemberPageState createState() => _HomeRecruitMemberPageState();
}

class _HomeRecruitMemberPageState extends State<HomeRecruitMemberPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = (UniversalPlatform.isWeb) ? 800 : MediaQuery.of(context).size.width;
    double bannerHeight = ((screenWidth - 40) * 240) / 640;

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "샤이니오의",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "파트너를 모집합니다.",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                width: screenWidth,
                height: bannerHeight,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/recruit_banner_01.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.only(left: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/icons_home_restaurant.png",
                      width: 24,
                      height: 24,
                      fit: BoxFit.fitHeight,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      height: 30,
                      padding: EdgeInsets.only(bottom: UniversalPlatform.isIOS ? 0 : 2.5),
                      alignment: Alignment.center,
                      child: const Text(
                        "음식점 위생정리 전문가",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: screenWidth,
                height: bannerHeight,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/recruit_banner_02.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.only(left: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/icons_home_space.png",
                      width: 24,
                      height: 24,
                      fit: BoxFit.fitHeight,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      height: 30,
                      padding: EdgeInsets.only(bottom: UniversalPlatform.isIOS ? 0 : 2.5),
                      alignment: Alignment.center,
                      child: const Text(
                        "공간 정리 전문가",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: screenWidth,
                height: bannerHeight,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/recruit_banner_03.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.only(left: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/icons_home_education.png",
                      width: 24,
                      height: 24,
                      fit: BoxFit.fitHeight,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      height: 30,
                      padding: EdgeInsets.only(bottom: UniversalPlatform.isIOS ? 0 : 2.5),
                      alignment: Alignment.center,
                      child: const Text(
                        "정리교육 강사",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              const TextTitle(
                titleText: "파트너 혜택",
                cellHeight: 22,
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFECF6FF),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "1",
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.5,
                            color: Color(0xFF10A2DC),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          "파트너로 가입 즉시 고객 1:1 매칭 서비스",
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.5,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "2",
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.5,
                            color: Color(0xFF10A2DC),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "매출 관리 및 자동 정산 등의 효율적 업무 시스템 제공",
                            style: TextStyle(
                              height: 1.5,
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "3",
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.5,
                            color: Color(0xFF10A2DC),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          "수익 증대 기대",
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.5,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              const TextTitle(
                titleText: "파트너(전문가) 가입 프로세스",
                cellHeight: 22,
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 24),
              Container(
                height: 52,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(52),
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/icons_recruit_join.png",
                        width: 36,
                        height: 36,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          alignment: Alignment.bottomLeft,
                          child: const Text(
                            "01",
                            style: TextStyle(
                              fontSize: 15,
                              color: kMainColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          height: 26,
                          alignment: Alignment.topLeft,
                          child: const Text(
                            "회원가입 신청",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF4A4E55),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Container(
                height: 52,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(52),
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/icons_recruit_judge.png",
                        width: 36,
                        height: 36,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          alignment: Alignment.bottomLeft,
                          child: const Text(
                            "02",
                            style: TextStyle(
                              fontSize: 15,
                              color: kMainColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          height: 26,
                          alignment: Alignment.topLeft,
                          child: const Text(
                            "심사 대기",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF4A4E55),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Container(
                height: 52,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(52),
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/icons_recruit_complete.png",
                        width: 36,
                        height: 36,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          alignment: Alignment.bottomLeft,
                          child: const Text(
                            "03",
                            style: TextStyle(
                              fontSize: 15,
                              color: kMainColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          height: 26,
                          alignment: Alignment.topLeft,
                          child: const Text(
                            "가입 완료",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF4A4E55),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Container(
                height: 52,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(52),
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/icons_recruit_use_service.png",
                        width: 36,
                        height: 36,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          alignment: Alignment.bottomLeft,
                          child: const Text(
                            "04",
                            style: TextStyle(
                              fontSize: 15,
                              color: kMainColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          height: 26,
                          alignment: Alignment.topLeft,
                          child: const Text(
                            "서비스 이용",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF4A4E55),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                height: 16,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      width: 2,
                      height: 2,
                      decoration: BoxDecoration(
                        color: const Color(0xFF898D93),
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "회원가입 신청 후 심사대기까지 ",
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.0,
                        color: Color(0xFF898D93),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Text(
                      "약 2일 정도 ",
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.0,
                        color: Color(0xFF10A2DC),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Text(
                      "소요됩니다",
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.0,
                        color: Color(0xFF898D93),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BorderRoundedButton(
                  text: "파트너(전문가) 회원 가입",
                  buttonColor: kMainColor,
                  onPressed: () {
                    if (UniversalPlatform.isAndroid) {
                      Get.toNamed(SignUpAccountTypePage.routeName, arguments: "isExpertMember");
                    } else {
                      Get.toNamed(SignUpExpertByUPlatformPage.routeName);
                    }
                  },
                ),
              ),
              const SizedBox(height: 32),
              buildBottomBar,
            ],
          ),
        ),
      ),
    );
  }
}
