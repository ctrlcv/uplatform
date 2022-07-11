import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/constants/constants.dart';

import '../../components/custom_appbar.dart';
import '../../components/menu_item.dart' as Mi;
import '../../components/text_title.dart';
import '../signin/terms_page.dart';

class ServiceTermsPage extends StatefulWidget {
  const ServiceTermsPage({Key? key}) : super(key: key);

  static const routeName = '/ServiceTermsPage';

  @override
  _ServiceTermsPageState createState() => _ServiceTermsPageState();
}

class _ServiceTermsPageState extends State<ServiceTermsPage> {
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
              titleText: "서비스 약관",
              cellHeight: 32,
              fontSize: 24,
              fontColor: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 28),
            kHorizontalLine,
            const SizedBox(height: 20),
            Mi.MenuItem(
              iconData: Icons.privacy_tip_outlined,
              title: "서비스 약관",
              isNoIcon: true,
              onPressed: () {
                Get.toNamed(TermsPage.routeName, arguments: "서비스 이용약관");
              },
            ),
            Mi.MenuItem(
              iconData: Icons.privacy_tip_outlined,
              title: "개인정보 처리방침",
              isNoIcon: true,
              onPressed: () {
                Get.toNamed(TermsPage.routeName, arguments: "개인정보 처리방침");
              },
            ),
          ],
        ),
      ),
    );
  }
}
