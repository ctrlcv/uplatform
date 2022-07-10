import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AddressSearchPage extends StatefulWidget {
  const AddressSearchPage({Key? key}) : super(key: key);

  static const routeName = '/AddressSearchPage';

  @override
  _AddressSearchPageState createState() => _AddressSearchPageState();
}

class _AddressSearchPageState extends State<AddressSearchPage> {
  WebViewController? _webViewController;
  final Completer<WebViewController> _completerController = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();

    if (UniversalPlatform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    // else if (UniversalPlatform.isWeb) {
    //   WebView.platform = WebWebViewPlatform();
    // }
  }

  @override
  void dispose() {
    super.dispose();
  }

  JavascriptChannel handlePostCode(BuildContext context) {
    return JavascriptChannel(
        name: 'Bridge',
        onMessageReceived: (JavascriptMessage message) {
          Map<String, dynamic> result = jsonDecode(message.message);
          searchAndMove(result);
        });
  }

  void searchAndMove(Map<String, dynamic> result) {
    String address = result.containsKey("roadAddress") ? result['roadAddress'] : result['address'];

    debugPrint("searchAndMove(): $result");

    if (address.isNotEmpty) {
      address = result['address'];
    } else {
      address = result['jibunAddress'];
    }

    String buildingName = result['buildingName'];
    if (buildingName.isEmpty) {
      var components = address.split(" ");
      var lastPrevious = components[components.length - 2];
      buildingName = "$lastPrevious ${components.last}";
    }

    if (buildingName.isNotEmpty && !address.contains(buildingName)) {
      address = address + " " + buildingName;
    }

    Get.back(result: address);
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    if (await _webViewController!.canGoBack()) {
      _webViewController!.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(iconData: Icons.close),
          body: Column(
            children: [
              const SizedBox(height: 12),
              const TextTitle(
                titleText: "주소를 검색해 주세요.",
                cellHeight: 32,
                fontSize: 24,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints viewportConstraints) {
                      return WillPopScope(
                        onWillPop: () => _onBackPressed(context),
                        child: WebView(
                          onWebViewCreated: (WebViewController webViewController) {
                            _completerController.future.then((value) => _webViewController = value);
                            _completerController.complete(webViewController);
                          },
                          initialUrl: 'https://uplatform.s3.ap-northeast-2.amazonaws.com/html/postcode.html',
                          javascriptMode: JavascriptMode.unrestricted,
                          javascriptChannels: <JavascriptChannel>{
                            handlePostCode(context),
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
