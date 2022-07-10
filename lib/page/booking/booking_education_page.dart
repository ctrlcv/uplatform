import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/dot_text_view.dart';
import 'package:uplatform/components/input_title.dart';
import 'package:uplatform/components/text_paragraph.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:universal_platform/universal_platform.dart';

import 'booking_education_step01_page.dart';
import 'booking_payment_page.dart';

class BookingEducationPage extends StatefulWidget {
  const BookingEducationPage({Key? key}) : super(key: key);

  static const routeName = '/BookingEducationPage';

  @override
  _BookingEducationPageState createState() => _BookingEducationPageState();
}

class _BookingEducationPageState extends State<BookingEducationPage> {
  final ScrollController _scrollController = ScrollController();

  // 공간정리 코칭 서비스
  bool _coachServiceSpace = false;
  // 주거공간 코칭 서비스
  bool _coachServiceHouse = false;

  // 주거공간 코칭 서비스 - 서비스 종류
  bool _houseServiceTypeConcerting = false;
  bool _houseServiceTypeClean = false;
  bool _houseServiceTypeTimeService = false;

  bool _isShowProductDetail = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
              const SizedBox(height: 16),
              const TextTitle(
                titleText: "정리 교육 예약",
                cellHeight: 32,
                fontSize: 24,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 40),
              const InputTitle(
                title: "교육 과정",
                isRequired: true,
                textFontSize: 15,
                padding: EdgeInsets.symmetric(horizontal: 20),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _coachServiceSpace = true;
                        _coachServiceHouse = false;

                        _houseServiceTypeConcerting = false;
                        _houseServiceTypeClean = false;
                        _houseServiceTypeTimeService = false;

                        if (mounted) {
                          setState(() {});
                        }
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: _coachServiceSpace ? kSelectColor : Colors.white,
                          border: Border.all(
                            color: _coachServiceSpace ? kSelectColor : const Color(0xFFE4E7ED),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "공간정리 코칭 서비스",
                          style: TextStyle(
                            fontSize: 15,
                            color: _coachServiceSpace ? Colors.white : const Color(0xFF686C73),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        _coachServiceSpace = false;
                        _coachServiceHouse = true;

                        if (mounted) {
                          setState(() {});
                        }
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: _coachServiceHouse ? kSelectColor : Colors.white,
                          border: Border.all(
                            color: _coachServiceHouse ? kSelectColor : const Color(0xFFE4E7ED),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "주거공간 코칭 서비스",
                          style: TextStyle(
                            fontSize: 15,
                            color: _coachServiceHouse ? Colors.white : const Color(0xFF686C73),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_coachServiceHouse) buildHouseServiceType(),
              const SizedBox(height: 32),
              Container(
                height: 12,
                color: const Color(0xFFF1F2F4),
              ),
              const SizedBox(height: 32),
              const TextTitle(
                titleText: "정리교육",
                cellHeight: 26,
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              const TextTitle(
                titleText: "공간정리/주거공간 코칭 서비스",
                cellHeight: 26,
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 24),
              Image.asset(
                "assets/images/booking_education_banner.png",
                width: screenWidth,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(height: 40),
              const TextTitle(
                titleText: "공간정리로 교육으로",
                cellHeight: 26,
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              const TextTitle(
                titleText: "일상 정리부터 커리어 개발까지",
                cellHeight: 26,
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 12),
              const TextParagraph(
                paraText: "2주 과정부터 강사 과정까지 나와 나의 일상을 변화시킬 정리 수납 교육을 만나보세요",
              ),
              const SizedBox(height: 32),
              Image.asset(
                "assets/images/booking_education_image.png",
                width: screenWidth - 40,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(height: 32),
              if (_isShowProductDetail)
                buildProductDetail()
              else
                GestureDetector(
                  onTap: () {
                    _isShowProductDetail = !_isShowProductDetail;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    height: 44,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "상품정보 더보기",
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.0,
                            color: Color(0xFF686C73),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.keyboard_arrow_down, color: Color(0xFF686C73), size: 20),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BorderRoundedButton(
                  text: "예약하기",
                  buttonColor: kMainColor,
                  onPressed: () async {
                    if (!_coachServiceSpace && !_coachServiceHouse) {
                      _scrollController.animateTo(_scrollController.position.minScrollExtent,
                          duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
                      Get.snackbar('교육 과정 미선택', "교육 과정을 선택하세요",
                          snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                      return;
                    }

                    if (_coachServiceHouse) {
                      if (!_houseServiceTypeConcerting && !_houseServiceTypeClean && !_houseServiceTypeTimeService) {
                        _scrollController.animateTo(_scrollController.position.minScrollExtent,
                            duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
                        Get.snackbar('서비스 종류 미선택', "서비스 종류를 선택하세요",
                            snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                        return;
                      }
                    }

                    Map<String, dynamic> bookingParams = {};
                    bookingParams['coachServiceSpace'] = _coachServiceSpace;
                    bookingParams['coachServiceHouse'] = _coachServiceHouse;

                    bookingParams['houseServiceTypeConcerting'] = _houseServiceTypeConcerting;
                    bookingParams['houseServiceTypeClean'] = _houseServiceTypeClean;
                    bookingParams['houseServiceTypeTimeService'] = _houseServiceTypeTimeService;

                    Get.toNamed(BookingEducationStep01Page.routeName, arguments: bookingParams);
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

  Widget buildProductDetail() {
    return Column(
      children: [
        Container(
          color: const Color(0xFFE2F1F6),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const TextTitle(
                titleText: "공간정리 코칭 서비스",
                cellHeight: 22,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontColor: Colors.black,
              ),
              const SizedBox(height: 8),
              const TextParagraph(
                paraText: "1단계~ 5단계까지 총 교육비 2,500,000원이며 공간 멘토 1인이 함께합니다.",
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontColor: Color(0xFF686C73),
              ),
              const SizedBox(height: 16),
              buildProductItem("1단계", "1회기 2시간", "코칭 목표 설정", "500,000원"),
              const SizedBox(height: 12),
              buildProductItem("2단계", "2회기 2시간", "물건 분류 방법 배우기", "500,000원"),
              const SizedBox(height: 12),
              buildProductItem("3단계", "3회기 2시간", "물건 소유의 기준 정하기", "500,000원"),
              const SizedBox(height: 12),
              buildProductItem("4단계", "4회기 2시간", "공간 기획하기", "500,000원"),
              const SizedBox(height: 12),
              buildProductItem("5단계", "5회기 2시간", "공간 정리하기", "500,000원"),
              const SizedBox(height: 40),
              const TextTitle(
                titleText: "주거공간 코칭 서비스",
                cellHeight: 22,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontColor: Colors.black,
              ),
              const SizedBox(height: 6),
              const TextTitle(
                titleText: "1인 가구 주거공간 정리 컨설팅",
                cellHeight: 18,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontColor: Colors.black,
              ),
              const SizedBox(height: 16),
              buildProductItem("방문 및 화성/음성 미팅", "", "", "110,000원"),
              const SizedBox(height: 12),
              buildProductItem("공간 컨설팅 보고서 제공", "", "", "110,000원"),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const DotTextView(
                  textStr: "2룸 기준이며 보고서는 전체 서비스 2차 방문일 이후, 영업일 기준 7일이내 제공",
                  textSize: 12,
                  textColor: Color(0xFF686C73),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const DotTextView(
                  textStr: "프레젠테이션 10 슬라이드 내외 (이미지 포함) 메일로 송부",
                  textSize: 12,
                  textColor: Color(0xFF686C73),
                ),
              ),
              const SizedBox(height: 40),
              const TextTitle(
                titleText: "주거공간 코칭 서비스",
                cellHeight: 22,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontColor: Colors.black,
              ),
              const SizedBox(height: 6),
              const TextTitle(
                titleText: "1인 가구 주거공간 정리 대행서비스",
                cellHeight: 18,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontColor: Colors.black,
              ),
              const SizedBox(height: 16),
              buildProductItem("방문 2회", "1차 방문 및 화상 미팅/2차 방문 8시간", "", "110,000원"),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const DotTextView(
                  textStr: "정리대행 서비스 이용 시 [수납용품 큐레이션 서비스] 220,000원 상당 무료",
                  textSize: 12,
                  textColor: Color(0xFF686C73),
                ),
              ),
              const SizedBox(height: 40),
              const TextTitle(
                titleText: "주거공간 코칭 서비스",
                cellHeight: 22,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontColor: Colors.black,
              ),
              const SizedBox(height: 6),
              const TextTitle(
                titleText: "1인 가구 주거공간 정리 타임서비스",
                cellHeight: 18,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontColor: Colors.black,
              ),
              const SizedBox(height: 16),
              buildProductItem("교육생 2인", "3시간 기준", "", "198,000원"),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const DotTextView(
                  textStr: "1시간 추가 시 66,000원 추가되며 최대 4시간까지 가능",
                  textSize: 12,
                  textColor: Color(0xFF686C73),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const DotTextView(
                  textStr: "방문 시 질문지를 제공하여 고객 요구사항 확인",
                  textSize: 12,
                  textColor: Color(0xFF686C73),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
        const SizedBox(height: 40),
        const TextTitle(
          titleText: "서비스 예약 방법",
          cellHeight: 18,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          fontColor: Colors.black,
        ),
        const SizedBox(height: 8),
        buildParagraph("정리 교육 과정을 선택합니다.", title: "1. "),
        const SizedBox(height: 8),
        buildParagraph("교육을 받고자 하는 요일을 선택합니다.", title: "2. "),
        const SizedBox(height: 8),
        buildParagraph("예약을 완료 후 카카오(알림톡)으로 교육일정을 안내해 드립니다.", title: "3. "),
        const SizedBox(height: 32),
        const TextTitle(
          titleText: "교육취소 및 환불안내",
          cellHeight: 18,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          fontColor: Colors.black,
        ),
        const SizedBox(height: 8),
        buildParagraph("교육 개시 이전 납부한 수강료 100% 환불", title: "1. "),
        const SizedBox(height: 8),
        buildParagraph("프로필 > 예약내역리스트에서 취소 가능", title: "2. "),
        const SizedBox(height: 8),
        buildParagraph("총 교육 시간의 1/3 경과 전 취소시, 이미 납부한 수강료의 2/3 해당 액 환불", title: "3. "),
        const SizedBox(height: 8),
        buildParagraph("총 교육 시간의 1/2 경과 전 취소시, 이미 납부한 수강료의 1/2 해당 액 환불", title: "4. "),
        const SizedBox(height: 8),
        buildParagraph("총 교육 시간의 1/2 경과 후 환불 불가\n(고객센터 문의)", title: "5. "),
        const SizedBox(height: 32),
        const TextTitle(
          titleText: "교육 시간",
          cellHeight: 18,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          fontColor: Colors.black,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              height: 16,
              width: 90,
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: const Text(
                "평일반",
                style: TextStyle(
                  fontSize: 13,
                  height: 1.0,
                  color: Color(0xFF686C73),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              height: 16,
              alignment: Alignment.centerLeft,
              child: const Text(
                "오전 9시 ~ 오후 8시(점심 1시간)",
                style: TextStyle(
                  fontSize: 13,
                  height: 1.0,
                  color: Color(0xFF686C73),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              height: 16,
              width: 90,
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: const Text(
                "주말반",
                style: TextStyle(
                  fontSize: 13,
                  height: 1.0,
                  color: Color(0xFF686C73),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              height: 16,
              alignment: Alignment.centerLeft,
              child: const Text(
                "오전 9시 ~ 오후 6시(점심 1시간)",
                style: TextStyle(
                  fontSize: 13,
                  height: 1.0,
                  color: Color(0xFF686C73),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const DotTextView(
            textStr: "교육과정에 따라 변경 될 수 있습니다.",
            textSize: 13,
            textColor: Colors.black,
          ),
        ),
        const SizedBox(height: 32),
        GestureDetector(
          onTap: () {
            _isShowProductDetail = !_isShowProductDetail;
            if (mounted) {
              setState(() {});
            }
          },
          child: Container(
            height: 44,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: const Color(0xFFE4E7ED),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "상품정보 접기",
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.0,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.keyboard_arrow_up, color: Color(0xFF686C73), size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildProductItem(String product, String addProduct, String addText, String won) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  product,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.0,
                    color: Color(0xFF10A2DC),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (addProduct.isNotEmpty)
                Text(
                  addProduct,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
            ],
          ),
          if (addText.isNotEmpty) const SizedBox(height: 8),
          if (addText.isNotEmpty)
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                addText,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          const SizedBox(height: 12),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              won,
              style: const TextStyle(
                fontSize: 15,
                height: 1.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildParagraph(
    String content, {
    String title = "",
    double hPadding = 20,
    TextAlign textAlign = TextAlign.justify,
    double fontSize = 13,
  }) {
    return Column(
      children: [
        const SizedBox(height: 1),
        Container(
          padding: EdgeInsets.only(left: hPadding, right: 20),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title.isNotEmpty)
                Text(
                  title,
                  style: TextStyle(
                    fontSize: fontSize,
                    height: 1.4,
                    color: const Color(0xFF686C73),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              Expanded(
                child: Text(
                  content,
                  textAlign: textAlign,
                  style: TextStyle(
                    fontSize: fontSize,
                    height: 1.4,
                    color: const Color(0xFF686C73),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 1),
      ],
    );
  }

  Widget buildHouseServiceType() {
    return Column(
      children: [
        kHorizontalLine,
        const SizedBox(height: 32),
        const InputTitle(
          title: "서비스 종류",
          isRequired: true,
          textFontSize: 15,
          padding: EdgeInsets.symmetric(horizontal: 20),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _houseServiceTypeConcerting = true;
                  _houseServiceTypeClean = false;
                  _houseServiceTypeTimeService = false;

                  if (mounted) {
                    setState(() {});
                  }
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: _houseServiceTypeConcerting ? kSelectColor : Colors.white,
                    border: Border.all(
                      color: _houseServiceTypeConcerting ? kSelectColor : const Color(0xFFE4E7ED),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "1인 가구 주거공간 정리 컨설팅",
                    style: TextStyle(
                      fontSize: 15,
                      color: _houseServiceTypeConcerting ? Colors.white : const Color(0xFF686C73),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  _houseServiceTypeConcerting = false;
                  _houseServiceTypeClean = true;
                  _houseServiceTypeTimeService = false;

                  if (mounted) {
                    setState(() {});
                  }
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: _houseServiceTypeClean ? kSelectColor : Colors.white,
                    border: Border.all(
                      color: _houseServiceTypeClean ? kSelectColor : const Color(0xFFE4E7ED),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "1인 가구 주거공간 정리 대행 서비스",
                    style: TextStyle(
                      fontSize: 15,
                      color: _houseServiceTypeClean ? Colors.white : const Color(0xFF686C73),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  _houseServiceTypeConcerting = false;
                  _houseServiceTypeClean = false;
                  _houseServiceTypeTimeService = true;

                  if (mounted) {
                    setState(() {});
                  }
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: _houseServiceTypeTimeService ? kSelectColor : Colors.white,
                    border: Border.all(
                      color: _houseServiceTypeTimeService ? kSelectColor : const Color(0xFFE4E7ED),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "1인 가구 주거공간 정리 타임 서비스",
                    style: TextStyle(
                      fontSize: 15,
                      color: _houseServiceTypeTimeService ? Colors.white : const Color(0xFF686C73),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const DotTextView(
            textStr: "2룸 기준",
            textSize: 13,
            textColor: Color(0xFF686C73),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const DotTextView(
            textStr: "보고서 2차 방문일 이후 영업일 기준), 프레젠테이션 기준\n30 슬라이드 내외 (이미지 포함) 메일로 송부",
            textSize: 13,
            textColor: Color(0xFF686C73),
          ),
        ),
      ],
    );
  }
}
