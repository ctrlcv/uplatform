import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/container_progress.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/common_model.dart';
import 'package:uplatform/models/request_model.dart';
import 'package:uplatform/page/expert/request_finish_page.dart';
import 'package:uplatform/services/network.dart';
import 'package:uplatform/services/service_list.dart';
import 'package:uplatform/utils/utils.dart';

class RequestDetailPage extends StatefulWidget {
  const RequestDetailPage({Key? key}) : super(key: key);

  static const routeName = '/RequestDetailPage';

  @override
  _RequestDetailPageState createState() => _RequestDetailPageState();
}

class _RequestDetailPageState extends State<RequestDetailPage> {
  bool _isLoading = false;
  RequestDetail? _requestDetail;
  String _detailItems = "";

  @override
  void initState() {
    super.initState();
    loadRequestDetail();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future loadRequestDetail() async {
    _isLoading = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};
    params['reservation_id'] = Get.arguments;

    _requestDetail = await Network().reqRequestDetail(params);

    _detailItems = "";
    List<String> serviceIds = ((_requestDetail!.services) ?? "").split(",");
    if (serviceIds.isNotEmpty) {
      ServiceItem? serviceItem = ServiceList().getServiceItem(serviceIds[0]);

      if (serviceItem != null) {
        if (serviceItem.serviceSubType != serviceItem.servicePart) {
          _detailItems = "${serviceItem.serviceSubType}(${serviceItem.servicePart})\n\n";
        } else {
          _detailItems = "${serviceItem.serviceSubType}";
        }
      }
    }

    String? serviceDetail = _requestDetail?.serviceDetail;
    if (serviceDetail != null) {
      serviceDetail =
          serviceDetail.replaceAll("원);", "원;").replaceAll("원),", "원;").replaceAll(" (", " - ").replaceAll("원)", "원");
      List<String> items = serviceDetail.split(";");

      for (int i = 0; i < items.length; i++) {
        if ((items[i].trim()).isNotEmpty) {
          if (i != 0) {
            _detailItems += "\n\n";
          }
          _detailItems += items[i];
        }
      }
    }

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
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 22,
                                  child: const Text(
                                    "서비스 요청",
                                    style: TextStyle(
                                      fontSize: 18,
                                      height: 1.0,
                                      color: Color(0xFF898D93),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  height: 32,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    _requestDetail?.reservationTypeStr ?? "",
                                    style: const TextStyle(
                                      fontSize: 24,
                                      height: 1.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 92,
                            width: 92,
                            child: Image.asset(
                              (_requestDetail?.reservationType == "CS")
                                  ? "assets/images/booking_clean_restaurant.png"
                                  : (_requestDetail?.reservationType == "CR")
                                      ? "assets/images/booking_clean_space.png"
                                      : "assets/images/booking_clean_education.png",
                              width: 92,
                              height: 92,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    kHorizontalLine,
                    const SizedBox(height: 20),
                    if (_requestDetail?.appliedDateTime != null)
                      Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: 16,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 104,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "지원일시",
                                  style: TextStyle(
                                    fontSize: 13,
                                    height: 1.0,
                                    color: Color(0xFF898D93),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 216,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  Utils().getDisplayDateTime2(_requestDetail?.appliedDateTime),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    height: 1.0,
                                    color: Color(0xFF898D93),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    else if (_requestDetail?.finishedDateTime != null)
                      Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: 16,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 104,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "예약완료일시",
                                  style: TextStyle(
                                    fontSize: 13,
                                    height: 1.0,
                                    color: Color(0xFF898D93),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 216,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  Utils().getDisplayDateTime2(_requestDetail?.finishedDateTime),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    height: 1.0,
                                    color: Color(0xFF898D93),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 16,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 104,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                "지원자",
                                style: TextStyle(
                                  fontSize: 13,
                                  height: 1.0,
                                  color: Color(0xFF898D93),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 216,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                (_requestDetail?.applyCount ?? "0") + "명",
                                style: const TextStyle(
                                  fontSize: 13,
                                  height: 1.0,
                                  color: Color(0xFF898D93),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (_requestDetail?.status == "W")
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: BorderRoundedButton(
                          text: (_requestDetail?.applied == "Y") ? "지원완료" : "지원하기",
                          textColor:
                              (_requestDetail?.applied == "Y") ? const Color(0xFFC9CDD4) : const Color(0xFF10A2DC),
                          buttonColor: Colors.white,
                          borderColor: (_requestDetail?.applied == "Y") ? Colors.transparent : const Color(0xFF10A2DC),
                          fontSize: 15,
                          buttonHeight: 48,
                          onPressed: () async {
                            if (_requestDetail?.applied == "Y") {
                              return;
                            } else {
                              Map<String, dynamic> params = {};

                              params['reservation_id'] = _requestDetail?.reservationId;
                              CommonResponse result = await Network().reqRegApply(params);
                              if (result.status == "200") {
                                Get.offNamed(RequestFinishPage.routeName);
                              }
                            }
                          },
                        ),
                      ),
                    if (_requestDetail?.status == "W") const SizedBox(height: 32),
                    Container(height: 12, color: const Color(0xFFF1F2F4)),
                    const SizedBox(height: 32),
                    buildDisplayRow("예약 번호", _requestDetail?.reservationNo ?? ""),
                    const SizedBox(height: 20),
                    kHorizontalLine,
                    const SizedBox(height: 20),
                    if (_requestDetail?.reservationType != "LC")
                      buildDisplayRow(
                        "방문 일정",
                        Utils()
                            .getDisplayDateTime(_requestDetail?.serviceDate ?? "", _requestDetail?.serviceTime ?? ""),
                      )
                    else
                      buildDisplayRow("교육 요일", _requestDetail?.serviceDate ?? ""),
                    if (_requestDetail?.reservationType != "LC") const SizedBox(height: 20),
                    if (_requestDetail?.reservationType != "LC") kHorizontalLine,
                    if (_requestDetail?.reservationType != "LC") const SizedBox(height: 20),
                    if (_requestDetail?.reservationType != "LC")
                      buildDisplayRow("방문 주소", _requestDetail?.serviceAddress ?? ""),
                    const SizedBox(height: 20),
                    kHorizontalLine,
                    const SizedBox(height: 20),
                    buildDisplayRow("상담 번호", _requestDetail?.phone ?? ""),
                    const SizedBox(height: 20),
                    kHorizontalLine,
                    const SizedBox(height: 20),
                    buildDisplayRow("상세 내역", _detailItems),
                    const SizedBox(height: 20),
                    kHorizontalLine,
                    const SizedBox(height: 20),
                    buildDisplayRow("안내 사항", _requestDetail?.memo ?? ""),
                    const SizedBox(height: 32),
                    buildBottomBar,
                  ],
                ),
              ),
      ),
    );
  }

  Container buildDisplayRow(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 104,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.2,
                  color: Color(0xFF686C73),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 216,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.2,
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
}
