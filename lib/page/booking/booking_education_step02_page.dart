import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/dot_text_view.dart';
import 'package:uplatform/components/input_title.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/utils/utils.dart';

import 'booking_payment_page.dart';

class BookingEducationStep02Page extends StatefulWidget {
  const BookingEducationStep02Page({Key? key}) : super(key: key);

  static const routeName = '/BookingEducationStep02Page';

  @override
  _BookingEducationStep02PageState createState() => _BookingEducationStep02PageState();
}

class _BookingEducationStep02PageState extends State<BookingEducationStep02Page> {
  final TextEditingController _phoneNumberEditController = TextEditingController();
  final FocusNode _phoneNumberFocusNode = FocusNode();

  final TextEditingController _requestEditController = TextEditingController();
  final FocusNode _requestFocusNode = FocusNode();

  final ScrollController _scrollController = ScrollController();

  // 교육 요일
  bool _everyMonday = false;
  bool _everyTuesday = false;
  bool _everyWednesday = false;
  bool _everyThursday = false;
  bool _everyFriday = false;
  bool _everySaturday = false;
  bool _everySunday = false;

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
  }

  @override
  Widget build(BuildContext context) {
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
              buildSelectDayOfWeek(),
              kHorizontalLine,
              const SizedBox(height: 32),
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
              kHorizontalLine,
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

                    if (!_everyMonday &&
                        !_everyTuesday &&
                        !_everyWednesday &&
                        !_everyThursday &&
                        !_everyFriday &&
                        !_everySaturday &&
                        !_everySunday) {
                      Get.snackbar('교육요일 미선택', "교육요일을 선택하세요",
                          snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                    }

                    if (_phoneNumberEditController.text.isEmpty) {
                      Get.snackbar('전화 번호', "상담 가능한 전화번호를 입력하세요.",
                          snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                      return;
                    }

                    Map<String, dynamic> bookingParams = {};
                    bookingParams['reservation_type'] = "LC";

                    bookingParams['services'] = _bookingParams['services'];
                    bookingParams['price'] = _bookingParams['price'];

                    bookingParams['phone'] = _phoneNumberEditController.text;
                    bookingParams['memo'] = _requestEditController.text;

                    String dayOfWeek = _everyMonday
                        ? "매주 월요일"
                        : _everyTuesday
                            ? "매주 화요일"
                            : _everyWednesday
                                ? "매주 수요일"
                                : _everyThursday
                                    ? "매주 목요일"
                                    : _everyFriday
                                        ? "매주 금요일"
                                        : _everySaturday
                                            ? "매주 토요일"
                                            : "매주 일요일";

                    bookingParams['learn_day'] = dayOfWeek;

                    Map<String, dynamic> summary = {};

                    summary['title'] = "정리 교육";
                    summary['total_price'] = Utils().numberWithComma(_bookingParams['price']) + "원";
                    summary['service_date'] = dayOfWeek;
                    summary['phone_number'] = _phoneNumberEditController.text;
                    summary['request_memo'] = _requestEditController.text;
                    summary['selected_items'] = _bookingParams['bookingItems'];

                    Map<String, dynamic> argument = {};
                    argument['booking'] = bookingParams;
                    argument['summary'] = summary;

                    Get.offNamed(BookingPaymentPage.routeName, arguments: argument);
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

  Widget buildSelectDayOfWeek() {
    return Column(
      children: [
        const InputTitle(
          title: "교육 요일",
          isRequired: true,
          textFontSize: 15,
          padding: EdgeInsets.symmetric(horizontal: 20),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _everyMonday = true;
                    _everyTuesday = false;
                    _everyWednesday = false;
                    _everyThursday = false;
                    _everyFriday = false;
                    _everySaturday = false;
                    _everySunday = false;

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: _everyMonday ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _everyMonday ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "매주 월요일",
                      style: TextStyle(
                        fontSize: 15,
                        color: _everyMonday ? Colors.white : const Color(0xFF686C73),
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
                    _everyMonday = false;
                    _everyTuesday = true;
                    _everyWednesday = false;
                    _everyThursday = false;
                    _everyFriday = false;
                    _everySaturday = false;
                    _everySunday = false;

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: _everyTuesday ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _everyTuesday ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "매주 화요일",
                      style: TextStyle(
                        fontSize: 15,
                        color: _everyTuesday ? Colors.white : const Color(0xFF686C73),
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
                    _everyMonday = false;
                    _everyTuesday = false;
                    _everyWednesday = true;
                    _everyThursday = false;
                    _everyFriday = false;
                    _everySaturday = false;
                    _everySunday = false;

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: _everyWednesday ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _everyWednesday ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "매주 수요일",
                      style: TextStyle(
                        fontSize: 15,
                        color: _everyWednesday ? Colors.white : const Color(0xFF686C73),
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
                    _everyMonday = false;
                    _everyTuesday = false;
                    _everyWednesday = false;
                    _everyThursday = true;
                    _everyFriday = false;
                    _everySaturday = false;
                    _everySunday = false;

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: _everyThursday ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _everyThursday ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "매주 목요일",
                      style: TextStyle(
                        fontSize: 15,
                        color: _everyThursday ? Colors.white : const Color(0xFF686C73),
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
                    _everyMonday = false;
                    _everyTuesday = false;
                    _everyWednesday = false;
                    _everyThursday = false;
                    _everyFriday = true;
                    _everySaturday = false;
                    _everySunday = false;

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: _everyFriday ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _everyFriday ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "매주 금요일",
                      style: TextStyle(
                        fontSize: 15,
                        color: _everyFriday ? Colors.white : const Color(0xFF686C73),
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
                    _everyMonday = false;
                    _everyTuesday = false;
                    _everyWednesday = false;
                    _everyThursday = false;
                    _everyFriday = false;
                    _everySaturday = true;
                    _everySunday = false;

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: _everySaturday ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _everySaturday ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "매주 토요일",
                      style: TextStyle(
                        fontSize: 15,
                        color: _everySaturday ? Colors.white : const Color(0xFF686C73),
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
                    _everyMonday = false;
                    _everyTuesday = false;
                    _everyWednesday = false;
                    _everyThursday = false;
                    _everyFriday = false;
                    _everySaturday = false;
                    _everySunday = true;

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: _everySunday ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _everySunday ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "매주 일요일",
                      style: TextStyle(
                        fontSize: 15,
                        color: _everySunday ? Colors.white : const Color(0xFF686C73),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(child: Container()),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const DotTextView(
            textStr: "교육 장소는 예약완료 시 카카오(알림톡)으로 안내해 드립니다.",
            textSize: 13,
            textColor: Color(0xFF898D93),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
