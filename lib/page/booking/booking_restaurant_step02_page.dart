import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/input_right_arrow.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/utils/utils.dart';
import 'package:universal_platform/universal_platform.dart';

import 'booking_payment_page.dart';

class BookingRestaurantStep02Page extends StatefulWidget {
  const BookingRestaurantStep02Page({Key? key}) : super(key: key);

  static const routeName = '/BookingRestaurantStep02Page';

  @override
  _BookingRestaurantStep02PageState createState() => _BookingRestaurantStep02PageState();
}

class _BookingRestaurantStep02PageState extends State<BookingRestaurantStep02Page> {
  final TextEditingController _phoneNumberEditController = TextEditingController();
  final FocusNode _phoneNumberFocusNode = FocusNode();

  final TextEditingController _requestEditController = TextEditingController();
  final FocusNode _requestFocusNode = FocusNode();

  final ScrollController _scrollController = ScrollController();

  final _formKey = GlobalKey<FormState>(debugLabel: 'BookingRestaurantStep02Page');

  String _serviceDate = "";

  bool _visitTime9to10AM = false;
  bool _visitTime1to2PM = false;
  bool _visitTime2to3PM = false;
  bool _visitTime3to4PM = false;
  bool _visitTimeConference = false;

  Map<String, dynamic> _bookingParams = {};

  @override
  void initState() {
    super.initState();

    _bookingParams = Get.arguments;
  }

  @override
  void dispose() {
    super.dispose();

    _phoneNumberEditController.dispose();
    _phoneNumberFocusNode.dispose();

    _requestEditController.dispose();
    _requestFocusNode.dispose();

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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 16),
                const TextTitle(
                  titleText: "음식점 위생정리 예약",
                  cellHeight: 32,
                  fontSize: 24,
                  fontColor: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 19),
                InputRightArrow(
                  title: "서비스 날짜",
                  value: _serviceDate,
                  hintText: "선택하세요.",
                  isRequired: true,
                  onPressed: () async {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    currentFocus.unfocus();

                    DateTime today = DateTime.now();
                    DateTime oneYearLater = DateTime(today.year + 1, today.month, today.day);

                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: oneYearLater,
                      helpText: "서비스 날짜를 선택하세요",
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.dark().copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: kMainColor,
                            ),
                            dialogBackgroundColor: const Color(0xFFEFEFEF),
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (picked != null) {
                      _serviceDate = picked.toLocal().toString().substring(0, 10);

                      if (mounted) {
                        setState(() {});
                      }
                    }
                  },
                ),
                const SizedBox(height: 32),
                kHorizontalLine,
                const SizedBox(height: 32),
                Container(
                  height: 20,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 1),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                "방문 시간",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF686C73),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 2),
                          Container(
                            width: 4,
                            height: 4,
                            margin: const EdgeInsets.only(left: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF10000),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _visitTime9to10AM = true;
                            _visitTime1to2PM = false;
                            _visitTime2to3PM = false;
                            _visitTime3to4PM = false;
                            _visitTimeConference = false;

                            if (mounted) {
                              setState(() {});
                            }
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: _visitTime9to10AM ? kSelectColor : Colors.white,
                              border: Border.all(
                                color: _visitTime9to10AM ? kSelectColor : const Color(0xFFE4E7ED),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "오전 9시 - 10시",
                              style: TextStyle(
                                fontSize: 15,
                                color: _visitTime9to10AM ? Colors.white : Colors.black,
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
                            _visitTime9to10AM = false;
                            _visitTime1to2PM = true;
                            _visitTime2to3PM = false;
                            _visitTime3to4PM = false;
                            _visitTimeConference = false;

                            if (mounted) {
                              setState(() {});
                            }
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: _visitTime1to2PM ? kSelectColor : Colors.white,
                              border: Border.all(
                                color: _visitTime1to2PM ? kSelectColor : const Color(0xFFE4E7ED),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "오후 1시 - 2시",
                              style: TextStyle(
                                fontSize: 15,
                                color: _visitTime1to2PM ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _visitTime9to10AM = false;
                            _visitTime1to2PM = false;
                            _visitTime2to3PM = true;
                            _visitTime3to4PM = false;
                            _visitTimeConference = false;

                            if (mounted) {
                              setState(() {});
                            }
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: _visitTime2to3PM ? kSelectColor : Colors.white,
                              border: Border.all(
                                color: _visitTime2to3PM ? kSelectColor : const Color(0xFFE4E7ED),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "오후 2시 - 3시",
                              style: TextStyle(
                                fontSize: 15,
                                color: _visitTime2to3PM ? Colors.white : Colors.black,
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
                            _visitTime9to10AM = false;
                            _visitTime1to2PM = false;
                            _visitTime2to3PM = false;
                            _visitTime3to4PM = true;
                            _visitTimeConference = false;

                            if (mounted) {
                              setState(() {});
                            }
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: _visitTime3to4PM ? kSelectColor : Colors.white,
                              border: Border.all(
                                color: _visitTime3to4PM ? kSelectColor : const Color(0xFFE4E7ED),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "오후 3시 - 4시",
                              style: TextStyle(
                                fontSize: 15,
                                color: _visitTime3to4PM ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _visitTime9to10AM = false;
                            _visitTime1to2PM = false;
                            _visitTime2to3PM = false;
                            _visitTime3to4PM = false;
                            _visitTimeConference = true;

                            if (mounted) {
                              setState(() {});
                            }
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: _visitTimeConference ? kSelectColor : Colors.white,
                              border: Border.all(
                                color: _visitTimeConference ? kSelectColor : const Color(0xFFE4E7ED),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "협의",
                              style: TextStyle(
                                fontSize: 15,
                                color: _visitTimeConference ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  color: const Color(0xFFF5F6F8),
                ),
                const SizedBox(height: 22),
                Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 44,
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "상담 가능한 전화번호",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF686C73),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 14),
                          Container(
                            width: 4,
                            height: 4,
                            margin: const EdgeInsets.only(left: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF10000),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topRight,
                          child: TextFormField(
                            controller: _phoneNumberEditController,
                            focusNode: _phoneNumberFocusNode,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
                              border: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              hintText: "번호 입력",
                              hintStyle: TextStyle(
                                color: Color(0xFFCDD0D3),
                                fontSize: 15.0,
                                height: 1.2,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            textAlign: TextAlign.end,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              height: 1.2,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  color: const Color(0xFFF5F6F8),
                ),
                const SizedBox(height: 32),
                Container(
                  height: 84,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: _requestEditController,
                    focusNode: _requestFocusNode,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      hintText: "요청사항\n(방문하시는 정리 전문가 분께 당부하실 말씀을 입력해 주세요)",
                      hintStyle: TextStyle(
                        color: Color(0xFFCDD0D3),
                        fontSize: 15.0,
                        height: 1.8,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    maxLines: 50,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      height: 1.2,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BorderRoundedButton(
                    text: "다음",
                    buttonColor: kMainColor,
                    onPressed: () async {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      currentFocus.unfocus();

                      if (_serviceDate.isEmpty) {
                        Get.snackbar('서비스 날짜', "서비스 날짜를 선택하세요",
                            snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                        return;
                      }

                      if (!_visitTime9to10AM &&
                          !_visitTime1to2PM &&
                          !_visitTime2to3PM &&
                          !_visitTime3to4PM &&
                          !_visitTimeConference) {
                        Get.snackbar('방문 시간', "방문 시간을 선택하세요",
                            snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                        return;
                      }

                      if (_phoneNumberEditController.text.isEmpty) {
                        Get.snackbar('전화 번호', "상담 가능한 전화번호를 입력하세요.",
                            snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                        return;
                      }

                      Map<String, dynamic> bookingParams = {};
                      bookingParams['reservation_type'] = "CS";
                      bookingParams['service_addr'] = _bookingParams['service_addr'];

                      bookingParams['service_date'] = _serviceDate;
                      String serviceTime = _visitTime9to10AM
                          ? "오전 9시 - 10시"
                          : _visitTime1to2PM
                              ? "오후 1시 - 2시"
                              : _visitTime2to3PM
                                  ? "오후 2시 - 3시"
                                  : _visitTime3to4PM
                                      ? "오후 3시 - 4시"
                                      : "협의";

                      bookingParams['services'] = _bookingParams['services'];
                      bookingParams['price'] = _bookingParams['price'];

                      bookingParams['service_time'] = serviceTime;
                      bookingParams['phone'] = _phoneNumberEditController.text;
                      bookingParams['memo'] = _requestEditController.text;

                      Map<String, dynamic> summary = {};
                      summary['title'] = "음식점 위생정리";
                      summary['total_price'] = Utils().numberWithComma(_bookingParams['price']) + "원";
                      summary['address'] = _bookingParams['address'];
                      summary['add_address'] = _bookingParams['addaddress'];
                      summary['service_date'] = _serviceDate;
                      summary['service_time'] = serviceTime;
                      summary['phone_number'] = _phoneNumberEditController.text;
                      summary['request_memo'] = _requestEditController.text;
                      summary['selected_items'] = _bookingParams['bookingitems'];

                      Map<String, dynamic> argument = {};
                      argument['booking'] = bookingParams;
                      argument['summary'] = summary;

                      Get.toNamed(BookingPaymentPage.routeName, arguments: argument);
                    },
                  ),
                ),
                const SizedBox(height: 32),
                buildBottomBar,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
