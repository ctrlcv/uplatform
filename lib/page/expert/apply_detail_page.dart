import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/container_progress.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/dialogs/cancel_apply_dialog.dart';
import 'package:uplatform/models/common_model.dart';
import 'package:uplatform/models/request_model.dart';
import 'package:uplatform/services/network.dart';
import 'package:uplatform/services/service_list.dart';
import 'package:uplatform/utils/utils.dart';

import '../../dialogs/notice_dialog.dart';

class ApplyDetailPage extends StatefulWidget {
  const ApplyDetailPage({Key? key}) : super(key: key);

  static const routeName = '/ApplyDetailPage';

  @override
  _ApplyDetailPageState createState() => _ApplyDetailPageState();
}

class _ApplyDetailPageState extends State<ApplyDetailPage> {
  bool _isLoading = false;
  ApplyDetail? _applyDetail;
  String _detailItems = "";

  @override
  void initState() {
    super.initState();
    loadApplyDetail();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future loadApplyDetail() async {
    _isLoading = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};
    params['apply_id'] = Get.arguments;

    _applyDetail = await Network().reqApplyDetail(params);

    _detailItems = "";
    List<String> serviceIds = ((_applyDetail!.services) ?? "").split(",");
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

    String? serviceDetail = _applyDetail?.serviceDetail;
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

  Future loadServiceList() async {
    if (_applyDetail == null) {
      return null;
    }

    Map<String, dynamic> params = {};

    params['service_type'] = _applyDetail?.reservationTypeStr;
    return await Network().reqServiceList(params);
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
                                  child: Text(
                                    _applyDetail!.statusStr ?? "",
                                    style: TextStyle(
                                      fontSize: 18,
                                      height: 1.0,
                                      color: (_applyDetail!.statusStr == "지원취소")
                                          ? const Color(0xFFF16A34)
                                          : (_applyDetail!.statusStr == "확정")
                                              ? const Color(0xFF10A2DC)
                                              : const Color(0xFF898D93),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  height: 32,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    _applyDetail?.reservationTypeStr ?? "",
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
                              (_applyDetail?.reservationType == "CS")
                                  ? "assets/images/booking_clean_restaurant.png"
                                  : (_applyDetail?.reservationType == "CR")
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
                    if (_applyDetail?.createDateTime != null)
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
                                  Utils().getDisplayDateTime2(_applyDetail?.createDateTime),
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
                    if (_applyDetail?.matchedDateTime != null)
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
                                  Utils().getDisplayDateTime2(_applyDetail?.matchedDateTime),
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
                    if (_applyDetail?.canceledDateTime != null)
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
                                  "지원취소일시",
                                  style: TextStyle(
                                    fontSize: 13,
                                    height: 1.0,
                                    color: Colors.black,
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
                                  Utils().getDisplayDateTime2(_applyDetail?.canceledDateTime),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    height: 1.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (_applyDetail?.status != "C") const SizedBox(height: 18),
                    if (_applyDetail?.status != "C")
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: BorderRoundedButton(
                          text: "지원취소",
                          textColor: Colors.black,
                          buttonColor: Colors.white,
                          borderColor: const Color(0xFFE4E7ED),
                          fontSize: 15,
                          buttonHeight: 48,
                          onPressed: () async {
                            String? resultStr = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const CancelApplyDialog();
                              },
                              barrierDismissible: false,
                            );

                            debugPrint("resultStr $resultStr");

                            if (resultStr == null || resultStr.isEmpty) {
                              return;
                            }

                            Map<String, dynamic> params = {};

                            params['apply_id'] = _applyDetail?.applyId;
                            params['comment'] = resultStr;

                            CommonResponse result = await Network().reqCancelApply(params);

                            if (result.status == "200") {
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const NoticeDialog(
                                    title: "지원 취소 완료",
                                    subTitle: "",
                                    contents: "지원이 취소되었습니다.",
                                  );
                                },
                                barrierDismissible: false,
                              );

                              Get.back(result: "cancel_apply");
                            } else {
                              Get.back();
                              Get.snackbar('지원취소실패', "지원이 취소에 실패하였습니다.",
                                  snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                            }
                          },
                        ),
                      ),
                    const SizedBox(height: 32),
                    Container(height: 12, color: const Color(0xFFF1F2F4)),
                    const SizedBox(height: 32),
                    buildDisplayRow("예약 번호", _applyDetail?.reservationNo ?? ""),
                    const SizedBox(height: 20),
                    kHorizontalLine,
                    const SizedBox(height: 20),
                    if (_applyDetail?.reservationType != "LC")
                      buildDisplayRow(
                        "방문 일정",
                        Utils().getDisplayDateTime(_applyDetail?.serviceDate ?? "", _applyDetail?.serviceTime ?? ""),
                      )
                    else
                      buildDisplayRow("교육 요일", _applyDetail?.learnDay ?? ""),
                    if (_applyDetail?.reservationType != "LC") const SizedBox(height: 20),
                    if (_applyDetail?.reservationType != "LC") kHorizontalLine,
                    if (_applyDetail?.reservationType != "LC") const SizedBox(height: 20),
                    if (_applyDetail?.reservationType != "LC")
                      buildDisplayRow("방문 주소", _applyDetail?.serviceAddress ?? ""),
                    const SizedBox(height: 20),
                    kHorizontalLine,
                    const SizedBox(height: 20),
                    buildDisplayRow("상담 번호", _applyDetail?.phoneNumber ?? ""),
                    const SizedBox(height: 20),
                    kHorizontalLine,
                    const SizedBox(height: 20),
                    buildDisplayRow("상세 내역", _detailItems),
                    const SizedBox(height: 20),
                    kHorizontalLine,
                    const SizedBox(height: 20),
                    buildDisplayRow("안내 사항", _applyDetail?.memo ?? ""),
                    if (_applyDetail?.status == "C") buildCancelComment(),
                    const SizedBox(height: 32),
                    buildBottomBar,
                  ],
                ),
              ),
      ),
    );
  }

  Widget buildCancelComment() {
    return Column(
      children: [
        const SizedBox(height: 32),
        Container(
          height: 12,
          color: const Color(0xFFF1F2F4),
        ),
        const SizedBox(height: 32),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Text(
            "취소사유",
            style: TextStyle(
              fontSize: 15,
              height: 1.2,
              color: Color(0xFF686C73),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            _applyDetail!.cancelComment ?? "기타",
            style: const TextStyle(
              fontSize: 15,
              height: 1.4,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
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
