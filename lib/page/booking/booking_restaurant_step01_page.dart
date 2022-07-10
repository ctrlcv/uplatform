import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/extra_service_item.dart';
import 'package:uplatform/components/goods_item.dart';
import 'package:uplatform/components/input_title.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/booking_model.dart';
import 'package:uplatform/utils/utils.dart';
import 'booking_restaurant_step02_page.dart';

class BookingRestaurantStep01Page extends StatefulWidget {
  const BookingRestaurantStep01Page({Key? key}) : super(key: key);

  static const routeName = '/BookingRestaurantStep01Page';

  @override
  _BookingRestaurantStep01PageState createState() => _BookingRestaurantStep01PageState();
}

class _BookingRestaurantStep01PageState extends State<BookingRestaurantStep01Page> {
  final ScrollController _scrollController = ScrollController();

  bool _isConcertingTotal = false;
  bool _isConcertingPart = false;

  bool _itemRefrigerator = false;
  bool _itemKitchen = false;
  bool _itemHall = false;
  bool _itemStorage = false;
  bool _itemWorkInRefrigerator = false;
  bool _itemGuestRoom = false;

  bool _itemFullSiteVisit = false;
  bool _itemFullConcertingReport = false;

  bool _extraServiceCuration = false;
  bool _extraServiceInfo = false;

  Map<String, dynamic> _bookingParams = {};

  @override
  void initState() {
    super.initState();

    _bookingParams = Get.arguments;
    if (_bookingParams['booking_type'] == "컨설팅 (부분)") {
      _isConcertingPart = true;
    } else {
      _isConcertingTotal = true;
    }
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(iconData: Icons.arrow_back),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              const SizedBox(height: 16),
              const TextTitle(
                titleText: "음식점 위생정리 예약",
                cellHeight: 32,
                fontSize: 24,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 40),
              if (_isConcertingPart) buildConcertingPartItems(),
              if (_isConcertingTotal) buildConcertingTotalItems(),
              if(_itemFullSiteVisit) const SizedBox(height: 32),
              if(_isConcertingPart || _itemFullSiteVisit) kHorizontalLine,
              if(_isConcertingPart || _itemFullSiteVisit) const SizedBox(height: 32),
              if(_isConcertingPart || _itemFullSiteVisit) buildExtraServices(),
              const SizedBox(height: 32),
              kHorizontalLine,
              if (isActiveNextButton()) const SizedBox(height: 32),
              if (isActiveNextButton()) buildPriceSum(),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BorderRoundedButton(
                  text: "다음",
                  buttonColor: kMainColor,
                  active: isActiveNextButton(),
                  onPressed: () async {
                    Map<String, dynamic> bookingParams = {};
                    bookingParams['reservation_type'] = "CS";
                    bookingParams['service_addr'] = _bookingParams['service_addr'];

                    bookingParams['address'] = _bookingParams['address'];
                    bookingParams['addaddress'] = _bookingParams['addaddress'];

                    List<int> serviceIds = [];
                    int totalPrice = 0;
                    List<BookingItem> bookingItems = [];

                    if (_itemRefrigerator) {
                      serviceIds.add(1);
                      totalPrice += 330000;
                      bookingItems.add(BookingItem(type: "음식점 위생정리 - 컨설팅(부분)", title: "냉장고", detail: "방문 1회/2시간", price: 330000));
                    }

                    if (_itemKitchen) {
                      serviceIds.add(2);
                      totalPrice += 330000;
                      bookingItems.add(BookingItem(type: "음식점 위생정리 - 컨설팅(부분)", title: "주방(냉장고 미포함)", detail: "방문 1회/2시간", price: 330000));
                    }

                    if (_itemHall) {
                      serviceIds.add(3);
                      totalPrice += 330000;
                      bookingItems.add(BookingItem(type: "음식점 위생정리 - 컨설팅(부분)", title: "홀 티카", detail: "방문 1회/2시간", price: 330000));
                    }

                    if (_itemStorage) {
                      serviceIds.add(4);
                      totalPrice += 330000;
                      bookingItems.add(BookingItem(type: "음식점 위생정리 - 컨설팅(부분)", title: "창고", detail: "방문 1회/2시간", price: 330000));
                    }

                    if (_itemWorkInRefrigerator) {
                      serviceIds.add(5);
                      totalPrice += 330000;
                      bookingItems.add(BookingItem(type: "음식점 위생정리 - 컨설팅(부분)", title: "워크인 냉장고", detail: "방문 1회/2시간", price: 330000));
                    }

                    if (_itemGuestRoom) {
                      serviceIds.add(6);
                      totalPrice += 330000;
                      bookingItems.add(BookingItem(type: "음식점 위생정리 - 컨설팅(부분)", title: "객실", detail: "방문 1회/2시간", price: 330000));
                    }

                    if (_itemFullSiteVisit) {
                      serviceIds.add(7);
                      totalPrice += 990000;
                      bookingItems.add(BookingItem(type: "음식점 위생정리 - 컨설팅(전체)", title: "현장방문", detail: "1차방문/2시간, 2차방문/3시간", price: 990000));
                    }

                    if (_itemFullConcertingReport) {
                      serviceIds.add(8);
                      totalPrice += 990000;
                      bookingItems.add(BookingItem(type: "음식점 위생정리 - 컨설팅(전체)", title: "공간 컨설팅 보고서 제공", detail: "7일(2차 방문일 이후 영업일 기준)", price: 990000));
                    }

                    if (_extraServiceCuration) {
                      serviceIds.add(9);
                      totalPrice += 330000;
                      bookingItems.add(BookingItem(type: "부가서비스", title: "수납용품 큐레이션 서비스", detail: "", price: 330000));
                    }

                    if (_extraServiceInfo) {
                      serviceIds.add(10);
                      totalPrice += 220000;
                      bookingItems.add(BookingItem(type: "부가서비스", title: "수납용품 정보 제공", detail: "", price: 220000));
                    }

                    String serviceIdsStr = (serviceIds.toString()).replaceAll("[", "").replaceAll("]", "").trim();

                    bookingParams['services'] = serviceIdsStr;
                    bookingParams['price'] = totalPrice;
                    bookingParams['bookingitems'] = bookingItems;

                    Get.toNamed(BookingRestaurantStep02Page.routeName, arguments: bookingParams);
                  },
                ),
              ),
              const SizedBox(height: 32),
              buildBottomBar,
            ],
          ),
        ),
      ),
    );
  }

  bool isActiveNextButton() {
    if (_isConcertingPart) {
      if (_itemRefrigerator || _itemKitchen || _itemHall || _itemStorage || _itemWorkInRefrigerator || _itemGuestRoom) {
        return true;
      }
    }

    if (_isConcertingTotal) {
      if (_itemFullSiteVisit || _itemFullConcertingReport) {
        return true;
      }
    }

    return false;
  }

  Widget buildConcertingPartItems() {
    return Column(
      children: [
        Row(
          children: [
            const InputTitle(
              title: "상품",
              isRequired: true,
              textFontSize: 15,
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                if (_itemRefrigerator &&
                    _itemKitchen &&
                    _itemHall &&
                    _itemStorage &&
                    _itemWorkInRefrigerator &&
                    _itemGuestRoom) {
                  _itemRefrigerator = false;
                  _itemKitchen = false;
                  _itemHall = false;
                  _itemStorage = false;
                  _itemWorkInRefrigerator = false;
                  _itemGuestRoom = false;
                } else {
                  _itemRefrigerator = true;
                  _itemKitchen = true;
                  _itemHall = true;
                  _itemStorage = true;
                  _itemWorkInRefrigerator = true;
                  _itemGuestRoom = true;
                }

                if (mounted) {
                  setState(() {});
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  (_itemRefrigerator &&
                      _itemKitchen &&
                      _itemHall &&
                      _itemStorage &&
                      _itemWorkInRefrigerator &&
                      _itemGuestRoom)
                      ? "전체해제"
                      : "전체선택",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF10A2DC),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        GoodsItem(
            isSelected: _itemRefrigerator,
            title: "냉장고",
            contents: "방문1회/2시간",
            value: "330,000원",
            onChanged: (value) {
              _itemRefrigerator = value;
              if (mounted) {
                setState(() {});
              }
            }),
        GoodsItem(
          isSelected: _itemKitchen,
          title: "주방(냉장고 미포함)",
          contents: "방문1회/2시간",
          value: "330,000원",
          onChanged: (value) {
            _itemKitchen = value;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        GoodsItem(
          isSelected: _itemHall,
          title: "홀 티카",
          contents: "방문1회/2시간",
          value: "330,000원",
          onChanged: (value) {
            _itemHall = value;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        GoodsItem(
          isSelected: _itemStorage,
          title: "창고",
          contents: "방문1회/2시간",
          value: "330,000원",
          onChanged: (value) {
            _itemStorage = value;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        GoodsItem(
          isSelected: _itemWorkInRefrigerator,
          title: "워크인 냉장고",
          contents: "방문1회/2시간",
          value: "330,000원",
          onChanged: (value) {
            _itemWorkInRefrigerator = value;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        GoodsItem(
          isSelected: _itemGuestRoom,
          title: "객실",
          contents: "방문1회/2시간",
          value: "330,000원",
          onChanged: (value) {
            _itemGuestRoom = value;
            if (mounted) {
              setState(() {});
            }
          },
        ),
      ],
    );
  }

  Widget buildConcertingTotalItems() {
    return Column(
      children: [
        Row(
          children: [
            const InputTitle(
              title: "상품",
              isRequired: true,
              textFontSize: 15,
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                if (_itemFullSiteVisit && _itemFullConcertingReport) {
                  _itemFullSiteVisit = false;
                  _itemFullConcertingReport = false;
                } else {
                  _itemFullSiteVisit = true;
                  _itemFullConcertingReport = true;
                }

                if (mounted) {
                  setState(() {});
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  (_itemFullSiteVisit && _itemFullConcertingReport) ? "전체해제" : "전체선택",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF10A2DC),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        GoodsItem(
            isSelected: _itemFullSiteVisit,
            title: "현장방문",
            contents: "1차 방문/2시간, 2차 방문/3시간",
            value: "990,000원",
            onChanged: (value) {
              _itemFullSiteVisit = value;

              if (!_itemFullSiteVisit) {
                _extraServiceCuration = false;
                _extraServiceInfo = false;
              }

              if (mounted) {
                setState(() {});
              }
            }),
        GoodsItem(
          isSelected: _itemFullConcertingReport,
          title: "공간 컨설팅 보고서 제공",
          contents: "7일(2차방문일 이후 영업일 기준)",
          value: "990,000원",
          onChanged: (value) {
            _itemFullConcertingReport = value;

            if (value == true) {
              if (!_itemFullSiteVisit) {
                _extraServiceCuration = false;
                _extraServiceInfo = false;
              }
            }

            if (mounted) {
              setState(() {});
            }
          },
        ),
      ],
    );
  }

  Widget buildExtraServices() {
    return Column(
      children: [
        Row(
          children: [
            const InputTitle(
              title: "부가서비스",
              isRequired: false,
              textFontSize: 15,
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                if (_extraServiceCuration && _extraServiceInfo) {
                  _extraServiceCuration = false;
                  _extraServiceInfo = false;
                } else {
                  _extraServiceCuration = true;
                  _extraServiceInfo = true;
                }

                if (mounted) {
                  setState(() {});
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  (_extraServiceCuration && _extraServiceInfo) ? "전체해제" : "전체선택",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF10A2DC),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ExtraServiceItem(
          isSelected: _extraServiceCuration,
          title: "수납용품 큐레이션 서비스",
          value: "330,000원",
          onChanged: (value) {
            _extraServiceCuration = value;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        ExtraServiceItem(
          isSelected: _extraServiceInfo,
          title: "수납용품 정보 제공",
          value: "220,000원",
          onChanged: (value) {
            _extraServiceInfo = value;
            if (mounted) {
              setState(() {});
            }
          },
        ),
      ],
    );
  }

  Widget buildPriceSum() {
    int totalPrice = 0;

    if (_itemRefrigerator) {
      totalPrice += 330000;
    }

    if (_itemKitchen) {
      totalPrice += 330000;
    }

    if (_itemHall) {
      totalPrice += 330000;
    }

    if (_itemStorage) {
      totalPrice += 330000;
    }

    if (_itemWorkInRefrigerator) {
      totalPrice += 330000;
    }

    if (_itemGuestRoom) {
      totalPrice += 330000;
    }

    if (_itemFullSiteVisit) {
      totalPrice += 990000;
    }

    if (_itemFullConcertingReport) {
      totalPrice += 990000;
    }

    if (_extraServiceCuration) {
      totalPrice += 330000;
    }

    if (_extraServiceInfo) {
      totalPrice += 220000;
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF4FAFF),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 18,
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    "선택한 상품",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.0,
                      color: Color(0xFF10A2DC),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  _isConcertingPart ? "컨설팅 (부분)" : "컨설팅 (전체)",
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            color: const Color(0xFFE1EAF1),
          ),
          const SizedBox(height: 16),
          if (_itemRefrigerator) buildSumItem("냉장고", "330,000원"),
          if (_itemKitchen) buildSumItem("주방(냉장고 미포함)", "330,000원"),
          if (_itemHall) buildSumItem("홀 티카", "330,000원"),
          if (_itemStorage) buildSumItem("창고", "330,000원"),
          if (_itemWorkInRefrigerator) buildSumItem("워크인 냉장고", "330,000원"),
          if (_itemGuestRoom) buildSumItem("객실", "330,000원"),
          if (_itemFullSiteVisit) buildSumItem("현장방문", "990,000원"),
          if (_itemFullConcertingReport) buildSumItem("공간 컨설팅 보고서 제공", "990,000원"),
          if (_extraServiceCuration) buildSumItem("수납용품 큐레이션 서비스", "330,000원"),
          if (_extraServiceInfo) buildSumItem("수납용품 정보 제공", "220,000원"),
          Container(
            alignment: Alignment.center,
            height: 18,
            child: Row(
              children: [
                const Text(
                  "합계",
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  " (VAT 포함)",
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.0,
                    color: Color(0xFF868C73),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      Utils().numberWithComma(totalPrice) + "원",
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container buildSumItem(String title, String price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      alignment: Alignment.center,
      height: 18,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                height: 1.0,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text(
            price,
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
}
