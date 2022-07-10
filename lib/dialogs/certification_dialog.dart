import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:uplatform/constants/constants.dart';
import 'package:webviewx/webviewx.dart';
import 'package:get/get.dart';

class CertificationDialog extends StatefulWidget {
  const CertificationDialog({Key? key, required this.phoneNumber}) : super(key: key);

  final String phoneNumber;

  @override
  _CertificationDialogState createState() => _CertificationDialogState();
}

class _CertificationDialogState extends State<CertificationDialog> {
  WebViewXController? _webViewController;
  final Completer<WebViewXController> _completerController = Completer<WebViewXController>();
  String? _loadedHtml;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      _loadedHtml = await loadHtml();
      if (mounted) {
        setState(() {});
      }
    });
  }

  Future<String> loadHtml() async {
    return await rootBundle.loadString("assets/html/iamport_cert.html");
  }

  @override
  void dispose() {
    _webViewController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: (_loadedHtml == null || _loadedHtml!.isEmpty)
          ? Container()
          : Stack(
              children: [
                WebViewX(
                  width: 410,
                  height: 670,
                  onWebViewCreated: (WebViewXController webViewController) {
                    _completerController.future.then((value) => _webViewController = value);
                    _completerController.complete(webViewController);
                  },
                  onPageFinished: (src) async {
                    debugPrint("onPageFinished");
                    try {
                      await _webViewController!.callJsMethod('onClickCertification', [widget.phoneNumber]);
                    } catch (e) {
                      debugPrint("onPageFinished() Exception $e");
                    }
                  },
                  initialContent: _loadedHtml ?? "",
                  initialSourceType: SourceType.html,
                  javascriptMode: JavascriptMode.unrestricted,
                  dartCallBacks: {
                    DartCallback(
                      name: 'DartCallbackCertification',
                      callBack: (msg) {
                        debugPrint("DartCallbackCertification() $msg");
                        Get.back(result: msg);
                      },
                    )
                  },
                ),
                Container(
                  width: 410,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: kMainColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(4),
                      topLeft: Radius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
