import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/dialogs/cancel_booking_dialog.dart';
import 'package:uplatform/models/common_model.dart';
import 'package:uplatform/models/user_model.dart';
import 'package:uplatform/page/home/home_page.dart';
import 'package:uplatform/services/login_service.dart';
import 'package:uplatform/services/network.dart';

class BookingFinishPage extends StatefulWidget {
  const BookingFinishPage({Key? key}) : super(key: key);

  static const routeName = '/BookingFinishPage';

  @override
  _BookingFinishPageState createState() => _BookingFinishPageState();
}

class _BookingFinishPageState extends State<BookingFinishPage> {
  bool _isLoading = false;

  String? _serviceType = "";
  String? _serviceDateTime = "";
  String? _priceStr = "";
  String? _reservationId = "";

  Map<String, dynamic> _booking = {};
  Map<String, dynamic> _paymentResult = {};

  @override
  void initState() {
    super.initState();

    Map<String, dynamic> argument = Get.arguments;

    _booking = argument['booking'];
    _paymentResult = argument['payment_result'];

    Map<String, String> product = argument['product'];

    _serviceType = product['service_type'];
    _serviceDateTime = product['service_datetime'];
    _priceStr = product['price'];
    _reservationId = product['reservation_id'];

    debugPrint("_paymentResult $_paymentResult");
    storedDatabase();
  }

  Future storedDatabase() async {
    _isLoading = true;

    ReservationResponse? reservationResponse = await Network().reqReservation(_booking);
    if (reservationResponse == null || reservationResponse.status != "200") {
      debugPrint("예약하기 reqReservation() error");
      return;
    }

    Map<String, dynamic> params = {};
    params['reservation_id'] = reservationResponse.insertId;
    params['imp_uid'] = _paymentResult['imp_uid'];
    params['pay_method'] = _paymentResult['pay_method'];
    params['merchant_uid'] = _paymentResult['merchant_uid'];
    params['name'] = _paymentResult['name'];
    params['paid_amount'] = _paymentResult['paid_amount'];
    params['currency'] = _paymentResult['currency'];
    params['pg_provider'] = _paymentResult['pg_provider'];
    params['pg_type'] = _paymentResult['pg_type'];
    params['pg_tid'] = _paymentResult['pg_tid'];
    params['apply_num'] = _paymentResult['apply_num'];
    params['buyer_name'] = _paymentResult['buyer_name'];
    params['buyer_email'] = _paymentResult['buyer_email'];
    params['buyer_tel'] = _paymentResult['buyer_tel'];
    params['buyer_addr'] = _paymentResult['buyer_addr'];
    params['status'] = _paymentResult['status'];
    params['paid_at'] = _paymentResult['paid_at'];
    params['receipt_url'] = _paymentResult['receipt_url'];
    params['cpid'] = _paymentResult['cpid'];
    params['data'] = _paymentResult['data'];
    params['card_name'] = _paymentResult['card_name'];
    params['bank_name'] = _paymentResult['bank_name'];
    params['card_quota'] = _paymentResult['card_quota'];
    params['card_number'] = _paymentResult['card_number'];

    CommonResponse? commonResponse = await Network().reqRegisterPayment(params);
    debugPrint("commonResponse $commonResponse");


    UserInfo? _loginUser = LoginService().getUserInfo();

    params = {};
    params['type'] = "P";
    params['send_date'] = DateTime.now().toString();
    params['target_user'] = _loginUser!.userId ?? "";
    params['content'] = "$_serviceType 서비스 예약이 완료되었습니다.";

    CommonResponse? pushResponse = await Network().reqRegisterPush(params);
    debugPrint("pushResponse $pushResponse");

    _isLoading = false;
    if (mounted) {
      setState(() {});
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
        appBar: const CustomAppBar(iconData: Icons.close),
        body: Column(
          children: [
            Container(
              height: 116,
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/icons_applause_large.png",
                width: 60,
                height: 60,
              ),
            ),
            Container(
              height: 32,
              alignment: Alignment.center,
              child: Text(
                "$_serviceType 신청이",
                style: const TextStyle(
                  fontSize: 24,
                  height: 1.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              height: 32,
              alignment: Alignment.center,
              child: const Text(
                "완료되었습니다",
                style: TextStyle(
                  fontSize: 24,
                  height: 1.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 18,
              alignment: Alignment.center,
              child: const Text(
                "신청을 확인 중에 있습니다.",
                style: TextStyle(
                  fontSize: 13,
                  height: 1.2,
                  color: Color(0xFF898D93),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              height: 18,
              alignment: Alignment.center,
              child: const Text(
                "예약 확정까지는 1시간 정도 소요 될 예정입니다.",
                style: TextStyle(
                  fontSize: 13,
                  height: 1.2,
                  color: Color(0xFF898D93),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              height: 18,
              alignment: Alignment.center,
              child: const Text(
                "확정 시 푸시 알림으로 안내드릴 예정입니다",
                style: TextStyle(
                  fontSize: 13,
                  height: 1.2,
                  color: Color(0xFF898D93),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              height: 18,
              alignment: Alignment.center,
              child: const Text(
                "APP 상단 > 알림에서 확인 가능합니다.",
                style: TextStyle(
                  fontSize: 13,
                  height: 1.2,
                  color: Color(0xFF10A2DC),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Container(
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              color: const Color(0xFFC9CDD4),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Flexible(
                    flex: 120,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "서비스 종류",
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.3,
                          color: Color(0xFF898D93),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 180,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        _serviceType ?? "",
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.3,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            kHorizontalLine,
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Flexible(
                    flex: 120,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "방문 일시",
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.3,
                          color: Color(0xFF898D93),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 180,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        _serviceDateTime ?? "",
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.3,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            kHorizontalLine,
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Flexible(
                    flex: 120,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "결제 금액",
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.3,
                          color: Color(0xFF898D93),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 180,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        _priceStr ?? "",
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.3,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            kHorizontalLine,
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BorderRoundedButton(
                text: "확인",
                buttonColor: kMainColor,
                onPressed: () {
                  if (_isLoading) {
                    return;
                  }

                  Get.offAllNamed(HomePage.routeName);
                },
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BorderRoundedButton(
                text: "예약 취소",
                textColor: Colors.black,
                buttonColor: Colors.white,
                onPressed: () async {
                  if (_isLoading) {
                    return;
                  }

                  String resultStr = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CancelBookingDialog(serviceDate: _serviceDateTime ?? "");
                    },
                    barrierDismissible: false,
                  );

                  debugPrint("resultStr $resultStr");

                  if (resultStr.isEmpty) {
                    return;
                  }

                  Map<String, dynamic> params = {};

                  params['reservation_id'] = _reservationId;
                  params['comment'] = resultStr;
                  CommonResponse result = await Network().reqCancelReservation(params);

                  if (result.status == "200") {
                    UserInfo? _loginUser = LoginService().getUserInfo();

                    params = {};
                    params['type'] = "P";
                    params['send_date'] = DateTime.now().toString();
                    params['target_user'] = _loginUser!.userId ?? "";
                    params['content'] = "$_serviceType 신청을 취소하셨습니다.";

                    CommonResponse? pushResponse = await Network().reqRegisterPush(params);
                    debugPrint("pushResponse $pushResponse");

                    Get.offAllNamed(HomePage.routeName);
                    Get.snackbar('예약 취소', "예약취소 되었습니다.",
                        snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 2000));
                  }
                },
              ),
            ),
            const SizedBox(height: 32),
            buildBottomBar,
          ],
        ),
      ),
    );
  }
}
