import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/text_title.dart';

import 'booking_education_page.dart';
import 'booking_restaurant_page.dart';
import 'booking_space_page.dart';

class BookingTypePage extends StatefulWidget {
  const BookingTypePage({Key? key}) : super(key: key);

  static const routeName = '/BookingTypePage';

  @override
  _BookingTypePageState createState() => _BookingTypePageState();
}

class _BookingTypePageState extends State<BookingTypePage> {
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
              titleText: "예약하기",
              cellHeight: 32,
              fontSize: 24,
              fontColor: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 28),
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(BookingRestaurantPage.routeName);
                      },
                      child: Container(
                        height: 88,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.10),
                              offset: const Offset(
                                0.0,
                                3.0,
                              ),
                              blurRadius: 6.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "음식점 위생정리",
                                      style: TextStyle(
                                        fontSize: 18,
                                        height: 1.1,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "2시간/330,000원부터",
                                      style: TextStyle(
                                        fontSize: 13,
                                        height: 1.1,
                                        color: Color(0xFF898D93),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              "assets/images/booking_clean_restaurant.png",
                              width: 92,
                              height: 92,
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(BookingSpacePage.routeName);
                      },
                      child: Container(
                        height: 88,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.10),
                              offset: const Offset(
                                0.0,
                                3.0,
                              ),
                              blurRadius: 6.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 22,
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "공간정리",
                                      style: TextStyle(
                                        fontSize: 18,
                                        height: 1.1,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "4시간/550,000원부터",
                                      style: TextStyle(
                                        fontSize: 13,
                                        height: 1.1,
                                        color: Color(0xFF898D93),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              "assets/images/booking_clean_space.png",
                              width: 92,
                              height: 92,
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(BookingEducationPage.routeName);
                      },
                      child: Container(
                        height: 88,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.10),
                              offset: const Offset(
                                0.0,
                                3.0,
                              ),
                              blurRadius: 6.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "정리 교육",
                                      style: TextStyle(
                                        fontSize: 18,
                                        height: 1.1,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "1시간/110,000원부터",
                                      style: TextStyle(
                                        fontSize: 13,
                                        height: 1.1,
                                        color: Color(0xFF898D93),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              "assets/images/booking_clean_education.png",
                              width: 92,
                              height: 92,
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
