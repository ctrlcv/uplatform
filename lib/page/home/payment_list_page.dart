import 'package:flutter/material.dart';
import 'package:uplatform/components/container_progress.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/no_item_panel.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/payment_model.dart';
import 'package:uplatform/models/request_model.dart';
import 'package:uplatform/services/network.dart';
import 'package:uplatform/services/service_list.dart';
import 'package:uplatform/utils/utils.dart';

class PaymentListPage extends StatefulWidget {
  const PaymentListPage({Key? key}) : super(key: key);

  static const routeName = '/PaymentListPage';

  @override
  _PaymentListPageState createState() => _PaymentListPageState();
}

class _PaymentListPageState extends State<PaymentListPage> {
  final ScrollController _scrollController = ScrollController();

  bool _isLoading = false;
  bool _isNoItem = false;
  bool _isMoreLoading = false;
  String _lastItemId = "";
  int _requestCount = 0;

  List<PaymentItem> _paymentItemList = [];

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        debugPrint('Slide to the bottom ${_scrollController.position.pixels}');
        loadPaymentListMore();
      }
    });

    loadPaymentList();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future loadPaymentList() async {
    _isLoading = true;

    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};

    params['start_no'] = "0";
    params['row'] = kListLoadCount.toString();

    PaymentItemList paymentItemList = await Network().reqPaymentList(params);

    if (paymentItemList.status != "200" || paymentItemList.count == 0) {
      _isLoading = false;
      _isNoItem = true;
      _paymentItemList = [];

      if (mounted) {
        setState(() {});
      }
      return;
    }

    _isNoItem = false;
    _paymentItemList = paymentItemList.result!;
    _requestCount = paymentItemList.count ?? 0;

    if (_paymentItemList.isNotEmpty) {
      PaymentItem lastPayment = _paymentItemList[_paymentItemList.length - 1];
      _lastItemId = lastPayment.paymentId ?? "0";
    }

    _isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future loadPaymentListMore() async {
    if (_paymentItemList.isNotEmpty && _paymentItemList.length >= _requestCount) {
      return;
    }

    _isMoreLoading = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};
    params['start_no'] = _lastItemId;
    params['row'] = kListLoadCount.toString();

    PaymentItemList paymentItemList = await Network().reqPaymentList(params);

    if (paymentItemList.status != "200" || paymentItemList.count == 0) {
      _isMoreLoading = false;
      if (mounted) {
        setState(() {});
      }
      return;
    }

    List<PaymentItem>? paymentList = paymentItemList.result;
    if (paymentList != null) {
      _paymentItemList.addAll(paymentList);
    }

    if (_paymentItemList.isNotEmpty) {
      PaymentItem lastPayment = _paymentItemList[_paymentItemList.length - 1];
      _lastItemId = lastPayment.paymentId ?? "0";
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
            Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: const Text(
                "결제 내역",
                style: TextStyle(
                  fontSize: 24,
                  height: 1.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Container(
                child: _isLoading
                    ? const ContainerProgress()
                    : _isNoItem
                        ? buildNoPaymentList()
                        : Stack(
                            children: [
                              RefreshIndicator(
                                child: ListView.builder(
                                  controller: _scrollController,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: _paymentItemList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return buildPaymentItem(_paymentItemList[index]);
                                  },
                                ),
                                onRefresh: loadPaymentList,
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

  Widget buildPaymentItem(PaymentItem payment) {
    String bookingItem = (payment.services ?? "").replaceAll("[", "").replaceAll("]", "");
    List<String> bookingItems = bookingItem.split(",");

    int bookingCount = 0;
    for (int i = 0; i < bookingItems.length; i++) {
      if ((bookingItems[i].trim()).isNotEmpty) {
        bookingCount++;
      }
    }

    String paymentItemDetail = "";
    ServiceItem? serviceItem = ServiceList().getServiceItem(bookingItems[0]);
    if (serviceItem != null) {
      paymentItemDetail = "${serviceItem.serviceSubType} (${serviceItem.servicePart}) - ${serviceItem.serviceName}";

      if (bookingCount > 1) {
        paymentItemDetail += " 외 ${bookingCount - 1}건";
      }
    }

    String cardDetail = "";
    cardDetail = payment.cardName ?? "";

    if (payment.cardNumber != null && payment.cardNumber!.isNotEmpty && payment.cardNumber!.length > 4) {
      cardDetail +=
          "(" + payment.cardNumber!.substring(payment.cardNumber!.length - 4, payment.cardNumber!.length) + ")";
    }

    return Column(
      children: [
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            payment.paidDateTime ?? "",
            style: const TextStyle(
              height: 1.0,
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFFE4E7ED),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 20,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              payment.reservationTypeStr ?? "",
                              style: const TextStyle(
                                height: 1.0,
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 20,
                          alignment: Alignment.centerRight,
                          child: const Text(
                            "결제완료",
                            style: TextStyle(
                              height: 1.0,
                              fontSize: 15,
                              color: Color(0xFF898D93),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        paymentItemDetail,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF686C73),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: const BoxDecoration(
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 24,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          cardDetail,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF898D93),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 24,
                      alignment: Alignment.centerRight,
                      child: Text(
                        Utils().numberWithComma(payment.price ?? 0) + "원",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget buildNoPaymentList() {
    return Column(
      children: [
        Expanded(child: Container()),
        const NoItemPanel(
          title: "결제 내역이 없습니다.",
        ),
        Expanded(child: Container()),
      ],
    );
  }
}
