import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/text_paragraph.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/user_model.dart';
import 'package:uplatform/page/booking/booking_restaurant_page.dart';
import 'package:uplatform/page/signin/login_email_page.dart';
import 'package:uplatform/services/login_service.dart';

class HomeRestaurantDetailPage extends StatefulWidget {
  const HomeRestaurantDetailPage({Key? key}) : super(key: key);

  static const routeName = '/HomeRestaurantDetailPage';

  @override
  _HomeRestaurantDetailPageState createState() => _HomeRestaurantDetailPageState();
}

class _HomeRestaurantDetailPageState extends State<HomeRestaurantDetailPage> {
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
                      'assets/images/home_restaurant_detail_bg.png',
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
    debugPrint("MediaQuery.of(context).textScaleFactor ${MediaQuery.of(context).textScaleFactor}");

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 126),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 20),
                child: const Text(
                  "왜",
                  style: TextStyle(
                    fontSize: 58,
                    height: 1.0,
                    color: Color(0xFFFFC113),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  TextTitle(
                    titleText: "음식점 위생정리 서비스가",
                    cellHeight: 32,
                    fontSize: 24,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.w600,
                    padding: EdgeInsets.only(left: 8),
                  ),
                  SizedBox(height: 8),
                  TextTitle(
                    titleText: "필요한가요?",
                    cellHeight: 32,
                    fontSize: 24,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.w600,
                    padding: EdgeInsets.only(left: 8),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.topLeft,
            child: const Text.rich(
              TextSpan(
                text: "대한민국에서는 전국 음식점의 위생수준을 평가하여 등급을 부여하는 ",
                style: TextStyle(
                  fontSize: 15 * 1.0,
                  height: 1.4,
                  color: Color(0xFF686C73),
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: "음식점 위생등급제",
                    style: TextStyle(
                      fontSize: 15 * 1.0,
                      height: 1.4,
                      color: Color(0xFF10A2DC),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: "를 시행하고 있습니다.",
                    style: TextStyle(
                      fontSize: 15 * 1.0,
                      height: 1.4,
                      color: Color(0xFF686C73),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          const SizedBox(height: 24),
          const TextParagraph(
            paraText: "스타벅스는 전 지점에서 위생등급 ‘매우우수’를 취득하였습니다.",
            fontColor: Color(0xFF686C73),
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 8),
          const TextParagraph(
            paraText: "*2022년 2월 기준 위생등급을 취득한 스타벅스 매장은 1,405개이며 그 중 3개 지점을 제외한 모든 지점에서 ‘매우우수’ 취득했습니다.",
            fontColor: Color(0xFF686C73),
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 24),
          const TextParagraph(
            paraText: "GS25는 편의점 최초로 위생등급을 취득하는 정책을 펼치고 있습니다.",
            fontColor: Color(0xFF686C73),
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 24),
          const TextParagraph(
            paraText:
                "프랜차이즈에서는 이미 위생등급 취득으로 고객에게 위생에 대한 신뢰를 쌓고 위생등급 취득으로 얻을 수 있는 혜택을 누리고 있습니다. (2년 간 관계 공무원 출입 면제, 최대 7,000만 원 상당의 융자 지원 등)",
            fontColor: Color(0xFF686C73),
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 24),
          const TextParagraph(
            paraText:
                "음식점 위생등급을 취득한 업소는 전국 외식업소 기준 약 3%에 불과합니다. 샤이니오! 전문가들은 까다로운 위생등급 취득 기준에 맞추면서도 업장의 동선을 고려한 위생정리 서비스를 제공해 드립니다. 샤이니오! 와 함께 가장 먼저 위생등급을 취득하는 외식업소가 되어보세요.",
            fontColor: Color(0xFF686C73),
            fontWeight: FontWeight.w400,
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
            cellHeight: 28,
            fontSize: 18,
            fontColor: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 18),
          buildTable01(),
          const SizedBox(height: 26),
          buildTable02(),
          const SizedBox(height: 26),
          buildTable03(),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BorderRoundedButton(
              text: "음식점 위생정리 서비스 신청",
              buttonColor: kMainColor,
              onPressed: () {
                if (_loginUser == null) {
                  Get.toNamed(LoginEmailPage.routeName, arguments: "BookingRestaurantPage");
                  return;
                }

                Get.offNamed(BookingRestaurantPage.routeName);
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
          const TextTitle(
            titleText: "※ 음식점 위생 정리 컨설팅 (부분)",
            cellHeight: 20,
            fontSize: 15,
            fontColor: Colors.black,
            fontWeight: FontWeight.w600,
            padding: EdgeInsets.all(0),
          ),
          const SizedBox(height: 14),
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
            cellStr5: "330,000원",
          ),
          horizontalLine(lineColor: const Color(0xFFE4E7ED)),
          buildGridRow(
            cellHeight: 56,
            cellStr1: "2",
            cellStr2: "주방\n(냉장고\n미포함)",
            cellStr3: "2시간",
            cellStr4: "1회",
            cellStr5: "330,000원",
          ),
          horizontalLine(lineColor: const Color(0xFFE4E7ED)),
          buildGridRow(
            cellStr1: "3",
            cellStr2: "홀 티카",
            cellStr3: "2시간",
            cellStr4: "1회",
            cellStr5: "330,000원",
          ),
          horizontalLine(lineColor: const Color(0xFFE4E7ED)),
          buildGridRow(
            cellStr1: "4",
            cellStr2: "창고",
            cellStr3: "2시간",
            cellStr4: "1회",
            cellStr5: "330,000원",
          ),
          horizontalLine(lineColor: const Color(0xFFE4E7ED)),
          buildGridRow(
            cellStr1: "5",
            cellStr2: "워크인\n냉장고",
            cellStr3: "2시간",
            cellStr4: "1회",
            cellStr5: "330,000원",
          ),
          horizontalLine(lineColor: const Color(0xFFE4E7ED)),
          buildGridRow(
            cellStr1: "6",
            cellStr2: "객실",
            cellStr3: "2시간",
            cellStr4: "1회",
            cellStr5: "330,000원",
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
            titleText: "※ 음식점 위생 정리 컨설팅 (전체)",
            cellHeight: 20,
            fontSize: 15,
            fontColor: Colors.black,
            fontWeight: FontWeight.w600,
            padding: EdgeInsets.all(0),
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
                          "2시간",
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
                          "3시간",
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
                          "990,000원",
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
          buildGridRow(
            cellHeight: 86,
            cellStr1: "공간 컨설팅\n보고서 제공",
            cellStr2: "7일\n(2차 방문일\n이후 영업일\n기준)",
            cellStr3: "프레젠테이션\n기준 30\n슬라이드 내외\n(이미지포함)\n메일로 송부",
            cellStr4: "990,000원",
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
          const TextTitle(
            titleText: "※ 음식점 위생 정리 컨설팅 (부가서비스)",
            cellHeight: 20,
            fontSize: 15,
            fontColor: Colors.black,
            fontWeight: FontWeight.w600,
            padding: EdgeInsets.all(0),
          ),
          const SizedBox(height: 14),
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
            cellStr2: "330,000원",
          ),
          horizontalLine(lineColor: const Color(0xFFE4E7ED)),
          buildGridRow(
            cellStr1: "수납용품 정보 제공",
            cellStr2: "220,000원",
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
                    height: 1.2,
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
