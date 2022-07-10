import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/user_model.dart';
import 'package:uplatform/page/booking/booking_space_page.dart';
import 'package:uplatform/page/signin/login_email_page.dart';
import 'package:uplatform/services/login_service.dart';

class HomeCleanSpaceDetailPage extends StatefulWidget {
  const HomeCleanSpaceDetailPage({Key? key}) : super(key: key);

  static const routeName = '/HomeCleanSpaceDetailPage';

  @override
  _HomeCleanSpaceDetailPageState createState() => _HomeCleanSpaceDetailPageState();
}

class _HomeCleanSpaceDetailPageState extends State<HomeCleanSpaceDetailPage> {
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
                      'assets/images/home_clean_space_detail_bg.png',
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
          const SizedBox(height: 126),
          const TextTitle(
            titleText: "공간정리로 만드는",
            cellHeight: 32,
            fontSize: 24,
            fontColor: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          const TextTitle(
            titleText: "빛나는 일상",
            cellHeight: 32,
            fontSize: 24,
            fontColor: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.topLeft,
            child: const Text(
              "일상에는 일과 쉼이 공존합니다.\n\n대부분의 하루를 보내는 업무 공간과 주거 공간의 변화, 당신의 하루와 일상의 변화를 의미합니다.\n\n두가지 삶이 모두 빛날 수 있도록\n샤이오니 전문가와 함께해 보세요.\n\n주방 정리, 냉장고 정리, 서재 정리, 드레스룸 정리, 아이방 정리 등",
              // textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 15,
                height: 1.45,
                color: Color(0xFF686C73),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 48),
          const TextTitle(
            titleText: "서비스 이용 시간",
            cellHeight: 24,
            fontSize: 18,
            fontColor: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 25,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "평일 (월 - 금)",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.0,
                        color: Color(0xFF686C73),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 25,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "주말 (공휴일 포함)",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.0,
                        color: Color(0xFF686C73),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 25,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "오전 9시 - 오후 8시",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 25,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "오전 9시 - 오후 6시",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 46),
          const TextTitle(
            titleText: "서비스 이용 가격",
            cellHeight: 26,
            fontSize: 18,
            fontColor: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 20),
          const TextTitle(
            titleText: "1. 음식점 위생 공간",
            cellHeight: 26,
            fontSize: 18,
            fontColor: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          buildTable01(),
          const SizedBox(height: 26),
          buildTable02(),
          const SizedBox(height: 36),
          const TextTitle(
            titleText: "2. 주거 공간",
            cellHeight: 26,
            fontSize: 18,
            fontColor: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 20),
          buildTable03(),
          const SizedBox(height: 28),
          buildTable04(),
          const SizedBox(height: 28),
          buildTable05(),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BorderRoundedButton(
              text: "공간정리 서비스 신청",
              buttonColor: kMainColor,
              onPressed: () {
                if (_loginUser == null) {
                  Get.toNamed(LoginEmailPage.routeName, arguments: "BookingSpacePage");
                  return;
                }

                Get.offNamed(BookingSpacePage.routeName);
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
          const SizedBox(height: 20),
          const TextTitle(
            titleText: "※ 음식점 위생 공간 정리 대행 서비스 (부분)",
            cellHeight: 20,
            fontSize: 15,
            fontColor: Colors.black,
            fontWeight: FontWeight.w600,
            padding: EdgeInsets.all(0),
          ),
          const SizedBox(height: 16),
          horizontalLine(),
          buildGridRow(
            cellColor: const Color(0XFFFAFAFA),
            textColor: const Color(0xFF686C73),
            cellStr1: "서비스\nNO",
            cellStr2: "서비스\n범위",
            cellStr3: "소요시간",
            cellStr4: "방문횟수",
            cellStr5: "가격\nVAT포함",
          ),
          horizontalLine(lineColor: const Color(0xFFE4E7ED)),
          buildGridRow(
            cellStr1: "1",
            cellStr2: "냉장고",
            cellStr3: "2시간",
            cellStr4: "1회",
            cellStr5: "880,000원",
          ),
          horizontalLine(lineColor: const Color(0xFFE4E7ED)),
          buildGridRow(
            cellHeight: 56,
            cellStr1: "2",
            cellStr2: "주방\n(냉장고\n미포함)",
            cellStr3: "2시간",
            cellStr4: "1회",
            cellStr5: "880,000원",
          ),
          horizontalLine(lineColor: const Color(0xFFE4E7ED)),
          buildGridRow(
            cellStr1: "3",
            cellStr2: "홀 티카",
            cellStr3: "2시간",
            cellStr4: "1회",
            cellStr5: "880,000원",
          ),
          horizontalLine(lineColor: const Color(0xFFE4E7ED)),
          buildGridRow(
            cellStr1: "4",
            cellStr2: "창고",
            cellStr3: "2시간",
            cellStr4: "1회",
            cellStr5: "880,000원",
          ),
          horizontalLine(lineColor: const Color(0xFFE4E7ED)),
          buildGridRow(
            cellStr1: "5",
            cellStr2: "워크인\n냉장고",
            cellStr3: "2시간",
            cellStr4: "1회",
            cellStr5: "880,000원",
          ),
          horizontalLine(lineColor: const Color(0xFFE4E7ED)),
          buildGridRow(
            cellStr1: "6",
            cellStr2: "객실",
            cellStr3: "2시간",
            cellStr4: "1회",
            cellStr5: "880,000원",
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
          const TextTitle(
            titleText: "※ 음식점 위생 정리 대행 서비스 (전체)",
            cellHeight: 20,
            fontSize: 15,
            fontColor: Colors.black,
            fontWeight: FontWeight.w600,
            padding: EdgeInsets.all(0),
          ),
          const SizedBox(height: 16),
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
            height: 86,
            color: Colors.white,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Flexible(
                  flex: 84,
                  child: Column(
                    children: [
                      Container(
                        height: 42.5,
                        alignment: Alignment.center,
                        child: const Text(
                          "1차 현장 방문",
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
                          "2차 현장 방문",
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
                  flex: 72,
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
                  flex: 81,
                  child: Column(
                    children: [
                      Container(
                        height: 42.5,
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
                      Container(
                        height: 1,
                        color: const Color(0xFFE4E7ED),
                      ),
                      Container(
                        height: 42.5,
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
                    ],
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
                          "2,900,000원",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "*1~6번 전체\n범위\n*50평 이하\n기준",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.2,
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
                  "컨설팅 + 위생공간 정리 서비스 대행으로 공과잡비는 전체 금액의 10%, 서비스 인원 7인 기준",
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

  Widget buildTable03() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const TextTitle(
            titleText: "※ 주거 공간정리 컨설팅",
            cellHeight: 20,
            fontSize: 15,
            fontColor: Colors.black,
            fontWeight: FontWeight.w600,
            padding: EdgeInsets.all(0),
          ),
          const SizedBox(height: 16),
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
            height: 86,
            color: Colors.white,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Flexible(
                  flex: 84,
                  child: Column(
                    children: [
                      Container(
                        height: 42.5,
                        alignment: Alignment.center,
                        child: const Text(
                          "1차 현장 방문",
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
                          "2차 현장 방문",
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
                  flex: 72,
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
                          "2시간",
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
                  flex: 81,
                  child: Column(
                    children: [
                      Container(
                        height: 42.5,
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
                      Container(
                        height: 1,
                        color: const Color(0xFFE4E7ED),
                      ),
                      Container(
                        height: 42.5,
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
                    ],
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
                          "550,000원",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "*32평 이하\n기준",
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
                    alignment: Alignment.center,
                    child: const Text(
                      "7일\n(2차 방문일\n이후 영업일\n기준)",
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
                  flex: 81,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "프레젠테이션\n기준 30\n슬라이드 내외\n(이미지포함)\n메일로 송부",
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
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "550,000원",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "*32평 이하\n기준",
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

  Widget buildTable04() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const TextTitle(
            titleText: "※ 주거 공간 정리 대행 서비스",
            cellHeight: 20,
            fontSize: 15,
            fontColor: Colors.black,
            fontWeight: FontWeight.w600,
            padding: EdgeInsets.all(0),
          ),
          const SizedBox(height: 16),
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
            height: 86,
            color: Colors.white,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Flexible(
                  flex: 84,
                  child: Column(
                    children: [
                      Container(
                        height: 42.5,
                        alignment: Alignment.center,
                        child: const Text(
                          "1차 현장 방문",
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
                          "2차 현장 방문",
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
                  flex: 72,
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
                  flex: 81,
                  child: Column(
                    children: [
                      Container(
                        height: 42.5,
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
                      Container(
                        height: 1,
                        color: const Color(0xFFE4E7ED),
                      ),
                      Container(
                        height: 42.5,
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
                    ],
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
                          "2,420,000원",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "*32평 이하\n기준",
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
            height: 42,
            color: Colors.white,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Flexible(
                  flex: 84 + 72 + 81,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "수납용품\n큐레이션 서비스 제공",
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
                  width: 2,
                  height: 42,
                  color: Colors.transparent,
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
                  "컨설팅 + 위생공간 정리 서비스 대행으로 공과잡비는 전체 금액의 10%, 서비스 인원 7인 기준",
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

  Widget buildTable05() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const TextTitle(
            titleText: "※ 주거 공간 정리 컨설팅 (부가서비스)",
            cellHeight: 20,
            fontSize: 15,
            fontColor: Colors.black,
            fontWeight: FontWeight.w600,
            padding: EdgeInsets.all(0),
          ),
          const SizedBox(height: 16),
          horizontalLine(),
          buildGridRow(
            cellColor: const Color(0XFFFAFAFA),
            textColor: const Color(0xFF686C73),
            cellStr1: "서비스명",
            cellStr2: "가격 VAT포함",
          ),
          horizontalLine(lineColor: const Color(0xFFE4E7ED)),
          buildGridRow(
            cellStr1: "수납용품 큐레이션 서비스",
            cellStr2: "220,000원",
          ),
          horizontalLine(lineColor: const Color(0xFFE4E7ED)),
          buildGridRow(
            cellStr1: "수납용품 정보 제공",
            cellStr2: "110,000원",
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
                  "컨설팅 또는 대행 서비스 구매 시 이용 가능한 유료 부가 서비스",
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
