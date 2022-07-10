import 'package:flutter/material.dart';
import 'package:uplatform/components/container_progress.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/income_model.dart';
import 'package:get/get.dart';
import 'package:uplatform/services/network.dart';
import 'package:uplatform/utils/utils.dart';

class IncomeDetailPage extends StatefulWidget {
  const IncomeDetailPage({Key? key}) : super(key: key);

  static const routeName = '/IncomeDetailPage';

  @override
  _IncomeDetailPageState createState() => _IncomeDetailPageState();
}

class _IncomeDetailPageState extends State<IncomeDetailPage> {
  String _searchMonth = "";
  IncomeDetail? _incomeDetail;
  bool _isLoading = false;

  int _totalPaidAmount = 0;
  int _totalAmount = 0;

  List<IncomeDetailItem> _incomeDetailItemList = [];

  @override
  void initState() {
    super.initState();

    _searchMonth = Get.arguments ?? "";

    loadIncomeDetail();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future loadIncomeDetail() async {
    _isLoading = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};
    params['month'] = _searchMonth.substring(0, 7);
    params['start_no'] = "0";
    params['row'] = "100";

    _incomeDetail = await Network().reqIncomeDetail(params);

    if (_incomeDetail == null) {
      _isLoading = false;
      Get.back();
      return;
    }

    _incomeDetailItemList = _incomeDetail!.data ?? [];

    _totalPaidAmount = int.parse((_incomeDetail!.paidAmount ?? "0").replaceAll(",", ""));
    _totalAmount = int.parse((_incomeDetail!.totalAmount ?? "0").replaceAll(",", ""));

    _isLoading = false;
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
        body: _isLoading
            ? const ContainerProgress()
            : Column(
                children: [
                  const SizedBox(height: 16),
                  TextTitle(
                    titleText: _searchMonth.substring(0, 4) + "년 " + _searchMonth.substring(5, 7) + "월 정산내역",
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
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "정산완료",
                                  style: TextStyle(
                                    fontSize: 13,
                                    height: 1.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "${Utils().numberWithComma(_totalPaidAmount)}원",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    height: 1.0,
                                    color: Color(0xFF10A2DC),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 51,
                          color: const Color(0xFFE1EAF1),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "총 금액",
                                  style: TextStyle(
                                    fontSize: 13,
                                    height: 1.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "${Utils().numberWithComma(_totalAmount)}원",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    height: 1.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    height: 18,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const Text(
                          "총 ",
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          (_incomeDetail == null) ? "0" : _incomeDetail!.count ?? "0",
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.0,
                            color: Color(0xFF10A2DC),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text(
                          "건",
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Container(
                      child: _isLoading
                          ? const ContainerProgress()
                          : RefreshIndicator(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: _incomeDetailItemList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return buildIncomeDetailItem(_incomeDetailItemList[index]);
                                },
                              ),
                              onRefresh: loadIncomeDetail,
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

  Widget buildIncomeDetailItem(IncomeDetailItem detailItem) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextTitle(
                  titleText: (detailItem.date ?? "").replaceAll("-", "."),
                  cellHeight: 18,
                  fontSize: 15,
                  fontColor: Colors.black,
                  fontWeight: FontWeight.w600,
                  padding: const EdgeInsets.all(0),
                ),
              ),
              Text(
                (detailItem.state == "W") ? "정산대기" : "정산완료",
                style: TextStyle(
                  fontSize: 13,
                  height: 1.0,
                  color: (detailItem.state == "W") ? const Color(0xFF10A2DC) : const Color(0xFF898D93),
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (detailItem.state == "W")
                Container(
                  height: 28,
                  decoration: BoxDecoration(
                    color: const Color(0xFF686C73),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  margin: const EdgeInsets.only(left: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  alignment: Alignment.center,
                  child: const Text(
                    "1:1 문의",
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.1,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          kHorizontalLineNoMargin,
          const SizedBox(height: 16),
          buildTextItem("예약번호", "${detailItem.reservationNo}"),
          buildTextItem("서비스 유형", (detailItem.reservationTypeStr ?? "음식점 위생정리")),
          buildTextItem("고객 결제 금액", Utils().numberWithComma(detailItem.price ?? 0) + "원 (수수료 20%)"),
          buildTextItem2(
            "정산금액",
            "${Utils().numberWithComma(detailItem.amount ?? 0)}원",
            textColor: ((detailItem.price ?? 1) <= (detailItem.amount ?? 0)) ? Colors.black : const Color(0xFF10A2DC),
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
                fontSize: 13,
                height: 1.0,
                color: Color(0xFF686C73),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text(
            content,
            style: const TextStyle(
              fontSize: 13,
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
                fontSize: 13,
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
}
