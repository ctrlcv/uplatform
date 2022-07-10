import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/input_edit_text_underline.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SearchAddressPage extends StatefulWidget {
  const SearchAddressPage({Key? key}) : super(key: key);

  static const routeName = '/SearchAddressPage';

  @override
  _SearchAddressPageState createState() => _SearchAddressPageState();
}

class _SearchAddressPageState extends State<SearchAddressPage> {
  WebViewController? _webViewController;
  final Completer<WebViewController> _completerController = Completer<WebViewController>();

  final TextEditingController _addressEditController = TextEditingController();
  final FocusNode _addressEditFocus = FocusNode();

  final TextEditingController _addAddressEditController = TextEditingController();
  final FocusNode _addAddressEditFocus = FocusNode();

  bool _isShowWebView = true;

  @override
  void initState() {
    super.initState();

    _isShowWebView = true;
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

    _addressEditController.dispose();
    _addressEditFocus.dispose();

    _addAddressEditController.dispose();
    _addAddressEditFocus.dispose();
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

    _addressEditController.text = address;
    _isShowWebView = false;

    if (mounted) {
      setState(() {});
    }
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
              Container(
                height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "주소를 검색해 주세요.",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        InputEditTextUnderline(
                          editingController: _addressEditController,
                          focusNode: _addressEditFocus,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          title: "주소",
                          hintText: "주소 입력",
                          onSubmitted: (value) {
                            _addAddressEditFocus.requestFocus();
                          },
                          isRequired: false,
                        ),
                        InputEditTextUnderline(
                          editingController: _addAddressEditController,
                          focusNode: _addAddressEditFocus,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          title: "상세주소",
                          hintText: "상세 주소를 입력하세요.",
                          onSubmitted: (value) {},
                        ),
                        Expanded(child: Container()),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: BorderRoundedButton(
                            text: "완료",
                            buttonColor: kMainColor,
                            onPressed: () {
                              Get.back(result: _addressEditController.text + ";" + _addAddressEditController.text);
                            },
                          ),
                        ),
                        const SizedBox(height: 32),
                        buildBottomBar,
                      ],
                    ),
                    if (_isShowWebView)
                      Container(
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
                                initialUrl:
                                    'https://uplatform.s3.ap-northeast-2.amazonaws.com/html/postcode.html',
                                javascriptMode: JavascriptMode.unrestricted,
                                javascriptChannels: <JavascriptChannel>{
                                  handlePostCode(context),
                                },
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
