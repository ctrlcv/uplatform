import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/container_progress.dart';
import 'package:uplatform/components/no_item_panel.dart';
import 'package:uplatform/components/text_paragraph.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/booking_model.dart';
import 'package:uplatform/page/booking/booking_detail_page.dart';
import 'package:uplatform/page/booking/booking_type_page.dart';
import 'package:uplatform/services/network.dart';
import 'package:uplatform/utils/utils.dart';

class ReservationTab extends StatefulWidget {
  const ReservationTab({Key? key}) : super(key: key);

  @override
  _ReservationTabState createState() => _ReservationTabState();
}

class _ReservationTabState extends State<ReservationTab> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  String _tabTitleBooking = "예약내역";
  String _tabTitleOldBooking = "지난 예약내역 (2건)";

  List<Reservation> _bookingList = [];
  List<Reservation> _pastBookingList = [];

  bool _isLoading = false;
  bool _isNoBookingItem = false;
  bool _isNoPastBookingItem = false;

  @override
  void initState() {
    super.initState();

    loadBookingList();
    loadPastBookingList();

    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController?.dispose();

    super.dispose();
  }

  Future<void> loadBookingList({int index = 0}) async {
    _isLoading = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};
    params['type'] = "ing";
    params['start_no'] = index.toString();
    params['row'] = "100";

    ReservationList? reservationList = await Network().reqBookingList(params);

    if (reservationList == null || reservationList.result!.isEmpty) {
      _bookingList.clear();
      _isNoBookingItem = true;
      _tabTitleBooking = "예약내역";
    } else {
      _bookingList = reservationList.result!;
      _isNoBookingItem = false;
      _tabTitleBooking = "예약내역 (${_bookingList.length}건)";
    }

    _isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> loadPastBookingList({int index = 0}) async {
    _isLoading = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};
    params['type'] = "end";
    params['start_no'] = index.toString();
    params['row'] = "100";

    ReservationList? reservationList = await Network().reqBookingList(params);

    if (reservationList == null || reservationList.result!.isEmpty) {
      _pastBookingList.clear();
      _isNoPastBookingItem = true;
      _tabTitleOldBooking = "지난 예약내역";
    } else {
      _pastBookingList = reservationList.result!;
      _isNoPastBookingItem = false;
      _tabTitleOldBooking = "지난 예약내역 (${_pastBookingList.length}건)";
    }

    _isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                height: 31,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "예약내역",
                  style: TextStyle(
                    fontSize: 26,
                    height: 1.2,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 40,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFFE4E7ED),
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: TabBar(
                            controller: _tabController,
                            labelColor: Colors.black,
                            unselectedLabelColor: const Color(0xFFE4E7ED),
                            indicatorWeight: 2,
                            indicatorColor: Colors.black,
                            labelStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            unselectedLabelStyle: const TextStyle(
                              fontSize: 15,
                              color: Color(0xFF898D93),
                              fontWeight: FontWeight.w400,
                            ),
                            tabs: [
                              Tab(
                                text: _tabTitleBooking,
                              ),
                              Tab(
                                text: _tabTitleOldBooking,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: DefaultTabController(
                        length: 2,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Container(
                              child: _isLoading
                                  ? const ContainerProgress()
                                  : _isNoBookingItem
                                      ? buildNoBookingItems()
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.only(top: 16),
                                          physics: const ClampingScrollPhysics(),
                                          itemCount: _bookingList.length + 1,
                                          itemBuilder: (BuildContext context, int index) {
                                            if (index == _bookingList.length) {
                                              if (_isLoading) {
                                                return Container();
                                              } else {
                                                return Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                                                  child: BorderRoundedButton(
                                                    text: "예약하기",
                                                    buttonColor: kMainColor,
                                                    buttonHeight: 50,
                                                    onPressed: () {
                                                      Get.toNamed(BookingTypePage.routeName);
                                                    },
                                                  ),
                                                );
                                              }
                                            }

                                            return buildBookingItem(
                                              _bookingList[index],
                                              (index == _bookingList.length - 1),
                                            );
                                          },
                                        ),
                            ),
                            Container(
                              child: _isLoading
                                  ? const ContainerProgress()
                                  : _isNoPastBookingItem
                                      ? buildNoPastBookingItems()
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.only(top: 16),
                                          physics: const ClampingScrollPhysics(),
                                          itemCount: _pastBookingList.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return buildBookingItem(
                                              _pastBookingList[index],
                                              (index == _pastBookingList.length - 1),
                                            );
                                          },
                                        ),
                            ),
                          ],
                        ),
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

  Widget buildBookingItem(Reservation booking, bool isLastItem) {
    return GestureDetector(
      onTap: () async {
        var result = await Get.toNamed(BookingDetailPage.routeName, arguments: booking.reservationId);
        loadBookingList();
        loadPastBookingList();
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 20,
                        color: Colors.transparent,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          (booking.serviceDate != null)
                              ? (booking.reservationType == "LC")
                                  ? booking.serviceDate!
                                  : Utils().getDisplayDateTime(booking.serviceDate!, booking.serviceTime!)
                              : "",
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.2,
                            color: Color(0xFF898D93),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        height: 4,
                        color: Colors.transparent,
                      ),
                      Container(
                        height: 20,
                        color: Colors.transparent,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          (booking.reservationType == "CS")
                              ? "음식점 위생관리"
                              : (booking.reservationType == "CR")
                                  ? "공간정리"
                                  : "정리교육",
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.2,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (booking.status != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: (booking.status == "R")
                          ? const Color(0xFFF4FAFF)
                          : (booking.status == "C")
                              ? const Color(0xFFFFF4F4)
                              : const Color(0xFFF5F6F8),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      (booking.status == "R")
                          ? "예약완료"
                          : (booking.status == "C")
                              ? "예약취소"
                              : (booking.status == "W")
                                  ? "예약대기"
                                  : "서비스 완료",
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.1,
                        color: (booking.status == "R")
                            ? const Color(0xFF10A2DC)
                            : (booking.status == "C")
                                ? const Color(0xFFF16A34)
                                : const Color(0xFF686C73),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
            if (booking.status == "C") const SizedBox(height: 16),
            if (booking.status == "C")
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const TextParagraph(
                  paraText: "[환불] 카드결제가 취소되었습니다.\n카드결제 취소는 카드사별로 상이 할 수 있습니다.",
                  fontSize: 13,
                  fontColor: Color(0xFF898D93),
                  fontWeight: FontWeight.w400,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            const SizedBox(height: 24),
            if (!isLastItem) kHorizontalLineNoMargin,
          ],
        ),
      ),
    );
  }

  Widget buildNoPastBookingItems() {
    return Column(
      children: [
        Expanded(child: Container()),
        const NoItemPanel(
          title: "지난 예약내역이 없습니다.",
        ),
        Expanded(child: Container()),
      ],
    );
  }

  Widget buildNoBookingItems() {
    return Column(
      children: [
        Expanded(child: Container()),
        NoItemPanel(
          title: "예약된 서비스가 없습니다.",
          addText: "합리적인 가격\n효율적인 위생&정리 시스템\n대한민국 NO.1 샤이니오",
          buttonText: "예약하기",
          onPressed: () {
            Get.toNamed(BookingTypePage.routeName);
          },
        ),
        Expanded(child: Container()),
      ],
    );
  }
}
