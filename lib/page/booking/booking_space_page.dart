import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/dot_text_view.dart';
import 'package:uplatform/components/input_right_arrow_two_value.dart';
import 'package:uplatform/components/input_title.dart';
import 'package:uplatform/components/text_paragraph.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/user_model.dart';
import 'package:uplatform/page/common/find_address_page.dart';
import 'package:uplatform/page/common/search_address_page.dart';
import 'package:uplatform/services/login_service.dart';
import 'package:universal_platform/universal_platform.dart';

import 'booking_space_step01_page.dart';

class BookingSpacePage extends StatefulWidget {
  const BookingSpacePage({Key? key}) : super(key: key);

  static const routeName = '/BookingSpacePage';

  @override
  _BookingSpacePageState createState() => _BookingSpacePageState();
}

class _BookingSpacePageState extends State<BookingSpacePage> {
  final ScrollController _scrollController = ScrollController();

  String _address = "";
  String _addAddress = "";

  // 음식점 위생공간
  bool _isCleanSpaceShop = true;
  // 주거공간
  bool _isCleanSpaceHouse = false;

  // 음식점 위생공간 - 공간정리 대행서비스 (부분)
  bool _isShopServiceTypePart = false;
  // 음식점 위생공간 - 공간정리 대행서비스 (전체)
  bool _isShopServiceTypeTotal = false;

  // 주거공간 - 공간정리 컨설팅
  bool _isHouseCleanConcerting = false;
  // 주거공간 - 공간정리 대행서비스
  bool _isHouseCleanService = false;

  bool _isShowProductDetail = false;

  AreaInfo? _loginUserAreaInfo;

  @override
  void initState() {
    super.initState();

    loadUserInfo();
  }

  void loadUserInfo() {
    _loginUserAreaInfo = LoginService().getUserAreaInfo();

    if (_loginUserAreaInfo != null) {
      _address = _loginUserAreaInfo?.address ?? "";
      _addAddress = _loginUserAreaInfo?.addAddress ?? "";
    }
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
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
                titleText: "공간정리 예약",
                cellHeight: 32,
                fontSize: 24,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 20),
              InputRightArrowTwoValue(
                key: GlobalKey(debugLabel: "ArrowAddress"),
                title: "주소",
                value: _address,
                value2nd: _addAddress,
                hintText: "선택하세요.",
                isRequired: true,
                onPressed: () async {
                  if (UniversalPlatform.isWeb) {
                    Map<String, dynamic>? searchResult = {};
                    searchResult = await Get.toNamed(FindAddressPage.routeName);

                    if (searchResult != null) {
                      _address = searchResult['address'] ?? "";
                      _addAddress = searchResult['add_address'] ?? "";

                      if (mounted) {
                        setState(() {});
                      }
                    }
                  } else {
                    dynamic searchResult = await Get.toNamed(SearchAddressPage.routeName);

                    if (searchResult != null && searchResult.isNotEmpty) {
                      List<String> addresses = searchResult.split(";");

                      _address = addresses[0];

                      if (addresses.length > 1) {
                        _addAddress = addresses[1];
                      }

                      if (mounted) {
                        setState(() {});
                      }
                    }
                  }
                },
              ),
              const SizedBox(height: 19),
              kHorizontalLine,
              const SizedBox(height: 32),
              const InputTitle(
                title: "정리 공간",
                isRequired: true,
                textFontSize: 15,
                padding: EdgeInsets.symmetric(horizontal: 20),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _isCleanSpaceShop = true;
                          _isCleanSpaceHouse = false;

                          _isHouseCleanConcerting = false;
                          _isHouseCleanService = false;

                          if (mounted) {
                            setState(() {});
                          }
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: _isCleanSpaceShop ? kSelectColor : Colors.white,
                            border: Border.all(
                              color: _isCleanSpaceShop ? kSelectColor : const Color(0xFFE4E7ED),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "음식점 위생공간",
                            style: TextStyle(
                              fontSize: 15,
                              color: _isCleanSpaceShop ? Colors.white : const Color(0xFF686C73),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _isCleanSpaceShop = false;
                          _isCleanSpaceHouse = true;

                          _isShopServiceTypePart = false;
                          _isShopServiceTypeTotal = false;

                          if (mounted) {
                            setState(() {});
                          }
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: _isCleanSpaceHouse ? kSelectColor : Colors.white,
                            border: Border.all(
                              color: _isCleanSpaceHouse ? kSelectColor : const Color(0xFFE4E7ED),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "주거공간",
                            style: TextStyle(
                              fontSize: 15,
                              color: _isCleanSpaceHouse ? Colors.white : const Color(0xFF686C73),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              if (_isCleanSpaceShop) buildShopServiceType(),
              if (_isCleanSpaceHouse) buildHouseServiceType(),
              Container(
                height: 12,
                color: const Color(0xFFF1F2F4),
              ),
              const SizedBox(height: 32),
              const TextTitle(
                titleText: "주거공간",
                cellHeight: 26,
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              const TextTitle(
                titleText: "공간정리 대행 서비스 부분/전체",
                cellHeight: 26,
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 24),
              Image.asset(
                "assets/images/booking_space_banner.png",
                width: screenWidth,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(height: 40),
              const TextTitle(
                titleText: "공간정리로 만드는 빛나는 일상",
                cellHeight: 26,
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 12),
              const TextParagraph(
                  paraText:
                  "업무 공간과 주거 공간의 변화,\n당신의 하루와 일상의 변화를 의미합니다."),
              const SizedBox(height: 32),
              Image.asset(
                "assets/images/booking_space_image.png",
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
                    if (_address.isEmpty && _addAddress.isEmpty) {
                      _scrollController.animateTo(_scrollController.position.minScrollExtent,
                          duration: const Duration(milliseconds: 200), curve: Curves.easeOut);

                      Get.snackbar('주소 미입력', "주소를 입력하세요.",
                          snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                      return;
                    }

                    if (_isCleanSpaceShop) {
                      if (!_isShopServiceTypePart && !_isShopServiceTypeTotal) {
                        _scrollController.animateTo(_scrollController.position.minScrollExtent,
                            duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
                        Get.snackbar('서비스 종류 미선택', "서비스 종류를 선택하세요",
                            snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                        return;
                      }
                    }

                    if (_isCleanSpaceHouse) {
                      if (!_isHouseCleanConcerting && !_isHouseCleanService) {
                        _scrollController.animateTo(_scrollController.position.minScrollExtent,
                            duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
                        Get.snackbar('서비스 종류 미선택', "서비스 종류를 선택하세요",
                            snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                        return;
                      }
                    }

                    Map<String, dynamic> bookingParams = {};

                    bookingParams['address'] = _address;
                    bookingParams['addaddress'] = _addAddress;

                    bookingParams['_isCleanSpaceShop'] = _isCleanSpaceShop;
                    bookingParams['_isCleanSpaceHouse'] = _isCleanSpaceHouse;

                    bookingParams['_isShopServiceTypePart'] = _isShopServiceTypePart;
                    bookingParams['_isShopServiceTypeTotal'] = _isShopServiceTypeTotal;

                    bookingParams['_isHouseCleanConcerting'] = _isHouseCleanConcerting;
                    bookingParams['_isHouseCleanService'] = _isHouseCleanService;

                    Get.toNamed(BookingSpaceStep01Page.routeName, arguments: bookingParams);
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
                titleText: "공간정리 컨설팅",
                cellHeight: 22,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontColor: Colors.black,
              ),
              const SizedBox(height: 16),
              buildProductItem("방문 2회", "1차 방문 3시간, 2차 방문 8시간", "", "550,000원"),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const DotTextView(
                  textStr: "32평 이하 기준",
                  textSize: 12,
                  textColor: Color(0xFF686C73),
                ),
              ),
              const SizedBox(height: 12),
              buildProductItem("공간 컨설팅 보고서 제공", "", "", "550,000원"),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const DotTextView(
                  textStr: "보고서는 전체 서비스 2차 방문일 이후, 영업일 기준 7일이내 제공",
                  textSize: 12,
                  textColor: Color(0xFF686C73),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const DotTextView(
                  textStr: "프레젠테이션 30 슬라이드 내외 (이미지 포함) 메일로 송부해 드립니다.",
                  textSize: 12,
                  textColor: Color(0xFF686C73),
                ),
              ),
              const SizedBox(height: 40),
              const TextTitle(
                titleText: "공간정리 대행서비스",
                cellHeight: 22,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontColor: Colors.black,
              ),
              const SizedBox(height: 16),
              buildProductItem("방문 2회", "1차 방문 3시간, 2차 방문 8시간", "", "2,420,000원"),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const DotTextView(
                  textStr: "32평 이하 기준",
                  textSize: 12,
                  textColor: Color(0xFF686C73),
                ),
              ),
              const SizedBox(height: 40),
              const TextTitle(
                titleText: "부가 서비스",
                cellHeight: 22,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontColor: Colors.black,
              ),
              const SizedBox(height: 16),
              buildProductItem("수납용품 큐레이션 서비스", "", "공간정리 대행서비스 이용시 0원", "220,000원"),
              const SizedBox(height: 12),
              buildProductItem("수납용품 정보 제공", "", "", "110,000원"),
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
        buildParagraph("서비스 받을 방문 주소를 등록합니다.", title: "1. "),
        const SizedBox(height: 8),
        buildParagraph("서비스 받을 유형과 부가 서비스를 선택합니다.", title: "2. "),
        const SizedBox(height: 8),
        buildParagraph("서비스 방문 날짜와 시간을 선택 후 예약을 완료합니다.", title: "3. "),
        const SizedBox(height: 32),
        const TextTitle(
          titleText: "예약취소 및 환불안내",
          cellHeight: 18,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          fontColor: Colors.black,
        ),
        const SizedBox(height: 8),
        buildParagraph("서비스 신청 후 방문 D-3일전까지 취소 가능하며 100% 환불", title: "1. "),
        const SizedBox(height: 8),
        buildParagraph("프로필 > 예약내역리스트에서 취소 가능", title: "2. "),
        const SizedBox(height: 8),
        buildParagraph("서비스 방문 D-2, D-1 취소 시 (고객센터 문의 후 취소 가능)\n결제 금액의 50% 환불", title: "3. "),
        const SizedBox(height: 8),
        buildParagraph("서비스 방문 당일 취소는 불가", title: "4. "),
        const SizedBox(height: 32),
        const TextTitle(
          titleText: "서비스 이용 시간",
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
                "월 ~ 금",
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
                "오전 9시 ~ 오후 8시(평일)",
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
                "주말",
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
                "오전 9시 ~ 오후 6시(공휴일 포함)",
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

  Widget buildShopServiceType() {
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
                  _isShopServiceTypePart = true;
                  _isShopServiceTypeTotal = false;

                  if (mounted) {
                    setState(() {});
                  }
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: _isShopServiceTypePart ? kSelectColor : Colors.white,
                    border: Border.all(
                      color: _isShopServiceTypePart ? kSelectColor : const Color(0xFFE4E7ED),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "공간정리 대행서비스 (부분)",
                    style: TextStyle(
                      fontSize: 15,
                      color: _isShopServiceTypePart ? Colors.white : const Color(0xFF686C73),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  _isShopServiceTypePart = false;
                  _isShopServiceTypeTotal = true;

                  if (mounted) {
                    setState(() {});
                  }
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: _isShopServiceTypeTotal ? kSelectColor : Colors.white,
                    border: Border.all(
                      color: _isShopServiceTypeTotal ? kSelectColor : const Color(0xFFE4E7ED),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "공간정리 대행서비스 (전체)",
                    style: TextStyle(
                      fontSize: 15,
                      color: _isShopServiceTypeTotal ? Colors.white : const Color(0xFF686C73),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
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
                  _isHouseCleanConcerting = true;
                  _isHouseCleanService = false;

                  if (mounted) {
                    setState(() {});
                  }
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: _isHouseCleanConcerting ? kSelectColor : Colors.white,
                    border: Border.all(
                      color: _isHouseCleanConcerting ? kSelectColor : const Color(0xFFE4E7ED),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "공간정리 컨설팅",
                    style: TextStyle(
                      fontSize: 15,
                      color: _isHouseCleanConcerting ? Colors.white : const Color(0xFF686C73),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  _isHouseCleanConcerting = false;
                  _isHouseCleanService = true;

                  if (mounted) {
                    setState(() {});
                  }
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: _isHouseCleanService ? kSelectColor : Colors.white,
                    border: Border.all(
                      color: _isHouseCleanService ? kSelectColor : const Color(0xFFE4E7ED),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "공간정리 대행서비스",
                    style: TextStyle(
                      fontSize: 15,
                      color: _isHouseCleanService ? Colors.white : const Color(0xFF686C73),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
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
          if (addText.isNotEmpty) const SizedBox(height: 12),
          if (addText.isNotEmpty)
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                addText,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.0,
                  color: Color(0xFF686C73),
                  fontWeight: FontWeight.w400,
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
}
