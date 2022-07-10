import 'package:flutter/material.dart';
import 'package:uplatform/components/container_progress.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/no_item_panel.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/income_model.dart';
import 'package:uplatform/services/network.dart';
import 'package:uplatform/utils/utils.dart';
import 'package:get/get.dart';

import 'income_detail_page.dart';

class IncomeListPage extends StatefulWidget {
  const IncomeListPage({Key? key}) : super(key: key);

  static const routeName = '/IncomeListPage';

  @override
  _IncomeListPageState createState() => _IncomeListPageState();
}

class _IncomeListPageState extends State<IncomeListPage> {
  final ScrollController _scrollController = ScrollController();

  bool _isLoading = false;
  bool _isNoItem = false;
  bool _isMoreLoading = false;
  String _lastItemIndex = "";
  int _requestCount = 0;
  int _totalPaidAmount = 0;

  List<IncomeItem> _incomeItemList = [];

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        debugPrint('Slide to the bottom ${_scrollController.position.pixels}');
        loadIncomeListMore();
      }
    });

    loadIncomeList();
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  Future loadIncomeList() async {
    _isLoading = true;

    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};

    params['start_no'] = "0";
    params['row'] = kListLoadCount.toString();

    IncomeItemList? incomeItemList = await Network().reqIncomeList(params);

    if (incomeItemList == null || incomeItemList.status != "200" || incomeItemList.count == 0) {
      _isLoading = false;
      _isNoItem = true;
      _incomeItemList = [];

      if (mounted) {
        setState(() {});
      }
      return;
    }

    _isNoItem = false;
    _incomeItemList = incomeItemList.result!;
    _requestCount = incomeItemList.count ?? 0;

    if (_incomeItemList.isNotEmpty) {
      _lastItemIndex = "${_incomeItemList.length - 1}";
    }

    for (int i = 0; i < _incomeItemList.length; i++) {
      _totalPaidAmount += int.parse(_incomeItemList[i].paidAmount ?? "0");
    }

    _isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future loadIncomeListMore() async {
    if (_incomeItemList.isNotEmpty && _incomeItemList.length >= _requestCount) {
      return;
    }

    _isMoreLoading = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};
    params['start_no'] = _lastItemIndex;
    params['row'] = kListLoadCount.toString();

    IncomeItemList? incomeItemList = await Network().reqIncomeList(params);

    if (incomeItemList == null || incomeItemList.status != "200" || incomeItemList.count == 0) {
      _isMoreLoading = false;
      if (mounted) {
        setState(() {});
      }
      return;
    }

    List<IncomeItem>? incomeList = incomeItemList.result;
    if (incomeList != null) {
      _incomeItemList.addAll(incomeList);
    }

    if (_incomeItemList.isNotEmpty) {
      _lastItemIndex = "${_incomeItemList.length - 1}";
    }

    _isMoreLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(iconData: Icons.arrow_back),
        body: Column(
          children: [
            const SizedBox(height: 16),
            const TextTitle(
              titleText: "정산내역",
              cellHeight: 32,
              fontSize: 24,
              fontColor: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF4FAFF),
                borderRadius: BorderRadius.circular(8.0),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "지금까지 정산금액  ",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    Utils().numberWithComma(_totalPaidAmount) + "원",
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.0,
                      color: Color(0xFF10A2DC),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            Expanded(
              child: Container(
                child: _isLoading
                    ? const ContainerProgress()
                    : _isNoItem
                        ? buildNoIncomeList()
                        : Stack(
                            children: [
                              RefreshIndicator(
                                child: ListView.builder(
                                  controller: _scrollController,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: _incomeItemList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return buildIncomeItem(_incomeItemList[index]);
                                  },
                                ),
                                onRefresh: loadIncomeList,
                              ),
                              Offstage(
                                offstage: !_isMoreLoading,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ],
                          ),
              ),
            ),
            const SizedBox(height: 32),
            buildBottomBar,
          ],
        ),
      ),
    );
  }

  Widget buildIncomeItem(IncomeItem incomeItem) {
    String eventMonth = incomeItem.month ?? "";

    if (eventMonth.isNotEmpty) {
      List<String> months = eventMonth.split("-");
      eventMonth = months[0] + "년 " + months[1] + "월";
    }

    int amount = int.parse(incomeItem.amount ?? "0");
    int paidAmount = int.parse(incomeItem.paidAmount ?? "0");

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE4E7ED), width: 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(IncomeDetailPage.routeName, arguments: incomeItem.month);
            },
            child: Container(
              alignment: Alignment.center,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextTitle(
                      titleText: eventMonth,
                      cellHeight: 18,
                      fontSize: 15,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.w600,
                      padding: const EdgeInsets.all(0),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 16,
                    color: Color(0xFF898D93),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          kHorizontalLineNoMargin,
          const SizedBox(height: 16),
          buildTextItem("건수", "${incomeItem.count}건"),
          buildTextItem("총 금액", "${Utils().numberWithComma(amount)}원"),
          buildTextItem2(
            "정산금액",
            "${Utils().numberWithComma(paidAmount)}원",
            textColor: (amount <= paidAmount) ? Colors.black : const Color(0xFF10A2DC),
          ),
        ],
      ),
    );
  }

  Widget buildTextItem(String title, String content) {
    return Container(
      height: 26,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                height: 1.0,
                color: Color(0xFF686C73),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text(
            content,
            style: const TextStyle(
              fontSize: 15,
              height: 1.0,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextItem2(String title, String content, {Color textColor = Colors.black}) {
    return Container(
      height: 26,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                height: 1.0,
                color: Color(0xFF686C73),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text(
            content,
            style: TextStyle(
              fontSize: 15,
              height: 1.0,
              color: textColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNoIncomeList() {
    return Column(
      children: [
        Expanded(child: Container()),
        const NoItemPanel(
          title: "정산 내역이 없습니다.",
        ),
        Expanded(child: Container()),
      ],
    );
  }
}
