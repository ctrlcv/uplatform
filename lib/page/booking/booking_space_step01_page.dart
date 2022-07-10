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

import 'booking_space_step02_page.dart';

class BookingSpaceStep01Page extends StatefulWidget {
  const BookingSpaceStep01Page({Key? key}) : super(key: key);

  static const routeName = '/BookingSpaceStep01Page';

  @override
  _BookingSpaceStep01PageState createState() => _BookingSpaceStep01PageState();
}

class _BookingSpaceStep01PageState extends State<BookingSpaceStep01Page> {
  final ScrollController _scrollController = ScrollController();

  String _address = "";
  String _addAddress = "";

  // 음식점 위생공간
  bool _isCleanSpaceShop = true;
  // 주거공간
  bool _isCleanSpaceHouse = false;

  // 음식점 위생공간 - 공간정리 대행서비스 (부분)
  bool _isShopServiceTypePart = false;
  // 음식점 위생공간 - 공간정리 대행서비스 (전체)
  bool _isShopServiceTypeTotal = false;

  // 주거공간 - 공간정리 컨설팅
  bool _isHouseCleanConcerting = false;
  // 주거공간 - 공간정리 대행서비스
  bool _isHouseCleanService = false;

  // 음식점 위생공간 - 공간정리 대행서비스 (부분) - 상품 - 냉장고
  bool _itemRefrigerator = false;
  // 음식점 위생공간 - 공간정리 대행서비스 (부분) - 상품 - 주방
  bool _itemKitchen = false;
  // 음식점 위생공간 - 공간정리 대행서비스 (부분) - 상품 - 홀 티카
  bool _itemHall = false;
  // 음식점 위생공간 - 공간정리 대행서비스 (부분) - 상품 - 창고
  bool _itemStorage = false;
  // 음식점 위생공간 - 공간정리 대행서비스 (부분) - 상품 - 워크인 냉장고
  bool _itemWorkInRefrigerator = false;
  // 음식점 위생공간 - 공간정리 대행서비스 (부분) - 상품 - 객실
  bool _itemGuestRoom = false;

  // 음식점 위생공간 - 공간정리 대행서비스 (전체) - 상품 - 현장방문
  bool _itemShopTotalSiteVisit = false;

  // 주거공간 - 공간정리 컨설팅 - 상품 - 현장방문
  bool _itemHouseConcertingVisit = false;
  // 주거공간 - 공간정리 컨설팅 - 상품 - 보고서 제공
  bool _itemHouseConcertingReport = false;

  // 주거공간 - 공간정리 대행서비스 - 상품 - 현장방문
  bool _itemHouseCleanVisit = false;

  // 주거공간 - 공간정리 컨설팅 - 부가서비스 - 큐레이션
  bool _houseConcertingExtraCuration = false;
  // 주거공간 - 공간정리 컨설팅 - 부가서비스 - 정보제공
  bool _houseConcertingExtraInfo = false;

  // 주거공간 - 공간정리 대행서비스 - 부가서비스 - 큐레이션
  bool _houseCleanExtraCuration = false;
  // 주거공간 - 공간정리 대행서비스 - 부가서비스 - 정보제공
  bool _houseCleanExtraInfo = false;

  Map<String, dynamic> _bookingParams = {};

  @override
  void initState() {
    super.initState();

    _bookingParams = Get.arguments;

    _address = _bookingParams['address'];
    _addAddress = _bookingParams['addaddress'];

    _isCleanSpaceShop = _bookingParams['_isCleanSpaceShop'];
    _isCleanSpaceHouse = _bookingParams['_isCleanSpaceHouse'];

    _isShopServiceTypePart = _bookingParams['_isShopServiceTypePart'];
    _isShopServiceTypeTotal = _bookingParams['_isShopServiceTypeTotal'];

    _isHouseCleanConcerting = _bookingParams['_isHouseCleanConcerting'];
    _isHouseCleanService = _bookingParams['_isHouseCleanService'];
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
                titleText: "공간정리 예약",
                cellHeight: 32,
                fontSize: 24,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 20),
              if (_isShopServiceTypePart) buildShopServicePartItems(),
              if (_isShopServiceTypeTotal) buildShopServiceTotalItems(),
              if (_isHouseCleanConcerting) buildHouseConcertingItems(),
              if (_isHouseCleanService) buildHouseCleanItems(),
              if (_isHouseCleanConcerting && _itemHouseConcertingVisit) buildHouseConcertingExtraItems(),
              if (_isHouseCleanService) buildHouseCleanExtraItems(),
              if (isActiveNextButton()) buildPriceSum(),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BorderRoundedButton(
                  text: "다음",
                  buttonColor: kMainColor,
                  active: isActiveNextButton(),
                  onPressed: () async {
                    if (_isShopServiceTypePart) {
                      if (!_itemRefrigerator &&
                          !_itemKitchen &&
                          !_itemHall &&
                          !_itemStorage &&
                          !_itemWorkInRefrigerator &&
                          !_itemGuestRoom) {
                        _scrollController.animateTo(_scrollController.position.minScrollExtent + 400,
                            duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
                        Get.snackbar('상품 미선택', "서비스 상품을 선택하세요",
                            snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                        return;
                      }
                    }

                    if (_isHouseCleanConcerting) {
                      if (!_itemHouseConcertingVisit && !_itemHouseConcertingReport) {
                        _scrollController.animateTo(_scrollController.position.minScrollExtent + 400,
                            duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
                        Get.snackbar('상품 미선택', "서비스 상품을 선택하세요",
                            snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                        return;
                      }
                    }

                    Map<String, dynamic> bookingParams = {};
                    bookingParams['reservation_type'] = "CR";

                    List<int> serviceIds = [];
                    int totalPrice = 0;
                    List<BookingItem> bookingItems = [];

                    if (_itemRefrigerator) {
                      serviceIds.add(21);
                      totalPrice += 880000;
                      bookingItems.add(BookingItem(type: "음식점 위생공간 - 공간정리 대행 서비스(부분)", title: "냉장고", detail: "방문 1회/4시간", price: 880000));
                    }

                    if (_itemKitchen) {
                      serviceIds.add(22);
                      totalPrice += 880000;
                      bookingItems.add(BookingItem(type: "음식점 위생공간 - 공간정리 대행 서비스(부분)", title: "주방(냉장고 미포함)", detail: "방문 1회/4시간", price: 880000));
                    }

                    if (_itemHall) {
                      serviceIds.add(23);
                      totalPrice += 880000;
                      bookingItems.add(BookingItem(type: "음식점 위생공간 - 공간정리 대행 서비스(부분)", title: "홀 티카", detail: "방문 1회/4시간", price: 880000));
                    }

                    if (_itemStorage) {
                      serviceIds.add(24);
                      totalPrice += 880000;
                      bookingItems.add(BookingItem(type: "음식점 위생공간 - 공간정리 대행 서비스(부분)", title: "창고", detail: "방문 1회/4시간", price: 880000));
                    }

                    if (_itemWorkInRefrigerator) {
                      serviceIds.add(25);
                      totalPrice += 880000;
                      bookingItems.add(BookingItem(type: "음식점 위생공간 - 공간정리 대행 서비스(부분)", title: "워크인 냉장고", detail: "방문 1회/4시간", price: 880000));
                    }

                    if (_itemGuestRoom) {
                      serviceIds.add(26);
                      totalPrice += 880000;
                      bookingItems.add(BookingItem(type: "음식점 위생공간 - 공간정리 대행 서비스(부분)", title: "객실", detail: "방문 1회/4시간", price: 880000));
                    }

                    if (_itemShopTotalSiteVisit) {
                      serviceIds.add(27);
                      totalPrice += 2900000;
                      bookingItems.add(BookingItem(type: "음식점 위생공간 - 공간정리 대행 서비스(전체)", title: "현장방문", detail: "1차 방문/3시간, 2차 방문/8시간", price: 2900000));
                    }

                    if (_itemHouseConcertingVisit) {
                      serviceIds.add(28);
                      totalPrice += 550000;
                      bookingItems.add(BookingItem(type: "주거공간 - 공간정리 컨설팅", title: "현장방문", detail: "1차 방문/3시간, 2차 방문/2시간", price: 550000));
                    }

                    if (_itemHouseConcertingReport) {
                      serviceIds.add(29);
                      totalPrice += 550000;
                      bookingItems.add(BookingItem(type: "주거공간 - 공간정리 컨설팅", title: "공간 컨설팅 보고서 제공", detail: "7일(2차 방문일 이후 영업일 기준)", price: 550000));
                    }

                    if (_itemHouseCleanVisit) {
                      serviceIds.add(30);
                      totalPrice += 2420000;
                      bookingItems.add(BookingItem(type: "주거공간 - 공간정리 대행서비스", title: "현장방문", detail: "1차 방문/3시간, 2차 방문/8시간", price: 2420000));
                    }

                    if (_houseConcertingExtraCuration) {
                      serviceIds.add(31);
                      totalPrice += 220000;
                      bookingItems.add(BookingItem(type: "부가서비스", title: "수납용품 큐레이션 서비스", detail: "", price: 220000));
                    }

                    if (_houseConcertingExtraInfo) {
                      serviceIds.add(32);
                      totalPrice += 110000;
                      bookingItems.add(BookingItem(type: "부가서비스", title: "수납용품 정보 제공", detail: "", price: 110000));
                    }

                    if (_houseCleanExtraCuration) {
                      serviceIds.add(33);
                      totalPrice += 0;
                      bookingItems.add(BookingItem(type: "부가서비스", title: "수납용품 큐레이션 서비스", detail: "", price: 0));
                    }

                    if (_houseCleanExtraInfo) {
                      serviceIds.add(34);
                      totalPrice += 110000;
                      bookingItems.add(BookingItem(type: "부가서비스", title: "수납용품 정보 제공", detail: "", price: 110000));
                    }

                    String serviceIdsStr = (serviceIds.toString()).replaceAll("[", "").replaceAll("]", "").trim();

                    bookingParams['address'] = _address;
                    bookingParams['addaddress'] = _addAddress;

                    bookingParams['services'] = serviceIdsStr;
                    bookingParams['bookingitems'] = bookingItems;

                    bookingParams['price'] = totalPrice;

                    Get.toNamed(BookingSpaceStep02Page.routeName, arguments: bookingParams);
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
    if (_itemRefrigerator || _itemKitchen || _itemHall || _itemStorage || _itemWorkInRefrigerator || _itemGuestRoom) {
      return true;
    }

    if (_itemShopTotalSiteVisit || _itemHouseCleanVisit) {
      return true;
    }

    if (_itemHouseConcertingVisit || _itemHouseConcertingReport) {
      return true;
    }

    return false;
  }

  Widget buildShopServicePartItems() {
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
            const SizedBox(height: 32),
          ],
        ),
        const SizedBox(height: 8),
        GoodsItem(
            isSelected: _itemRefrigerator,
            title: "냉장고",
            contents: "방문1회/4시간",
            value: "880,000원",
            onChanged: (value) {
              _itemRefrigerator = value;
              if (mounted) {
                setState(() {});
              }
            }),
        GoodsItem(
          isSelected: _itemKitchen,
          title: "주방(냉장고 미포함)",
          contents: "방문1회/4시간",
          value: "880,000원",
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
          contents: "방문1회/4시간",
          value: "880,000원",
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
          contents: "방문1회/4시간",
          value: "880,000원",
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
          contents: "방문1회/4시간",
          value: "880,000원",
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
          contents: "방문1회/4시간",
          value: "880,000원",
          onChanged: (value) {
            _itemGuestRoom = value;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget buildShopServiceTotalItems() {
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
          ],
        ),
        const SizedBox(height: 8),
        GoodsItem(
          isSelected: _itemShopTotalSiteVisit,
          title: "현장방문",
          contents: "1차 방문/3시간, 2차 방문/8시간",
          value: "2,900,000원",
          onChanged: (value) {
            _itemShopTotalSiteVisit = true;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget buildHouseConcertingItems() {
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
                if (_itemHouseConcertingVisit && _itemHouseConcertingReport) {
                  _itemHouseConcertingVisit = false;
                  _itemHouseConcertingReport = false;
                } else {
                  _itemHouseConcertingVisit = true;
                  _itemHouseConcertingReport = true;
                }

                if (mounted) {
                  setState(() {});
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  (_itemHouseConcertingVisit && _itemHouseConcertingReport) ? "전체해제" : "전체선택",
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
            isSelected: _itemHouseConcertingVisit,
            title: "현장방문",
            contents: "1차 방문/3시간, 2차 방문/2시간",
            value: "550,000원",
            onChanged: (value) {
              _itemHouseConcertingVisit = value;

              if (!_itemHouseConcertingVisit) {
                _houseConcertingExtraCuration = false;
                _houseConcertingExtraInfo = false;
              }

              if (mounted) {
                setState(() {});
              }
            }),
        GoodsItem(
          isSelected: _itemHouseConcertingReport,
          title: "공간 컨설팅 보고서 제공",
          contents: "7일(2차방문일 이후 영업일 기준)",
          value: "550,000원",
          onChanged: (value) {
            _itemHouseConcertingReport = value;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget buildHouseCleanItems() {
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
          ],
        ),
        const SizedBox(height: 8),
        GoodsItem(
          isSelected: _itemHouseCleanVisit,
          title: "현장방문",
          contents: "1차 방문/3시간, 2차 방문/8시간",
          value: "2,420,000원",
          onChanged: (value) {
            _itemHouseCleanVisit = !_itemHouseCleanVisit;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget buildHouseConcertingExtraItems() {
    return Column(
      children: [
        kHorizontalLine,
        const SizedBox(height: 32),
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
                if (_houseConcertingExtraCuration && _houseConcertingExtraInfo) {
                  _houseConcertingExtraCuration = false;
                  _houseConcertingExtraInfo = false;
                } else {
                  _houseConcertingExtraCuration = true;
                  _houseConcertingExtraInfo = true;
                }

                if (mounted) {
                  setState(() {});
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  (_houseConcertingExtraCuration && _houseConcertingExtraInfo) ? "전체해제" : "전체선택",
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
          isSelected: _houseConcertingExtraCuration,
          title: "수납용품 큐레이션 서비스",
          value: "220,000원",
          onChanged: (value) {
            _houseConcertingExtraCuration = value;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        ExtraServiceItem(
          isSelected: _houseConcertingExtraInfo,
          title: "수납용품 정보 제공",
          value: "110,000원",
          onChanged: (value) {
            _houseConcertingExtraInfo = value;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget buildHouseCleanExtraItems() {
    return Column(
      children: [
        kHorizontalLine,
        const SizedBox(height: 32),
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
                if (_houseCleanExtraCuration && _houseCleanExtraInfo) {
                  _houseCleanExtraCuration = false;
                  _houseCleanExtraInfo = false;
                } else {
                  _houseCleanExtraCuration = true;
                  _houseCleanExtraInfo = true;
                }

                if (mounted) {
                  setState(() {});
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  (_houseCleanExtraCuration && _houseCleanExtraInfo) ? "전체해제" : "전체선택",
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
        GestureDetector(
          onTap: () {
            _houseCleanExtraCuration = !_houseCleanExtraCuration;
            if (mounted) {
              setState(() {});
            }
          },
          child: Container(
            height: 68,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: _houseCleanExtraCuration ? kSelectColor : Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: _houseCleanExtraCuration ? kSelectColor : const Color(0xFFE4E7ED),
                width: 1,
              ),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "수납용품 큐레이션 서비스",
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.2,
                          color: _houseCleanExtraCuration ? Colors.white : const Color(0xFF686C73),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(
                      "220,000원",
                      style: TextStyle(
                        fontSize: 15,
                        decoration: TextDecoration.lineThrough,
                        height: 1.2,
                        color: _houseCleanExtraCuration ? Colors.white : const Color(0xFF686C73),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(child: Container()),
                    Text(
                      "할인 0원",
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.2,
                        color: _houseCleanExtraCuration ? Colors.white : const Color(0xFF686C73),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        GoodsItem(
          isSelected: _houseCleanExtraInfo,
          title: "수납용품 정보 제공",
          contents: "  ",
          value: "110,000원",
          onChanged: (value) {
            _houseCleanExtraInfo = value;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget buildPriceSum() {
    int totalPrice = 0;

    if (_itemRefrigerator) {
      totalPrice += 880000;
    }

    if (_itemKitchen) {
      totalPrice += 880000;
    }

    if (_itemHall) {
      totalPrice += 880000;
    }

    if (_itemStorage) {
      totalPrice += 880000;
    }

    if (_itemWorkInRefrigerator) {
      totalPrice += 880000;
    }

    if (_itemGuestRoom) {
      totalPrice += 880000;
    }

    if (_itemShopTotalSiteVisit) {
      totalPrice += 2900000;
    }

    if (_itemHouseConcertingVisit) {
      totalPrice += 550000;
    }

    if (_itemHouseConcertingReport) {
      totalPrice += 550000;
    }

    if (_itemHouseCleanVisit) {
      totalPrice += 2420000;
    }

    if (_houseConcertingExtraCuration) {
      totalPrice += 220000;
    }

    if (_houseConcertingExtraInfo) {
      totalPrice += 110000;
    }

    if (_houseCleanExtraCuration) {
      totalPrice += 0;
    }

    if (_houseCleanExtraInfo) {
      totalPrice += 110000;
    }

    return Column(
      children: [
        kHorizontalLine,
        const SizedBox(height: 32),
        Container(
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
                      (_isCleanSpaceShop && _isShopServiceTypePart)
                          ? "공간정리 대행 서비스(부분)"
                          : (_isCleanSpaceShop && _isShopServiceTypePart)
                              ? "공간정리 대행 서비스(전체)"
                              : (_isCleanSpaceHouse && _isHouseCleanConcerting)
                                  ? "공간정리 컨설팅"
                                  : (_isCleanSpaceHouse && _isHouseCleanService)
                                      ? "공간정리 대행서비스"
                                      : "",
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
              if (_itemRefrigerator) buildSumItem("냉장고", "880,000원"),
              if (_itemKitchen) buildSumItem("주방(냉장고 미포함)", "880,000원"),
              if (_itemHall) buildSumItem("홀 티카", "880,000원"),
              if (_itemStorage) buildSumItem("창고", "880,000원"),
              if (_itemWorkInRefrigerator) buildSumItem("워크인 냉장고", "880,000원"),
              if (_itemGuestRoom) buildSumItem("객실", "880,000원"),
              if (_itemShopTotalSiteVisit) buildSumItem("현장방문", "2,900,000원"),
              if (_itemHouseConcertingVisit) buildSumItem("현장방문", "550,000원"),
              if (_itemHouseConcertingReport) buildSumItem("공간 컨설팅 보고서 제공", "550,000원"),
              if (_itemHouseCleanVisit) buildSumItem("현장방문", "2,420,000원"),
              if (_houseConcertingExtraCuration) buildSumItem("수납용품 큐레이션 서비스", "220,000원"),
              if (_houseConcertingExtraInfo) buildSumItem("수납용품 정보 제공", "110,000원"),
              if (_houseCleanExtraCuration) buildSumItem("수납용품 큐레이션 서비스", "0원"),
              if (_houseCleanExtraInfo) buildSumItem("수납용품 정보 제공", "110,000원"),
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
        ),
        const SizedBox(height: 32),
      ],
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
