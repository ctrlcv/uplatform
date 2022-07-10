import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/dot_text_view.dart';
import 'package:uplatform/components/extra_service_item.dart';
import 'package:uplatform/components/goods_item.dart';
import 'package:uplatform/components/input_title.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/booking_model.dart';
import 'package:uplatform/utils/utils.dart';

import 'booking_education_step02_page.dart';

class BookingEducationStep01Page extends StatefulWidget {
  const BookingEducationStep01Page({Key? key}) : super(key: key);

  static const routeName = '/BookingEducationStep01Page';

  @override
  _BookingEducationStep01PageState createState() => _BookingEducationStep01PageState();
}

class _BookingEducationStep01PageState extends State<BookingEducationStep01Page> {
  final ScrollController _scrollController = ScrollController();

  // 공간정리 코칭 서비스
  bool _coachServiceSpace = false;

  // 주거공간 코칭 서비스
  bool _coachServiceHouse = false;

  // 공간정리 코칭 서비스 - 상품
  bool _coachSpaceProcessTotal = false;
  bool _coachSpaceProcess1 = false;
  bool _coachSpaceProcess2 = false;
  bool _coachSpaceProcess3 = false;
  bool _coachSpaceProcess4 = false;
  bool _coachSpaceProcess5 = false;

  // 주거공간 코칭 서비스 - 서비스 종류
  bool _houseServiceTypeConcerting = false;
  bool _houseServiceTypeClean = false;
  bool _houseServiceTypeTimeService = false;

  // 주거공간 코칭 서비스 - 1인 가구 주거공간 정리 컨설팅 - 상품 : 현장방문
  bool _houseConcertingVisit = false;
  // 주거공간 코칭 서비스 - 1인 가구 주거공간 정리 컨설팅 - 상품 : 컨설팅 보고서
  bool _houseConcertingReport = false;

  // 주거공간 코칭 서비스 - 1인 가구 주거공간 정리 대행서비스 - 상품 : 현장방문
  bool _houseCleanVisit = false;

  // 주거공간 코칭 서비스 - 1인 가구 주거공간 정리 대행서비스 - 부가서비스 : 수납용품 큐레이션 서비스
  bool _houseCleanExtraCuration = false;

  // 주거공간 코칭 서비스 - 1인 가구 주거공간 정리 타임서비스 - 상품
  bool _houseTime2people3Time = false;
  bool _houseTime2people4Time = false;
  bool _houseTime2people5Time = false;
  bool _houseTime2people6Time = false;
  bool _houseTime2people7Time = false;

  Map<String, dynamic> _bookingParams = {};

  @override
  void initState() {
    super.initState();

    _bookingParams = Get.arguments;

    _coachServiceSpace = _bookingParams['coachServiceSpace'];
    _coachServiceHouse = _bookingParams['coachServiceHouse'];

    _houseServiceTypeConcerting = _bookingParams['houseServiceTypeConcerting'];
    _houseServiceTypeClean = _bookingParams['houseServiceTypeClean'];
    _houseServiceTypeTimeService = _bookingParams['houseServiceTypeTimeService'];
  }

  @override
  void dispose() {
    super.dispose();
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
                titleText: "정리 교육 예약",
                cellHeight: 32,
                fontSize: 24,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 40),
              if (_coachServiceSpace) buildSpaceCoachServiceItems(),
              if (_houseServiceTypeConcerting) buildHouseConcertingItems(),
              if (_houseServiceTypeClean) buildHouseCleanItems(),
              if (_houseServiceTypeTimeService) buildHouseTimeServiceItems(),
              if (_houseServiceTypeClean) buildHouseCleanExtra(),
              if (isActiveNextButton()) buildPriceSum(),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BorderRoundedButton(
                  text: "다음",
                  buttonColor: kMainColor,
                  active: isActiveNextButton(),
                  onPressed: () async {
                    if (_coachServiceSpace) {
                      if (!_coachSpaceProcessTotal) {
                        _scrollController.animateTo(_scrollController.position.minScrollExtent,
                            duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
                        Get.snackbar('상품 미선택', "상품을 선택하세요",
                            snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                        return;
                      }
                    }

                    if (_coachServiceHouse) {
                      if (!_houseServiceTypeConcerting && !_houseServiceTypeClean && !_houseServiceTypeTimeService) {
                        _scrollController.animateTo(_scrollController.position.minScrollExtent,
                            duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
                        Get.snackbar('서비스 종류 미선택', "서비스 종류를 선택하세요",
                            snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                        return;
                      }

                      if (_houseServiceTypeConcerting) {
                        if (!_houseConcertingVisit && !_houseConcertingReport) {
                          _scrollController.animateTo(_scrollController.position.minScrollExtent + 400,
                              duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
                          Get.snackbar('상품 미선택', "상품을 선택하세요",
                              snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                          return;
                        }
                      }

                      if (_houseServiceTypeTimeService) {
                        if (!_houseTime2people3Time &&
                            !_houseTime2people4Time &&
                            !_houseTime2people5Time &&
                            !_houseTime2people6Time &&
                            !_houseTime2people7Time) {
                          _scrollController.animateTo(_scrollController.position.minScrollExtent + 400,
                              duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
                          Get.snackbar('상품 미선택', "상품을 선택하세요",
                              snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                          return;
                        }
                      }
                    }

                    Map<String, dynamic> bookingParams = {};

                    List<int> serviceIds = [];
                    int totalPrice = 0;
                    List<BookingItem> bookingItems = [];

                    if (_coachSpaceProcessTotal) {
                      serviceIds.add(41);
                      totalPrice += 2500000;
                      bookingItems.add(BookingItem(type: "공간정리 코칭 서비스", title: "1단계 ~ 5단계 프로세스", detail: "공간 멘토 1인", price: 2500000));
                    }

                    // if (_coachSpaceProcess1) {
                    //   serviceIds.add(42);
                    //   totalPrice += 500000;
                    //   bookingItems.add(BookingItem(type: "공간정리 코칭 서비스", title: "1단계 - 코칭 목표 설정", detail: "1회기/2시간", price: 500000));
                    // }
                    //
                    // if (_coachSpaceProcess2) {
                    //   serviceIds.add(43);
                    //   totalPrice += 500000;
                    //   bookingItems.add(BookingItem(type: "공간정리 코칭 서비스", title: "2단계 - 물건 분류 방법 배우기", detail: "2회기/2시간", price: 500000));
                    // }
                    //
                    // if (_coachSpaceProcess3) {
                    //   serviceIds.add(44);
                    //   totalPrice += 500000;
                    //   bookingItems.add(BookingItem(type: "공간정리 코칭 서비스", title: "3단계 - 물건 소유의 기준 정하기", detail: "3회기/2시간", price: 500000));
                    // }
                    //
                    // if (_coachSpaceProcess4) {
                    //   serviceIds.add(45);
                    //   totalPrice += 500000;
                    //   bookingItems.add(BookingItem(type: "공간정리 코칭 서비스", title: "4단계 - 공간 기획하기", detail: "4회기/2시간", price: 500000));
                    // }
                    //
                    // if (_coachSpaceProcess5) {
                    //   serviceIds.add(46);
                    //   totalPrice += 500000;
                    //   bookingItems.add(BookingItem(type: "공간정리 코칭 서비스", title: "5단계 - 공간 정리하기", detail: "5회기/2시간", price: 500000));
                    // }

                    if (_houseConcertingVisit) {
                      serviceIds.add(47);
                      totalPrice += 110000;
                      bookingItems.add(BookingItem(type: "주거공간 코칭 서비스 - 정리 컨설팅", title: "현장방문 또는 화상 음성미팅", detail: "1차 방문/1시간", price: 110000));
                    }

                    if (_houseConcertingReport) {
                      serviceIds.add(48);
                      totalPrice += 110000;
                      bookingItems.add(BookingItem(type: "주거공간 코칭 서비스 - 정리 컨설팅", title: "공간 컨설팅 보고서 제공", detail: "", price: 110000));
                    }

                    if (_houseCleanVisit) {
                      serviceIds.add(49);
                      totalPrice += 590000;
                      bookingItems.add(BookingItem(type: "주거공간 코칭 서비스 - 정리 대행서비스", title: "1차 현장방문 또는 화상미팅/1시간\n2차 현장방문/8시간", detail: "", price: 590000));
                    }

                    if (_houseCleanExtraCuration) {
                      serviceIds.add(50);
                      totalPrice += 0;
                      bookingItems.add(BookingItem(type: "부가서비스", title: "수납용품 큐레이션 서비스", detail: "", price: 0));
                    }

                    if (_houseTime2people3Time) {
                      serviceIds.add(51);
                      totalPrice += 198000;
                      bookingItems.add(BookingItem(type: "주거공간 코칭 서비스 - 정리 타임서비스", title: "2인 - 3시간", detail: "", price: 198000));
                    }

                    if (_houseTime2people4Time) {
                      serviceIds.add(52);
                      totalPrice += 264000;
                      bookingItems.add(BookingItem(type: "주거공간 코칭 서비스 - 정리 타임서비스", title: "2인 - 4시간", detail: "", price: 264000));
                    }

                    if (_houseTime2people5Time) {
                      serviceIds.add(53);
                      totalPrice += 330000;
                      bookingItems.add(BookingItem(type: "주거공간 코칭 서비스 - 정리 타임서비스", title: "2인 - 5시간", detail: "", price: 330000));
                    }

                    if (_houseTime2people6Time) {
                      serviceIds.add(54);
                      totalPrice += 396000;
                      bookingItems.add(BookingItem(type: "주거공간 코칭 서비스 - 정리 타임서비스", title: "2인 - 6시간", detail: "", price: 396000));
                    }

                    if (_houseTime2people7Time) {
                      serviceIds.add(55);
                      totalPrice += 462000;
                      bookingItems.add(BookingItem(type: "주거공간 코칭 서비스 - 정리 타임서비스", title: "2인 - 7시간", detail: "", price: 462000));
                    }

                    String serviceIdsStr = (serviceIds.toString()).replaceAll("[", "").replaceAll("]", "").trim();

                    bookingParams['services'] = serviceIdsStr;
                    bookingParams['price'] = totalPrice;
                    bookingParams['bookingItems'] = bookingItems;

                    Get.toNamed(BookingEducationStep02Page.routeName, arguments: bookingParams);
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
    if (_coachSpaceProcessTotal) {
      return true;
    }

    if (_houseConcertingVisit || _houseConcertingReport) {
      return true;
    }

    if (_houseCleanVisit) {
      return true;
    }

    if (_houseTime2people3Time ||
        _houseTime2people4Time ||
        _houseTime2people5Time ||
        _houseTime2people6Time ||
        _houseTime2people7Time) {
      return true;
    }

    return false;
  }

  Widget buildSpaceCoachServiceItems() {
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
          isSelected: _coachSpaceProcessTotal,
          title: "1단계 ~ 5단계 프로세스",
          contents: "공간 멘토 1인",
          value: "2,500,000원",
          onChanged: (value) {
            if (value) {
              _coachSpaceProcessTotal = true;
              _coachSpaceProcess1 = true;
              _coachSpaceProcess2 = true;
              _coachSpaceProcess3 = true;
              _coachSpaceProcess4 = true;
              _coachSpaceProcess5 = true;
            } else {
              _coachSpaceProcessTotal = false;
              _coachSpaceProcess1 = false;
              _coachSpaceProcess2 = false;
              _coachSpaceProcess3 = false;
              _coachSpaceProcess4 = false;
              _coachSpaceProcess5 = false;
            }

            if (mounted) {
              setState(() {});
            }
          },
        ),
        GoodsItem(
          isSelected: _coachSpaceProcess1,
          title: "1단계 - 코칭 목표 설정",
          contents: "1회기/2시간",
          value: "500,000원",
          selectColor: const Color(0xFFBEBEBF),
          onChanged: (value) {
            if (value) {
              _coachSpaceProcessTotal = true;
              _coachSpaceProcess1 = true;
              _coachSpaceProcess2 = true;
              _coachSpaceProcess3 = true;
              _coachSpaceProcess4 = true;
              _coachSpaceProcess5 = true;
            } else {
              _coachSpaceProcessTotal = false;
              _coachSpaceProcess1 = false;
              _coachSpaceProcess2 = false;
              _coachSpaceProcess3 = false;
              _coachSpaceProcess4 = false;
              _coachSpaceProcess5 = false;
            }

            if (mounted) {
              setState(() {});
            }
          },
        ),
        GoodsItem(
          isSelected: _coachSpaceProcess2,
          title: "2단계 - 물건 분류 방법 배우기",
          contents: "2회기/2시간",
          value: "500,000원",
          selectColor: const Color(0xFFBEBEBF),
          onChanged: (value) {
            if (value) {
              _coachSpaceProcessTotal = true;
              _coachSpaceProcess1 = true;
              _coachSpaceProcess2 = true;
              _coachSpaceProcess3 = true;
              _coachSpaceProcess4 = true;
              _coachSpaceProcess5 = true;
            } else {
              _coachSpaceProcessTotal = false;
              _coachSpaceProcess1 = false;
              _coachSpaceProcess2 = false;
              _coachSpaceProcess3 = false;
              _coachSpaceProcess4 = false;
              _coachSpaceProcess5 = false;
            }

            if (mounted) {
              setState(() {});
            }
          },
        ),
        GoodsItem(
          isSelected: _coachSpaceProcess3,
          title: "3단계 - 물건 소유의 기준 정하기",
          contents: "3회기/2시간",
          value: "500,000원",
          selectColor: const Color(0xFFBEBEBF),
          onChanged: (value) {
            if (value) {
              _coachSpaceProcessTotal = true;
              _coachSpaceProcess1 = true;
              _coachSpaceProcess2 = true;
              _coachSpaceProcess3 = true;
              _coachSpaceProcess4 = true;
              _coachSpaceProcess5 = true;
            } else {
              _coachSpaceProcessTotal = false;
              _coachSpaceProcess1 = false;
              _coachSpaceProcess2 = false;
              _coachSpaceProcess3 = false;
              _coachSpaceProcess4 = false;
              _coachSpaceProcess5 = false;
            }

            if (mounted) {
              setState(() {});
            }
          },
        ),
        GoodsItem(
          isSelected: _coachSpaceProcess4,
          title: "4단계 - 공간 기획하기",
          contents: "4회기/2시간",
          value: "500,000원",
          selectColor: const Color(0xFFBEBEBF),
          onChanged: (value) {
            if (value) {
              _coachSpaceProcessTotal = true;
              _coachSpaceProcess1 = true;
              _coachSpaceProcess2 = true;
              _coachSpaceProcess3 = true;
              _coachSpaceProcess4 = true;
              _coachSpaceProcess5 = true;
            } else {
              _coachSpaceProcessTotal = false;
              _coachSpaceProcess1 = false;
              _coachSpaceProcess2 = false;
              _coachSpaceProcess3 = false;
              _coachSpaceProcess4 = false;
              _coachSpaceProcess5 = false;
            }

            if (mounted) {
              setState(() {});
            }
          },
        ),
        GoodsItem(
          isSelected: _coachSpaceProcess5,
          title: "5단계 - 공간 정리하기",
          contents: "5회기/2시간",
          value: "500,000원",
          selectColor: const Color(0xFFBEBEBF),
          onChanged: (value) {
            if (value) {
              _coachSpaceProcessTotal = true;
              _coachSpaceProcess1 = true;
              _coachSpaceProcess2 = true;
              _coachSpaceProcess3 = true;
              _coachSpaceProcess4 = true;
              _coachSpaceProcess5 = true;
            } else {
              _coachSpaceProcessTotal = false;
              _coachSpaceProcess1 = false;
              _coachSpaceProcess2 = false;
              _coachSpaceProcess3 = false;
              _coachSpaceProcess4 = false;
              _coachSpaceProcess5 = false;
            }

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
          ],
        ),
        const SizedBox(height: 8),
        GoodsItem(
          isSelected: _houseConcertingVisit,
          title: "현장방문 또는 화상/음성 미팅",
          contents: "1차 방문/1시간",
          value: "110,000원",
          onChanged: (value) {
            _houseConcertingVisit = !_houseConcertingVisit;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        GoodsItem(
          isSelected: _houseConcertingReport,
          title: "공간 컨설팅 보고서 제공",
          contents: " ",
          value: "110,000원",
          onChanged: (value) {
            _houseConcertingReport = !_houseConcertingReport;
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
        GestureDetector(
          onTap: () {
            _houseCleanVisit = !_houseCleanVisit;
            if (mounted) {
              setState(() {});
            }
          },
          child: Container(
            height: 68,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: _houseCleanVisit ? kSelectColor : Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: _houseCleanVisit ? kSelectColor : const Color(0xFFE4E7ED),
                width: 1,
              ),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 22,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "1차 현장방문 또는 화상 미팅/1시간",
                          style: TextStyle(
                            fontSize: 15,
                            color: _houseCleanVisit ? Colors.white : const Color(0xFF686C73),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        "590,000원",
                        style: TextStyle(
                          fontSize: 15,
                          color: _houseCleanVisit ? Colors.white : const Color(0xFF686C73),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  height: 22,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "2차 현장방문/8시간",
                    style: TextStyle(
                      fontSize: 15,
                      color: _houseCleanVisit ? Colors.white : const Color(0xFF686C73),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget buildHouseTimeServiceItems() {
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
        ExtraServiceItem(
          isSelected: _houseTime2people3Time,
          title: "2인 - 3시간",
          value: "198,000원",
          onChanged: (value) {
            _houseTime2people3Time = value;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        ExtraServiceItem(
          isSelected: _houseTime2people4Time,
          title: "2인 - 4시간",
          value: "264,000원",
          onChanged: (value) {
            _houseTime2people4Time = value;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        ExtraServiceItem(
          isSelected: _houseTime2people5Time,
          title: "2인 - 5시간",
          value: "330,000원",
          onChanged: (value) {
            _houseTime2people5Time = value;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        ExtraServiceItem(
          isSelected: _houseTime2people6Time,
          title: "2인 - 6시간",
          value: "396,000원",
          onChanged: (value) {
            _houseTime2people6Time = value;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        ExtraServiceItem(
          isSelected: _houseTime2people7Time,
          title: "2인 - 7시간",
          value: "462,000원",
          onChanged: (value) {
            _houseTime2people7Time = value;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget buildHouseCleanExtra() {
    return Column(
      children: [
        kHorizontalLine,
        const SizedBox(height: 32),
        Row(
          children: [
            const InputTitle(
              title: "부가서비스",
              isRequired: true,
              textFontSize: 15,
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
            Expanded(child: Container()),
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
                          height: 1.3,
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
                        height: 1.3,
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
                        height: 1.3,
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
        const SizedBox(height: 32),
      ],
    );
  }

  Widget buildPriceSum() {
    int totalPrice = 0;

    if (_coachSpaceProcessTotal) {
      totalPrice += 2500000;
    }

    // if (_coachSpaceProcess1) {
    //   totalPrice += 500000;
    // }
    //
    // if (_coachSpaceProcess2) {
    //   totalPrice += 500000;
    // }
    //
    // if (_coachSpaceProcess3) {
    //   totalPrice += 500000;
    // }
    //
    // if (_coachSpaceProcess4) {
    //   totalPrice += 500000;
    // }
    //
    // if (_coachSpaceProcess5) {
    //   totalPrice += 500000;
    // }

    if (_houseConcertingVisit) {
      totalPrice += 110000;
    }

    if (_houseConcertingReport) {
      totalPrice += 110000;
    }

    if (_houseCleanVisit) {
      totalPrice += 590000;
    }

    if (_houseCleanExtraCuration) {
      totalPrice += 0;
    }

    if (_houseTime2people3Time) {
      totalPrice += 198000;
    }

    if (_houseTime2people4Time) {
      totalPrice += 264000;
    }

    if (_houseTime2people5Time) {
      totalPrice += 330000;
    }

    if (_houseTime2people6Time) {
      totalPrice += 396000;
    }

    if (_houseTime2people7Time) {
      totalPrice += 462000;
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
                      _coachServiceSpace
                          ? "공간정리 코칭 서비스"
                          : _houseServiceTypeConcerting
                              ? "1인 가구 주거공간 정리 컨설팅"
                              : _houseServiceTypeClean
                                  ? "1인 가구 주거공간 정리 대행서비스"
                                  : _houseServiceTypeTimeService
                                      ? "1인 가구 주거공간 정리 타임서비스"
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
              if (_coachSpaceProcessTotal) buildSumItem("1단계 ~ 5단계 프로세스", "2,500,000원"),
              // if (_coachSpaceProcess1) buildSumItem("1단계 - 코칭 목표 설정", "500,000원"),
              // if (_coachSpaceProcess2) buildSumItem("2단계 - 물건 분류 방법 배우기", "500,000원"),
              // if (_coachSpaceProcess3) buildSumItem("3단계 - 물건 소유의 기준 정하기", "500,000원"),
              // if (_coachSpaceProcess4) buildSumItem("4단계 - 공간 기획하기", "500,000원"),
              // if (_coachSpaceProcess5) buildSumItem("5단계 - 공간 정리하기", "500,000원"),
              if (_houseConcertingVisit) buildSumItem("현장방문 또는 화상 음성미팅", "110,000원"),
              if (_houseConcertingReport) buildSumItem("공간 컨설팅 보고서 제공", "110,000원"),
              if (_houseCleanVisit) buildSumItem("1차 현장방문 또는 화상미팅/1시간", "590,000원"),
              if (_houseCleanExtraCuration) buildSumItem("수납용품 큐레이션 서비스", "0원"),
              if (_houseTime2people3Time) buildSumItem("2인 - 3시간", "198,000원"),
              if (_houseTime2people4Time) buildSumItem("2인 - 4시간", "264,000원"),
              if (_houseTime2people5Time) buildSumItem("2인 - 5시간", "330,000원"),
              if (_houseTime2people6Time) buildSumItem("2인 - 6시간", "396,000원"),
              if (_houseTime2people6Time) buildSumItem("2인 - 7시간", "462,000원"),
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
