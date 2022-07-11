import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:iamport_flutter/iamport_payment.dart';
import 'package:iamport_flutter/model/payment_data.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/dialogs/ask_dialog.dart';
import 'package:uplatform/page/booking/booking_finish_page.dart';
import 'package:webviewx/webviewx.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  static const routeName = '/PaymentPage';

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Map<String, dynamic> _booking = {};
  Map<String, String> _product = {};
  PaymentData? _paymentData;

  final Completer<WebViewXController> _completerController = Completer<WebViewXController>();
  late WebViewXController _webViewController;
  String? _loadedHtml;

  @override
  void initState() {
    super.initState();

    Map<String, dynamic> argument = Get.arguments;
    _booking = argument['booking'];
    _product = argument['product'];
    _paymentData = argument['payment'];

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (UniversalPlatform.isWeb) {
        _loadedHtml = await loadHtml();
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String> loadHtml() async {
    return await rootBundle.loadString("assets/html/iamport_payment.html");
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    debugPrint("_onBackPressed()");

    String resultStr = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AskDialog(title: "결재취소", contents: "결재를 취소하시겠습니까?");
      },
      barrierDismissible: false,
    );

    if (resultStr == "YES") {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    if (UniversalPlatform.isWeb) {
      if (screenWidth > 800) {
        screenWidth = 800;
      }
    }

    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: (!UniversalPlatform.isWeb)
          ? IamportPayment(
              appBar: CustomAppBar(
                iconData: Icons.close,
                onClosePressed: () async {
                  String resultStr = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AskDialog(title: "결재취소", contents: "결재를 취소하시겠습니까?");
                    },
                    barrierDismissible: false,
                  );

                  if (resultStr == "YES") {
                    Get.back();
                  }
                },
              ),
              initialChild: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/title.png',
                        width: 200,
                        fit: BoxFit.fitWidth,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '잠시만 기다려주세요...',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ),
              userCode: "imp54637818",
              data: _paymentData!,
              callback: (Map<String, String> result) {
                Map<String, dynamic> argument = {};
                argument['booking'] = _booking;
                argument['product'] = _product;
                argument['payment_result'] = result;

                Get.offNamed(BookingFinishPage.routeName, arguments: argument);
              },
            )
          : Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: (_loadedHtml == null || _loadedHtml!.isEmpty)
                  ? Container()
                  : WebViewX(
                      width: screenWidth - 60,
                      height: screenHeight - 200,
                      onWebViewCreated: (WebViewXController webViewController) {
                        _completerController.future.then((value) => _webViewController = value);
                        _completerController.complete(webViewController);
                      },
                      onPageFinished: (src) async {
                        debugPrint("onPageFinished");
                        try {
                          await _webViewController.callJsMethod(
                            'onClickPayment',
                            [
                              _paymentData!.name,
                              _paymentData!.buyerName,
                              _paymentData!.buyerEmail,
                              _paymentData!.buyerTel,
                              _paymentData!.amount,
                            ],
                          );
                        } catch (e) {
                          debugPrint("onPageFinished() Exception $e");
                        }
                      },
                      navigationDelegate: (navigation) {
                        debugPrint(navigation.content.sourceType.toString());
                        return NavigationDecision.prevent;
                      },
                      initialContent: _loadedHtml ?? "",
                      // initialContent: 'https://uplatform.s3.ap-northeast-2.amazonaws.com/html/postcode.html',
                      initialSourceType: SourceType.html,
                      javascriptMode: JavascriptMode.unrestricted,
                      dartCallBacks: {
                        DartCallback(
                          name: 'DartCallbackPayment',
                          callBack: (msg) {
                            debugPrint("DartCallbackPayment() $msg");
                            final result = json.decode(msg);

                            if (result['success'] == false) {
                              // cancelPayment();
                              Get.back();
                              return;
                            }

                            Map<String, dynamic> argument = {};
                            argument['booking'] = _booking;
                            argument['product'] = _product;
                            argument['payment_result'] = result;

                            Get.offNamed(BookingFinishPage.routeName, arguments: argument);
                          },
                        )
                      },
                    ),
            ),
    );
  }
}
