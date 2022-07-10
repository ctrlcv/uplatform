import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/container_progress.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/dot_text_view.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/dialogs/cancel_booking_dialog.dart';
import 'package:uplatform/models/booking_model.dart';
import 'package:uplatform/models/common_model.dart';
import 'package:uplatform/models/request_model.dart';
import 'package:uplatform/models/user_model.dart';
import 'package:uplatform/services/login_service.dart';
import 'package:uplatform/services/network.dart';
import 'package:uplatform/services/service_list.dart';
import 'package:uplatform/utils/utils.dart';

import '../../dialogs/notice_dialog.dart';
import '../home/home_page.dart';

class BookingDetailPage extends StatefulWidget {
  const BookingDetailPage({Key? key}) : super(key: key);

  static const routeName = '/BookingDetailPage';

  @override
  _BookingDetailPageState createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
  bool _isLoading = false;
  ReservationDetail? _reservationDetail;
  String _detailItems = "";

  @override
  void initState() {
    super.initState();
    loadBookingDetail();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future loadBookingDetail() async {
    _isLoading = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};
    params['reservation_id'] = Get.arguments;

    _reservationDetail = await Network().reqBookingDetail(params);

    _detailItems = "";
    List<String> serviceIds = ((_reservationDetail!.services) ?? "").split(",");
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

    String? serviceDetail = _reservationDetail?.serviceDetail;
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        (_reservationDetail?.status == "R")
                                            ? "예약완료"
                                            : (_reservationDetail?.status == "C")
                                                ? "예약취소"
                                                : (_reservationDetail?.status == "W")
                                                    ? "예약대기"
                                                    : "서비스 완료",
                                        style: TextStyle(
                                          fontSize: 18,
                                          height: 1.0,
                                          color: (_reservationDetail?.status == "R")
                                              ? const Color(0xFFFFC113)
                                              : (_reservationDetail?.status == "C")
                                                  ? const Color(0xFFF16A34)
                                                  : const Color(0xFF898D93),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      if (_reservationDetail?.status == "C")
                                        const Text(
                                          " (환불)",
                                          style: TextStyle(
                                            fontSize: 18,
                                            height: 1.0,
                                            color: Color(0xFF898D93),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  height: 32,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    (_reservationDetail?.reservationType == "CS")
                                        ? "음식점 위생관리"
                                        : (_reservationDetail?.reservationType == "CR")
                                            ? "공간정리"
                                            : "정리교육",
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
                              (_reservationDetail?.reservationType == "CS")
                                  ? "assets/images/booking_clean_restaurant.png"
                                  : (_reservationDetail?.reservationType == "CR")
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
                    if (_reservationDetail?.createdAt != null)
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
                                  "신청일시",
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
                                  Utils().getDisplayDateTime2(_reservationDetail?.createdAt),
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
                    if (_reservationDetail?.finishedDateTime != null)
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
                                  Utils().getDisplayDateTime2(_reservationDetail?.finishedDateTime),
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
                    if (_reservationDetail?.canceledDateTime != null)
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
                                  "예약취소일시",
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
                                  Utils().getDisplayDateTime2(_reservationDetail?.canceledDateTime),
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
                    const SizedBox(height: 24),
                    if (_reservationDetail?.status != "C")
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: BorderRoundedButton(
                          text: "예약 취소",
                          textColor: Colors.black,
                          buttonColor: Colors.white,
                          fontSize: 15,
                          buttonHeight: 48,
                          onPressed: () async {
                            if (_reservationDetail?.reservationType != "LC") {
                              if (Utils().isCancelEnabled(_reservationDetail?.serviceDate ?? "") == "IMPOSSIBLE") {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const NoticeDialog(
                                      title: "예약취소",
                                      subTitle: "",
                                      contents: "예약취소가 불가능합니다.\n고객센터에 문의해 주세요",
                                    );
                                  },
                                  barrierDismissible: false,
                                );
                                return;
                              }
                            }

                            String resultStr = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CancelBookingDialog(serviceDate: _reservationDetail?.serviceDate ?? "");
                              },
                              barrierDismissible: false,
                            );

                            debugPrint("resultStr $resultStr");

                            if (resultStr.isEmpty) {
                              return;
                            }

                            Map<String, dynamic> params = {};

                            params['reservation_id'] = _reservationDetail?.reservationId;
                            params['comment'] = resultStr;
                            CommonResponse result = await Network().reqCancelReservation(params);

                            if (result.status == "200") {
                              UserInfo? _loginUser = LoginService().getUserInfo();

                              String serviceType = (_reservationDetail?.reservationType == "CS")
                                  ? "음식점 위생관리"
                                  : (_reservationDetail?.reservationType == "CR")
                                      ? "공간정리"
                                      : "정리교육";

                              params = {};
                              params['type'] = "P";
                              params['send_date'] = DateTime.now().toString();
                              params['target_user'] = _loginUser!.userId ?? "";
                              params['content'] = "$serviceType 신청을 취소하셨습니다.";

                              CommonResponse? pushResponse = await Network().reqRegisterPush(params);
                              debugPrint("pushResponse $pushResponse");

                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const NoticeDialog(
                                    title: "예약 취소 완료",
                                    subTitle: "",
                                    contents: "예약이 취소되었으며 카드사에 환불 요청하였습니다.\n정확한 환불완료일은 카드사에 직접 문의해주세요",
                                  );
                                },
                                barrierDismissible: false,
                              );
                              loadBookingDetail();
                            }
                          },
                        ),
                      ),
                    if (_reservationDetail?.status != "C") const SizedBox(height: 32),
                    Container(height: 12, color: const Color(0xFFF1F2F4)),
                    const SizedBox(height: 32),
                    buildDisplayRow("예약 번호", _reservationDetail?.reservationNo ?? ""),
                    const SizedBox(height: 20),
                    kHorizontalLine,
                    const SizedBox(height: 20),
                    if (_reservationDetail?.reservationType != "LC")
                      buildDisplayRow(
                        "방문 일정",
                        Utils().getDisplayDateTime(
                            _reservationDetail?.serviceDate ?? "", _reservationDetail?.serviceTime ?? ""),
                      )
                    else
                      buildDisplayRow("교육 요일", _reservationDetail?.serviceDate ?? ""),
                    if (_reservationDetail?.reservationType != "LC") const SizedBox(height: 20),
                    if (_reservationDetail?.reservationType != "LC") kHorizontalLine,
                    if (_reservationDetail?.reservationType != "LC") const SizedBox(height: 20),
                    if (_reservationDetail?.reservationType != "LC")
                      buildDisplayRow("방문 주소", _reservationDetail?.serviceAddress ?? ""),
                    const SizedBox(height: 20),
                    kHorizontalLine,
                    const SizedBox(height: 20),
                    buildDisplayRow("상담 번호", _reservationDetail?.phone ?? ""),
                    const SizedBox(height: 20),
                    kHorizontalLine,
                    const SizedBox(height: 20),
                    buildDisplayRow("상세 내역", _detailItems),
                    const SizedBox(height: 20),
                    kHorizontalLine,
                    const SizedBox(height: 20),
                    buildDisplayRow("요청 사항", _reservationDetail?.memo ?? ""),
                    buildPartnerInfo(),
                    const SizedBox(height: 32),
                    Container(
                      height: 12,
                      color: const Color(0xFFF1F2F4),
                    ),
                    const SizedBox(height: 32),
                    if (_reservationDetail?.status == "C")
                      buildCancelComment()
                    else if (_reservationDetail?.status == "S")
                      buildCompleteComment()
                    else
                      buildAddComment(),
                    const SizedBox(height: 32),
                    buildBottomBar,
                  ],
                ),
              ),
      ),
    );
  }

  Widget buildPartnerInfo() {
    if (_reservationDetail == null) {
      return Container();
    }

    if (_reservationDetail?.partnerName == null) {
      return Container();
    }

    String partnerPhone = _reservationDetail?.partnerPhone ?? "";

    if (partnerPhone.isNotEmpty) {
      partnerPhone = partnerPhone.replaceAll("-", "");

      if (partnerPhone.length == 11) {
        partnerPhone =
            partnerPhone.substring(0, 3) + "-" + partnerPhone.substring(3, 7) + "-" + partnerPhone.substring(7, 11);
      } else if (partnerPhone.length == 10) {
        partnerPhone =
            partnerPhone.substring(0, 3) + "-" + partnerPhone.substring(3, 6) + "-" + partnerPhone.substring(6, 10);
      }

      partnerPhone = "\n(" + partnerPhone + ")";
    }

    return Column(
      children: [
        const SizedBox(height: 20),
        kHorizontalLine,
        const SizedBox(height: 20),
        buildDisplayRow("담당 전문가", (_reservationDetail?.partnerName ?? "") + " 전문가님" + partnerPhone),
      ],
    );
  }

  Widget buildCompleteComment() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Text(
            "전문가 코멘트",
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
            _reservationDetail!.serviceComment ?? "-",
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

  Widget buildCancelComment() {
    return Column(
      children: [
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
            _reservationDetail!.cancelComment ?? "기타",
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

  Widget buildAddComment() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 18,
          child: Text(
            (_reservationDetail?.reservationType == "CS" || _reservationDetail?.reservationType == "CR")
                ? "예약취소 및 환불 안내"
                : "교육취소 및 환불 안내",
            style: const TextStyle(
              fontSize: 15,
              height: 1.2,
              color: Color(0xFF686C73),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: DotTextView(
            textStr: (_reservationDetail?.reservationType == "CS" || _reservationDetail?.reservationType == "CR")
                ? "서비스 신청 후 방문  D-3일전까지 취소 가능하며 100% 환불"
                : "교육 개시 이전 까지 납부한 수강료는 100% 환불",
            textSize: 13,
            textColor: const Color(0xFF898D93),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: DotTextView(
            textStr: "프로필 > 예약내역리스트에서 취소 가능",
            textSize: 13,
            textColor: Color(0xFF898D93),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: DotTextView(
            textStr: (_reservationDetail?.reservationType == "CS" || _reservationDetail?.reservationType == "CR")
                ? "서비스 방문 D-2, D-1 취소 시 (고객센터 문의 후 취소 가능)\n결제 금액의 50% 환불"
                : "총 교육 시간의 1/3 경과 전 이미 납부한 수강료의 2/3 해당액 환불 (고객센터 문의)",
            textSize: 13,
            textColor: const Color(0xFF898D93),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: DotTextView(
            textStr: (_reservationDetail?.reservationType == "CS" || _reservationDetail?.reservationType == "CR")
                ? "서비스 방문  당일 취소는 불가"
                : "총 교육 시간의 1/2 경과 전 이미 납부한 수강료의 1/2 해당액 환불 (고객센터 문의)",
            textSize: 13,
            textColor: const Color(0xFF898D93),
          ),
        ),
        if (_reservationDetail?.reservationType == "LC")
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: DotTextView(
              textStr: "총 교육 시간의 1/2 경과 후 환불 불가 (고객센터 문의)",
              textSize: 13,
              textColor: Color(0xFF898D93),
            ),
          ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BorderRoundedButton(
            text: "자주 묻는 질문",
            textColor: Colors.black,
            buttonColor: Colors.white,
            buttonHeight: 48,
            fontSize: 15,
            onPressed: () async {
              Get.offAllNamed(HomePage.routeName, arguments: "FAQ");
            },
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
