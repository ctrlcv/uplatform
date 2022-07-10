import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/input_edit_text_underline.dart';
import 'package:uplatform/components/text_paragraph.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/address_model.dart';
import 'package:uplatform/services/network.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:get/get.dart';

class FindAddressPage extends StatefulWidget {
  const FindAddressPage({Key? key}) : super(key: key);

  static const routeName = '/FindAddressPage';

  @override
  _FindAddressPageState createState() => _FindAddressPageState();
}

class _FindAddressPageState extends State<FindAddressPage> {
  final TextEditingController _addressEditController = TextEditingController();
  final FocusNode _addressEditFocus = FocusNode();

  final TextEditingController _addAddressEditController = TextEditingController();
  final FocusNode _addAddressEditFocus = FocusNode();

  final ScrollController _scrollController = ScrollController();

  bool _isLoading = false;
  bool _noItem = false;

  int _totalPage = 0;
  int _currentPage = 1;
  String _currentKeyWord = "";

  List<Juso> _resultList = [];

  bool _isAddressInputMode = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _addressEditController.dispose();
    _addressEditFocus.dispose();

    _addAddressEditController.dispose();
    _addAddressEditFocus.dispose();

    _scrollController.dispose();

    super.dispose();
  }

  Future queryAddressSearch() async {
    _isLoading = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};

    // params["query"] = _addressEditController.text;
    // params["analyze_type"] = "similar";
    // params["page"] = 1.toString();
    // params["size"] = 5.toString();

    if (_currentKeyWord != _addressEditController.text) {
      _currentPage = 1;
    }

    params["keyword"] = _addressEditController.text;
    params["confmKey"] = "U01TX0FVVEgyMDIyMDIyMTAwNDMxNTExMjI2NDM=";
    params["currentPage"] = _currentPage.toString();
    params["countPerPage"] = "10";
    params["resultType"] = "json";
    params["firstSort"] = "road";

    JusoResult? jusoResult = await Network().reqGetAddress(params);
    _currentKeyWord = _addressEditController.text;

    _resultList = [];
    if (jusoResult == null) {
      _noItem = true;
    } else {
      _currentPage = int.parse(jusoResult.currentPage ?? "0");
      _totalPage = (int.parse(jusoResult.totalCount ?? "0") / int.parse(jusoResult.countPerPage ?? "0")).ceil();

      debugPrint("_currentPage $_currentPage, _totalPage $_totalPage");

      _resultList = jusoResult.resultList ?? [];
      _noItem = false;
    }

    _isLoading = false;

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = (UniversalPlatform.isWeb) ? 800 : MediaQuery.of(context).size.width;

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(iconData: Icons.close),
        body: Column(
          children: [
            const SizedBox(height: 16),
            const TextTitle(
              titleText: "주소를 검색해 주세요.",
              cellHeight: 32,
              fontSize: 24,
              fontColor: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 40),
            Container(
              height: 93,
              width: screenWidth,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  InputEditTextUnderline(
                    editingController: _addressEditController,
                    focusNode: _addressEditFocus,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    title: "주소",
                    hintText: "도로명, 건물명 또는 지번으로 검색",
                    onChanged: (value) {
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    onSubmitted: (value) {
                      debugPrint("onSubmitted() $value");
                      if (_addressEditController.text.isNotEmpty) {
                        queryAddressSearch();
                      }
                    },
                    isRequired: false,
                  ),
                  if (showCancelIcon() && !_isAddressInputMode)
                    Positioned(
                      right: 50,
                      bottom: 42,
                      child: GestureDetector(
                        onTap: () async {
                          _addressEditController.clear();
                          _resultList = [];
                          _isAddressInputMode = false;
                          _currentPage = 1;
                          _totalPage = 0;
                          _currentKeyWord = "";

                          if (mounted) {
                            setState(() {});
                          }
                        },
                        child: Container(
                          width: 28,
                          height: 28,
                          alignment: Alignment.center,
                          child: const Icon(
                            CupertinoIcons.clear_circled_solid,
                            color: Color(0xFF898D93),
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  if (!_isAddressInputMode)
                    Positioned(
                      right: 20,
                      bottom: 42,
                      child: GestureDetector(
                        onTap: () async {
                          queryAddressSearch();
                        },
                        child: Container(
                          width: 28,
                          height: 28,
                          alignment: Alignment.center,
                          child: const Icon(
                            CupertinoIcons.search,
                            color: Color(0xFF898D93),
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Container(
              child: _isAddressInputMode
                  ? buildAddressInputMode()
                  : showResultList()
                      ? Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: _resultList.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == _resultList.length) {
                                return Container(
                                  height: 80,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (_currentPage == 1) {
                                            return;
                                          }

                                          if (_currentPage > 1) {
                                            _currentPage--;
                                          }

                                          queryAddressSearch();
                                          _scrollController.animateTo(-500, duration: const Duration(milliseconds: 10), curve: Curves.easeOut);
                                        },
                                        child: Container(
                                          width: 56,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8.0),
                                            border: Border.all(
                                              color: const Color(0xFFE4E7ED),
                                              width: 1,
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.arrow_back_ios_outlined,
                                            color: Color(0xFF898D93),
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 24),
                                      Text(
                                        _currentPage.toString(),
                                        style: const TextStyle(
                                          fontSize: 15,
                                          height: 1.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        "/" + _totalPage.toString(),
                                        style: const TextStyle(
                                          fontSize: 15,
                                          height: 1.0,
                                          color: Color(0xFF898D93),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(width: 24),
                                      GestureDetector(
                                        onTap: () {
                                          if (_currentPage == _totalPage) {
                                            return;
                                          }

                                          if (_currentPage < _totalPage) {
                                            _currentPage++;
                                          }

                                          queryAddressSearch();
                                          _scrollController.animateTo(-500, duration: const Duration(milliseconds: 10), curve: Curves.easeOut);
                                        },
                                        child: Container(
                                          width: 56,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8.0),
                                            border: Border.all(
                                              color: const Color(0xFFE4E7ED),
                                              width: 1,
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: Color(0xFF898D93),
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              return buildAddressItem(
                                _resultList[index],
                                (index == 0),
                                (index == _resultList.length - 1),
                              );
                            },
                          ),
                        )
                      : buildBeforeSearch(),
            ),
            if (_isAddressInputMode || !showResultList()) Expanded(child: Container()),
            if (_isAddressInputMode)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BorderRoundedButton(
                  text: "완료",
                  buttonColor: kMainColor,
                  onPressed: () async {
                    Map<String, dynamic> params = {};
                    params['address'] = _addressEditController.text;
                    params['add_address'] = _addAddressEditController.text;

                    Get.back(result: params);
                  },
                ),
              ),
            if (_isAddressInputMode) const SizedBox(height: 32),
            if (_isAddressInputMode) buildBottomBar,
          ],
        ),
      ),
    );
  }

  Widget buildAddressInputMode() {
    return Column(
      children: [
        InputEditTextUnderline(
          editingController: _addAddressEditController,
          focusNode: _addAddressEditFocus,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          title: "상세주소",
          hintText: "상세주소를 입력하세요",
          onChanged: (value) {
            if (mounted) {
              setState(() {});
            }
          },
          onSubmitted: (value) {
            //
          },
          isRequired: false,
        ),
      ],
    );
  }

  Widget buildAddressItem(Juso juso, bool isFirstItem, bool isLastItem) {
    String zipCode = juso.zipNo ?? "";
    String addressName = juso.jibunAddress ?? "";
    String roadAddressName = juso.roadAddress ?? "";

    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          if (!isFirstItem) const SizedBox(height: 20),
          if (zipCode.isNotEmpty)
            TextTitle(
              titleText: zipCode,
              fontSize: 15,
              cellHeight: 20,
              fontColor: const Color(0xFF10A2DC),
              fontWeight: FontWeight.w600,
            ),
          if (zipCode.isNotEmpty && roadAddressName.isNotEmpty && roadAddressName.isNotEmpty) const SizedBox(height: 6),
          if (roadAddressName.isNotEmpty && roadAddressName.isNotEmpty)
            GestureDetector(
              onTap: () {
                _addressEditController.text = roadAddressName;
                _isAddressInputMode = true;
                _addAddressEditFocus.requestFocus();

                if (mounted) {
                  setState(() {});
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 20),
                  buildTitleRoadAddress(),
                  const SizedBox(width: 6),
                  Expanded(
                    child: TextParagraph(
                      paraText: roadAddressName,
                      fontSize: 14,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.w400,
                      padding: const EdgeInsets.all(0),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
          if ((zipCode.isNotEmpty || roadAddressName.isNotEmpty) && addressName.isNotEmpty && addressName.isNotEmpty)
            const SizedBox(height: 6),
          if (addressName.isNotEmpty && addressName.isNotEmpty)
            GestureDetector(
              onTap: () {
                _addressEditController.text = addressName;
                _isAddressInputMode = true;
                _addAddressEditFocus.requestFocus();

                if (mounted) {
                  setState(() {});
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 20),
                  buildTitleAddress(),
                  const SizedBox(width: 6),
                  Expanded(
                    child: TextParagraph(
                      paraText: addressName,
                      fontSize: 14,
                      fontColor: const Color(0xFF898D93),
                      fontWeight: FontWeight.w400,
                      padding: const EdgeInsets.all(0),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
          const SizedBox(height: 19),
          if (!isLastItem) kHorizontalLine,
        ],
      ),
    );
  }

  Widget buildBeforeSearch() {
    return Column(
      children: [
        const TextTitle(
          titleText: "TIP.",
          cellHeight: 21,
          fontSize: 15,
          fontColor: Color(0xFF10A2DC),
          fontWeight: FontWeight.w800,
          padding: EdgeInsets.symmetric(horizontal: 25),
        ),
        const SizedBox(height: 4),
        const TextParagraph(
          paraText: "검색어에 아래와 같은 조합을 이용하시면 더욱 정확한 결과가 검색 됩니다.",
          fontSize: 13,
          fontColor: Colors.black,
          fontWeight: FontWeight.w400,
          padding: EdgeInsets.symmetric(horizontal: 25),
        ),
        const SizedBox(height: 12),
        buildDotTextView("도로명 + 건물번호", "예)판교역로 235"),
        const SizedBox(height: 6),
        buildDotTextView("지역명(동/리) + 번지", "예)삼평동 681"),
        const SizedBox(height: 6),
        buildDotTextView("지역 + 건물명(아파트)", "예)분당 주공아파트"),
        const SizedBox(height: 6),
        buildDotTextView("사서함명 + 번호", "분당 우체국 사서함"),
      ],
    );
  }

  buildDotTextView(String text, String addText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 25),
        Container(
          width: 2,
          height: 13,
          alignment: Alignment.center,
          child: Container(
            width: 2,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontSize: 13,
            height: 1.2,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            addText,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontSize: 13,
              height: 1.2,
              color: Color(0xFF898D93),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(width: 25),
      ],
    );
  }

  bool showResultList() {
    if (_resultList.isEmpty) {
      return false;
    }

    return true;
  }

  bool showCancelIcon() {
    if (_addressEditController.text.isEmpty) {
      return false;
    }

    if (_resultList.isEmpty) {
      return false;
    }

    return true;
  }

  Widget buildTitleRoadAddress() {
    return Container(
      width: 40,
      height: 22,
      decoration: BoxDecoration(
        color: const Color(0xFFF4FAFF),
        borderRadius: BorderRadius.circular(4.0),
      ),
      alignment: Alignment.center,
      child: const Text(
        "도로명",
        style: TextStyle(
          fontSize: 11,
          height: 1.1,
          color: Color(0xFF10A2DC),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget buildTitleAddress() {
    return Container(
      width: 40,
      height: 22,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(4.0),
      ),
      alignment: Alignment.center,
      child: const Text(
        "지 번",
        style: TextStyle(
          fontSize: 11,
          height: 1.1,
          color: Color(0xFF686C73),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
