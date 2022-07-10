import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/user_model.dart';
import 'package:uplatform/page/booking/booking_education_page.dart';
import 'package:uplatform/page/signin/login_email_page.dart';
import 'package:uplatform/services/login_service.dart';

class HomeEducationDetailPage extends StatefulWidget {
  const HomeEducationDetailPage({Key? key}) : super(key: key);

  static const routeName = '/HomeEducationDetailPage';

  @override
  _HomeEducationDetailPageState createState() => _HomeEducationDetailPageState();
}

class _HomeEducationDetailPageState extends State<HomeEducationDetailPage> {
  final ScrollController _scrollController = ScrollController();
  Color _appBarTextColor = const Color(0xFFFFFFFF);
  double _scrollOffset = 0;
  LoginUser? _loginUser;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollChangedListener);
    _scrollOffset = _scrollController.initialScrollOffset;

    _loginUser = LoginService().getLoginUser();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollChangedListener() {
    double offset = _scrollController.offset;
    offset = ((offset / 10).round()) * 10;

    if (offset < 20) {
      offset = 0;
    } else if (offset > 160) {
      offset = 180;
    }

    if (offset != _scrollOffset) {
      _scrollOffset = offset;
      _setAppBarTextColor();
    }
  }

  void _setAppBarTextColor() {
    if (_scrollOffset <= 20) {
      _appBarTextColor = Colors.white;
    } else if (_scrollOffset <= 30) {
      _appBarTextColor = Colors.white70;
    } else if (_scrollOffset <= 40) {
      _appBarTextColor = Colors.white60;
    } else if (_scrollOffset <= 50) {
      _appBarTextColor = Colors.white54;
    } else if (_scrollOffset <= 60) {
      _appBarTextColor = Colors.white38;
    } else if (_scrollOffset <= 70) {
      _appBarTextColor = Colors.white24;
    } else if (_scrollOffset <= 80) {
      _appBarTextColor = Colors.white12;
    } else if (_scrollOffset <= 90) {
      _appBarTextColor = Colors.white10;
    } else if (_scrollOffset <= 100) {
      _appBarTextColor = Colors.black12;
    } else if (_scrollOffset <= 110) {
      _appBarTextColor = Colors.black26;
    } else if (_scrollOffset <= 120) {
      _appBarTextColor = Colors.black38;
    } else if (_scrollOffset <= 130) {
      _appBarTextColor = Colors.black45;
    } else if (_scrollOffset <= 140) {
      _appBarTextColor = Colors.black54;
    } else if (_scrollOffset <= 150) {
      _appBarTextColor = Colors.black87;
    } else {
      _appBarTextColor = Colors.black;
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = (UniversalPlatform.isWeb) ? 800 : MediaQuery.of(context).size.width;
    double imageHeight = (screenWidth * 480) / 720;

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  toolbarHeight: 48,
                  pinned: true,
                  expandedHeight: imageHeight - 48,
                  leading: IconButton(
                    padding: const EdgeInsets.only(left: 16, top: 0, bottom: 0),
                    icon: Icon(
                      Icons.arrow_back,
                      color: _appBarTextColor,
                    ),
                    iconSize: 22,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset(
                      'assets/images/home_education_detail_bg.png',
                      width: screenWidth,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Builder(
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: buildMainItems(context),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildMainItems(BuildContext context) {
    double screenWidth = (UniversalPlatform.isWeb) ? 800 : MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 138),
          Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: const Text(
              "공간정리 교육으로",
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: const Text(
              "일상 정리부터",
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: const Text(
              "커리어 개발까지",
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.topLeft,
            child: const Text(
              "아무리 넓은 공간도 기능과 목적을 확실하게 정하지 못하면 동선과 효율이 떨어집니다.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 15,
                height: 1.45,
                color: Color(0xFF686C73),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.topLeft,
            child: const Text(
              "주거 공간, 상업 공간, 업무 공간 등 다양한 공간을 가장 효율적으로 활용할 수 있도록 도와주는 정리수납전문가, 지금 필요합니다.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 15,
                height: 1.45,
                color: Color(0xFF686C73),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.topLeft,
            child: const Text(
              "2주 과정부터 강사과정까지 나와 나의 일상을 변화시킬 정리수납 교육을 만나보세요.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 15,
                height: 1.45,
                color: Color(0xFF686C73),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 48),
          Container(
            height: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: const Text(
              "교육 시간",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                height: 25,
                width: 85,
                padding: const EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "평일반",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                height: 25,
                alignment: Alignment.centerLeft,
                child: const Text(
                  "오전 9시 - 오후 8시(점심 1시간)",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(
                height: 25,
                width: 85,
                padding: const EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "주말반",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                height: 25,
                alignment: Alignment.centerLeft,
                child: const Text(
                  "오전 9시 - 오후 6시(점심 1시간)",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
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
                  "교육과정에 따라 변경 될 수 있습니다.",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF898D93),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          Container(
            height: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: const Text(
              "서비스 이용 가격 ",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            height: 26,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: const Text(
              "1. 공간정리 코칭 서비스",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 20),
          buildTable01(),
          const SizedBox(height: 30),
          Container(
            height: 26,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: const Text(
              "2. 주거 공간",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 20),
          buildTable02(),
          const SizedBox(height: 28),
          buildTable03(),
          const SizedBox(height: 28),
          buildTable04(),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BorderRoundedButton(
              text: "정리교육 서비스 신청",
              buttonColor: kMainColor,
              onPressed: () {
                if (_loginUser == null) {
                  Get.toNamed(LoginEmailPage.routeName, arguments: "BookingEducationPage");
                  return;
                }

                Get.offNamed(BookingEducationPage.routeName);
              },
            ),
          ),
          const SizedBox(height: 32),
          buildBottomBar,
        ],
      ),
    );
  }

  Widget buildTable01() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            height: 20,
            alignment: Alignment.centerLeft,
            child: const Text(
              "※ 기본 수업 (총 5단계 프로세스로 진행)",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 14),
          horizontalLine(),
          Container(
            height: 42,
            color: const Color(0xFFFAFAFA),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Flexible(
                  flex: 46,
                  child: Container(
                    height: 42,
                    alignment: Alignment.center,
                    child: const Text(
                      "단계",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 42,
                  color: const Color(0xFFE4E7ED),
                ),
                Flexible(
                  flex: 132,
                  child: Container(
                    height: 42,
                    alignment: Alignment.center,
                    child: const Text(
                      "세부내용",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 42,
                  color: const Color(0xFFE4E7ED),
                ),
                Flexible(
                  flex: 140,
                  child: Container(
                    height: 42,
                    alignment: Alignment.center,
                    child: const Text(
                      "공간정리 코칭 상품가격",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          horizontalLine(lineColor: const Color(0xFFE4E7ED)),
          Container(
            color: Colors.white,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Flexible(
                  flex: 46,
                  child: Column(
                    children: [
                      Container(
                        height: 42,
                        alignment: Alignment.center,
                        child: const Text(
                          "1단계",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: const Color(0xFFE4E7ED),
                      ),
                      Container(
                        height: 42,
                        alignment: Alignment.center,
                        child: const Text(
                          "2단계",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: const Color(0xFFE4E7ED),
                      ),
                      Container(
                        height: 42,
                        alignment: Alignment.center,
                        child: const Text(
                          "3단계",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: const Color(0xFFE4E7ED),
                      ),
                      Container(
                        height: 42,
                        alignment: Alignment.center,
                        child: const Text(
                          "4단계",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: const Color(0xFFE4E7ED),
                      ),
                      Container(
                        height: 42,
                        alignment: Alignment.center,
                        child: const Text(
                          "5단계",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 215,
                  color: const Color(0xFFE4E7ED),
                ),
                Flexible(
                  flex: 132,
                  child: Column(
                    children: [
                      Container(
                        height: 42,
                        padding: const EdgeInsets.only(left: 8),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "코칭 목표 설정",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: const Color(0xFFE4E7ED),
                      ),
                      Container(
                        height: 42,
                        padding: const EdgeInsets.only(left: 8),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "물건 분류 방법 배우기",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: const Color(0xFFE4E7ED),
                      ),
                      Container(
                        height: 42,
                        padding: const EdgeInsets.only(left: 8),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "물건 소유의 기준 정하기",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: const Color(0xFFE4E7ED),
                      ),
                      Container(
                        height: 42,
                        padding: const EdgeInsets.only(left: 8),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "공간 기획하기",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: const Color(0xFFE4E7ED),
                      ),
                      Container(
                        height: 42,
                        padding: const EdgeInsets.only(left: 8),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "공간 정리하기",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 215,
                  color: const Color(0xFFE4E7ED),
                ),
                Flexible(
                  flex: 140,
                  child: Container(
                    padding: const EdgeInsets.only(left: 8),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "* 각 단계=1회기 ~ 총 5회기로 진행",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "* 1회당 2시간 소요, 5회는 총 10시간",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "* 1회기 당 서비스 단가는 50만원",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "* 인력구성 : 공간멘토 1인",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "* 기본 총 5회기로 10시간, 250만원",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          horizontalLine(lineColor: const Color(0xFFE4E7ED)),
        ],
      ),
    );
  }

  Widget buildTable02() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            height: 20,
            alignment: Alignment.centerLeft,
            child: const Text(
              "※ 1인 가구 주거 공간정리 컨설팅",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 14),
          horizontalLine(),
          buildGridRow(
            cellColor: const Color(0XFFFAFAFA),
            textColor: const Color(0xFF686C73),
            cellStr1: "서비스\n프로세스",
            cellStr2: "소요시간",
            cellStr3: "방문횟수",
            cellStr4: "가격\nVAT포함",
          ),
          horizontalLine(lineColor: const Color(0xFFE4E7ED)),
          Container(
            height: 42,
            color: Colors.white,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Flexible(
                  flex: 84,
                  child: Container(
                    height: 42,
                    alignment: Alignment.center,
                    child: const Text(
                      "현장 방문 또는\n화상/음성",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 42,
                  color: const Color(0xFFE4E7ED),
                ),
                Flexible(
                  flex: 72,
                  child: Container(
                    height: 42,
                    alignment: Alignment.center,
                    child: const Text(
                      "1시간",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 42,
                  color: const Color(0xFFE4E7ED),
                ),
                Flexible(
                  flex: 81,
                  child: Container(
                    height: 42,
                    alignment: Alignment.center,
                    child: const Text(
                      "1회",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 42,
                  color: const Color(0xFFE4E7ED),
                ),
                Flexible(
                  flex: 80,
                  child: Container(
                    height: 42,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "110,000원",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "*2룸 이하 기준",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF7D8086),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          horizontalLine(lineColor: const Color(0xFFE4E7ED)),
          Container(
            height: 86,
            color: Colors.white,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Flexible(
                  flex: 84,
                  child: Container(
                    height: 86,
                    alignment: Alignment.center,
                    child: const Text(
                      "공간 컨설팅\n보고서 제공",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 86,
                  color: const Color(0xFFE4E7ED),
                ),
                Flexible(
                  flex: 72,
                  child: Container(
                    height: 86,
                    alignment: Alignment.center,
                    child: const Text(
                      "7일\n(2차 방문일\n이후 영업일\n기준)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 86,
                  color: const Color(0xFFE4E7ED),
                ),
                Flexible(
                  flex: 81,
                  child: Container(
                    height: 86,
                    alignment: Alignment.center,
                    child: const Text(
                      "프레젠테이션\n기준 30\n슬라이드 내외\n(이미지 포함)\n메일로 송부",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.2,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 86,
                  color: const Color(0xFFE4E7ED),
                ),
                Flexible(
                  flex: 80,
                  child: Container(
                    height: 86,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "110,000원",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "*2룸 이하 기준",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF7D8086),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          horizontalLine(lineColor: const Color(0xFFE4E7ED)),
        ],
      ),
    );
  }

  Widget buildTable03() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            height: 20,
            alignment: Alignment.centerLeft,
            child: const Text(
              "※ 1인 가구 주거 공간정리 대행 서비스 프로세스",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 14),
          horizontalLine(),
          // textColor: const Color(0xFF686C73),
          Container(
            height: 42,
            color: const Color(0XFFFAFAFA),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Flexible(
                  flex: 156,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "서비스 프로세스",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF686C73),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 42,
                  color: const Color(0xFFE4E7ED),
                ),
                Flexible(
                  flex: 68,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "소요시간",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF686C73),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 42,
                  color: const Color(0xFFE4E7ED),
                ),
                Flexible(
                  flex: 94,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "가격(VAT) 포함",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF686C73),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          horizontalLine(lineColor: const Color(0xFFE4E7ED)),
          Container(
            height: 86,
            color: Colors.white,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Flexible(
                  flex: 156,
                  child: Column(
                    children: [
                      Container(
                        height: 42.5,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 8),
                        child: const Text(
                          "1차 현장방문 또는 화상미팅",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: const Color(0xFFE4E7ED),
                      ),
                      Container(
                        height: 42.5,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 8),
                        child: const Text(
                          "2차 현장방문",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 86,
                  color: const Color(0xFFE4E7ED),
                ),
                Flexible(
                  flex: 68,
                  child: Column(
                    children: [
                      Container(
                        height: 42.5,
                        alignment: Alignment.center,
                        child: const Text(
                          "1시간",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: const Color(0xFFE4E7ED),
                      ),
                      Container(
                        height: 42.5,
                        alignment: Alignment.center,
                        child: const Text(
                          "8시간",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 86,
                  color: const Color(0xFFE4E7ED),
                ),
                Flexible(
                  flex: 94,
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "110,000원",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "*2룸 이하 기준",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF898D93),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          horizontalLine(lineColor: const Color(0xFFE4E7ED)),
          Container(
            height: 42,
            color: Colors.white,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Flexible(
                  flex: 156 + 68,
                  child: Container(
                    padding: const EdgeInsets.only(left: 8),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "수납용품 큐레이션 서비스 제공",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 42,
                  color: Colors.transparent,
                ),
                Container(
                  width: 1,
                  height: 42,
                  color: const Color(0xFFE4E7ED),
                ),
                Flexible(
                  flex: 94,
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "220,000원",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          "할인 0원",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          horizontalLine(lineColor: const Color(0xFFE4E7ED)),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 16,
                alignment: Alignment.center,
                child: Container(
                  width: 2,
                  height: 2,
                  decoration: BoxDecoration(
                    color: const Color(0xFF898D93),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  "컨설팅 + 주거공간 정리 서비스 대행으로 서비스 인원 2인 기준",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    height: 1.3,
                    fontSize: 12,
                    color: Color(0xFF898D93),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTable04() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            height: 20,
            alignment: Alignment.centerLeft,
            child: const Text(
              "※ 주거공간 정리 타임 서비스",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 14),
          horizontalLine(),
          // textColor: const Color(0xFF686C73),
          Container(
            height: 42,
            color: const Color(0XFFFAFAFA),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Flexible(
                  flex: 60,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "서비스\n프로세스",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF686C73),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 42,
                  color: const Color(0xFFE4E7ED),
                ),
                Flexible(
                  flex: 60,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "소요시간",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF686C73),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 42,
                  color: const Color(0xFFE4E7ED),
                ),
                Flexible(
                  flex: 80,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "가격\nVAT포함",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF686C73),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 42,
                  color: const Color(0xFFE4E7ED),
                ),
                Flexible(
                  flex: 117,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "세부내용",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF686C73),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          horizontalLine(lineColor: const Color(0xFFE4E7ED)),
          Container(
            height: 130,
            color: Colors.white,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Flexible(
                  flex: 60,
                  child: Column(
                    children: [
                      Container(
                        height: 42.5,
                        alignment: Alignment.center,
                        child: const Text(
                          "2인",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: const Color(0xFFE4E7ED),
                      ),
                      Container(
                        height: 42.5,
                        alignment: Alignment.center,
                        child: const Text(
                          "2인",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: const Color(0xFFE4E7ED),
                      ),
                      Container(
                        height: 42.5,
                        alignment: Alignment.center,
                        child: const Text(
                          "2인",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 130,
                  color: const Color(0xFFE4E7ED),
                ),
                Flexible(
                  flex: 60,
                  child: Column(
                    children: [
                      Container(
                        height: 42.5,
                        alignment: Alignment.center,
                        child: const Text(
                          "3시간",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: const Color(0xFFE4E7ED),
                      ),
                      Container(
                        height: 42.5,
                        alignment: Alignment.center,
                        child: const Text(
                          "4시간",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: const Color(0xFFE4E7ED),
                      ),
                      Container(
                        height: 42.5,
                        alignment: Alignment.center,
                        child: const Text(
                          "5시간",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 130,
                  color: const Color(0xFFE4E7ED),
                ),
                Flexible(
                  flex: 80,
                  child: Column(
                    children: [
                      Container(
                        height: 42.5,
                        alignment: Alignment.center,
                        child: const Text(
                          "198,000원",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: const Color(0xFFE4E7ED),
                      ),
                      Container(
                        height: 42.5,
                        alignment: Alignment.center,
                        child: const Text(
                          "264,000원",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: const Color(0xFFE4E7ED),
                      ),
                      Container(
                        height: 42.5,
                        alignment: Alignment.center,
                        child: const Text(
                          "330,000원",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 130,
                  color: const Color(0xFFE4E7ED),
                ),
                Flexible(
                  flex: 117,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "* 기본 2인 3시간부터 가능",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "* 추가 1시간 당 66,000원 비용 발생",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          horizontalLine(lineColor: const Color(0xFFE4E7ED)),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 16,
                alignment: Alignment.center,
                child: Container(
                  width: 2,
                  height: 2,
                  decoration: BoxDecoration(
                    color: const Color(0xFF898D93),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  "방문 시 질문지를 제공하여 고객 요구사항 확인",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    height: 1.3,
                    fontSize: 12,
                    color: Color(0xFF898D93),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 16,
                alignment: Alignment.center,
                child: Container(
                  width: 2,
                  height: 2,
                  decoration: BoxDecoration(
                    color: const Color(0xFF898D93),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  "3시간 기준 최대 4시간까지 추가 가능",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    height: 1.3,
                    fontSize: 12,
                    color: Color(0xFF898D93),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildGridRow({
    Color cellColor = Colors.white,
    Color textColor = Colors.black,
    double cellHeight = 42,
    String cellStr1 = "",
    String cellStr2 = "",
    String cellStr3 = "",
    String cellStr4 = "",
    String cellStr5 = "",
  }) {
    if (cellStr5.isNotEmpty) {
      return Container(
        height: cellHeight,
        color: cellColor,
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Flexible(
              flex: 56,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  cellStr1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: textColor,
                    fontWeight: (cellColor == Colors.white) ? FontWeight.w400 : FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              height: cellHeight,
              color: const Color(0xFFE4E7ED),
            ),
            Flexible(
              flex: 60,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  cellStr2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: textColor,
                    fontWeight: (cellColor == Colors.white) ? FontWeight.w400 : FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              height: cellHeight,
              color: const Color(0xFFE4E7ED),
            ),
            Flexible(
              flex: 60,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  cellStr3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: textColor,
                    fontWeight: (cellColor == Colors.white) ? FontWeight.w400 : FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              height: cellHeight,
              color: const Color(0xFFE4E7ED),
            ),
            Flexible(
              flex: 60,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  cellStr4,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: textColor,
                    fontWeight: (cellColor == Colors.white) ? FontWeight.w400 : FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              height: cellHeight,
              color: const Color(0xFFE4E7ED),
            ),
            Flexible(
              flex: 80,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  cellStr5,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: textColor,
                    fontWeight: (cellColor == Colors.white) ? FontWeight.w400 : FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (cellStr4.isNotEmpty) {
      return Container(
        height: cellHeight,
        color: cellColor,
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Flexible(
              flex: 84,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  cellStr1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: textColor,
                    fontWeight: (cellColor == Colors.white) ? FontWeight.w400 : FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              height: cellHeight,
              color: const Color(0xFFE4E7ED),
            ),
            Flexible(
              flex: 72,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  cellStr2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: textColor,
                    fontWeight: (cellColor == Colors.white) ? FontWeight.w400 : FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              height: cellHeight,
              color: const Color(0xFFE4E7ED),
            ),
            Flexible(
              flex: 81,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  cellStr3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: textColor,
                    fontWeight: (cellColor == Colors.white) ? FontWeight.w400 : FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              height: cellHeight,
              color: const Color(0xFFE4E7ED),
            ),
            Flexible(
              flex: 80,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  cellStr4,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: textColor,
                    fontWeight: (cellColor == Colors.white) ? FontWeight.w400 : FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      height: cellHeight,
      color: cellColor,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                cellStr1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: textColor,
                  fontWeight: (cellColor == Colors.white) ? FontWeight.w400 : FontWeight.w600,
                ),
              ),
            ),
          ),
          Container(
            width: 1,
            height: cellHeight,
            color: const Color(0xFFE4E7ED),
          ),
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                cellStr2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: textColor,
                  fontWeight: (cellColor == Colors.white) ? FontWeight.w400 : FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget horizontalLine({Color lineColor = const Color(0xFFC9CDD4)}) {
    return Container(
      height: 1,
      color: lineColor,
    );
  }
}
