import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iamport_flutter/model/payment_data.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/booking_model.dart';
import 'package:uplatform/models/request_model.dart';
import 'package:uplatform/models/user_model.dart';
import 'package:uplatform/page/booking/payment_page.dart';
import 'package:uplatform/services/login_service.dart';
import 'package:uplatform/services/service_list.dart';
import 'package:uplatform/utils/utils.dart';

class BookingPaymentPage extends StatefulWidget {
  const BookingPaymentPage({Key? key}) : super(key: key);

  static const routeName = '/BookingPaymentPage';

  @override
  _BookingPaymentPageState createState() => _BookingPaymentPageState();
}

class _BookingPaymentPageState extends State<BookingPaymentPage> {
  final ScrollController _scrollController = ScrollController();

  String? _title;
  String? _totalPrice;
  String? _address;
  String? _addAddress;
  String? _serviceDate;
  String? _serviceTime;
  String? _phoneNumber;
  String? _requestMemo;
  List<BookingItem>? _selectedItems;
  String? _reservationId;

  UserInfo? _userInfo;
  Map<String, dynamic> _bookingInfos = {};

  String _paymentItemDetail = "";

  @override
  void initState() {
    super.initState();

    _userInfo = LoginService().getUserInfo();

    Map<String, dynamic> getParams = Get.arguments;
    _bookingInfos = getParams['booking'];
    Map<String, dynamic> summary = getParams['summary'];

    _title = summary['title'];
    _totalPrice = summary['total_price'];
    _address = summary['address'];
    _addAddress = summary['add_address'];
    _serviceDate = summary['service_date'];
    _serviceTime = summary['service_time'];
    _phoneNumber = summary['phone_number'];
    _requestMemo = summary['request_memo'];
    _selectedItems = summary['selected_items'] as List<BookingItem>?;

    String services = _bookingInfos['services'] ?? "";
    String bookingItem = (services).replaceAll("[", "").replaceAll("]", "");
    List<String> bookingItems = bookingItem.split(",");

    int bookingCount = 0;
    for (int i = 0; i < bookingItems.length; i++) {
      if ((bookingItems[i].trim()).isNotEmpty) {
        bookingCount++;
      }
    }

    ServiceItem? serviceItem = ServiceList().getServiceItem(bookingItems[0]);
    if (serviceItem != null) {
      _paymentItemDetail = "${serviceItem.serviceSubType} (${serviceItem.servicePart}) - ${serviceItem.serviceName}";

      if (bookingCount > 1) {
        _paymentItemDetail += " 외 ${bookingCount - 1}건";
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
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
              TextTitle(
                titleText: "$_title",
                cellHeight: 32,
                fontSize: 24,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              TextTitle(
                titleText: "$_totalPrice을 결제합니다.",
                cellHeight: 32,
                fontSize: 24,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 4),
              const TextTitle(
                titleText: "(VAT 포함)",
                cellHeight: 18,
                fontSize: 15,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  physics: const ClampingScrollPhysics(),
                  itemCount: _selectedItems!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildBookingItem(
                      _selectedItems![index],
                      index,
                      (index == _selectedItems!.length - 1),
                    );
                  },
                ),
              ),
              const SizedBox(height: 40),
              Container(
                height: 22,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "예약정보",
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              buildDetailItem(),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: const Color(0xFFE4E7ED),
                    width: 1,
                  ),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  children: [
                    buildDisplayRow2("상호명", "(주)유플랫폼"),
                    const SizedBox(height: 8),
                    buildDisplayRow2("사업자 등록번호", "526-87-02331"),
                    const SizedBox(height: 8),
                    buildDisplayRow2("대표자명", "유정민"),
                    const SizedBox(height: 8),
                    buildDisplayRow2("사업장 주소지", "서울 특별시 구로구 디지털로 31길 38-9, 409-16호(구로구 에이스 테크노타워 1차)"),
                    const SizedBox(height: 8),
                    buildDisplayRow2("고객센터 전화번호", "02-865-8506"),
                    const SizedBox(height: 8),
                    buildDisplayRow2("이메일", "u-platform@naver.com"),
                    const SizedBox(height: 8),
                    buildDisplayRow2("통신판매업 신고번호", "2022-서울구로-0472"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BorderRoundedButton(
                  text: "결제하기",
                  buttonColor: kMainColor,
                  onPressed: () {
                    Map<String, dynamic> argument = {};
                    Map<String, String> product = {};

                    product['service_type'] = _title!;
                    product['service_datetime'] = (_title != null && !_title!.contains("정리 교육"))
                        ? Utils().getDisplayDateTime(_serviceDate!, _serviceTime!)
                        : _serviceDate!;
                    product['price'] = _totalPrice!;

                    PaymentData data = PaymentData(
                      pg: "nice",
                      payMethod: "card",
                      escrow: false,
                      name: _paymentItemDetail,
                      amount: int.parse(_totalPrice!.replaceAll(",", "").replaceAll("원", "")),
                      merchantUid: "mid_${DateTime.now().millisecondsSinceEpoch}",
                      buyerName: _userInfo!.name,
                      buyerTel: _userInfo!.phoneNumber ?? "",
                      buyerEmail: _userInfo!.email,
                      appScheme: 'shinyo',
                      niceMobileV2: true,
                    );

                    argument['booking'] = _bookingInfos;
                    argument['product'] = product;
                    argument['payment'] = data;

                    Get.offNamed(PaymentPage.routeName, arguments: argument);
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

  Widget buildDetailItem() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          if (_title != null && !_title!.contains("정리 교육")) buildDisplayRow("주소", "$_address $_addAddress"),
          if (_title != null && !_title!.contains("정리 교육")) const SizedBox(height: 16),
          if (_title != null && !_title!.contains("정리 교육"))
            buildDisplayRow("일시", Utils().getDisplayDateTime(_serviceDate!, _serviceTime!))
          else
            buildDisplayRow("교육요일", _serviceDate!),
          const SizedBox(height: 16),
          buildDisplayRow("전화번호", _phoneNumber!),
          if (_requestMemo!.isNotEmpty) const SizedBox(height: 16),
          if (_requestMemo!.isNotEmpty) buildDisplayRow("요청사항", _requestMemo!),
        ],
      ),
    );
  }

  Widget buildBookingItem(BookingItem item, int index, bool isLastItem) {
    bool showItemType = false;

    if (index == 0) {
      showItemType = true;
    } else {
      BookingItem beforeItem = _selectedItems![index - 1];
      showItemType = (item.type != beforeItem.type);
    }

    return SizedBox(
      child: Column(
        children: [
          if (showItemType && index != 0) const SizedBox(height: 4),
          if (showItemType && index != 0) Container(height: 1, color: const Color(0xFFE4E7ED)),
          if (showItemType && index != 0) const SizedBox(height: 4),
          SizedBox(height: (index == 0) ? 20 : 16),
          if (showItemType)
            Container(
              height: 16,
              alignment: Alignment.centerLeft,
              child: Text(
                item.type ?? "",
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.0,
                  color: Color(0xFF10A2DC),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          if (showItemType) const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title ?? "",
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    if (item.detail!.isNotEmpty) const SizedBox(height: 4),
                    if (item.detail!.isNotEmpty)
                      Text(
                        item.detail!,
                        style: const TextStyle(
                          fontSize: 12,
                          height: 1.0,
                          color: Color(0xFF898D93),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  Utils().numberWithComma(item.price!) + "원",
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isLastItem ? 20 : 16),
        ],
      ),
    );
  }

  Container buildDisplayRow(String title, String value) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 90,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  color: Color(0xFF898D93),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 270,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildDisplayRow2(String title, String value) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 120,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.2,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            flex: 230,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.2,
                  color: Color(0xFF898D93),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
