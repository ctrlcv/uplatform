import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/menu_item.dart' as Mi;
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/user_model.dart';
import 'package:uplatform/page/booking/booking_type_page.dart';
import 'package:uplatform/page/common/alarm_list_page.dart';
import 'package:uplatform/page/expert/income_list_page.dart';
import 'package:uplatform/page/home/payment_list_page.dart';
import 'package:uplatform/page/menu/serice_terms_page.dart';
import 'package:uplatform/page/signin/login_email_page.dart';
import 'package:uplatform/services/login_service.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key, this.onChangedScreen}) : super(key: key);

  final ValueChanged<String>? onChangedScreen;

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  final GlobalKey<ScaffoldState> _menuKey = GlobalKey();
  bool _isLogin = false;
  LoginUser? _loginUser;
  bool _isPushAlarm = true;

  @override
  void initState() {
    super.initState();

    _loginUser = LoginService().getLoginUser();
    _isLogin = (_loginUser != null);
    debugPrint('user $_loginUser');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Drawer(
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            key: _menuKey,
            appBar: const CustomAppBar(),
            body: Column(
              children: [
                if (!_isLogin)
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(LoginEmailPage.routeName, arguments: "NavigationDrawer");
                    },
                    child: Column(
                      children: [
                        const SizedBox(height: 22),
                        Container(
                          height: 34,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 34,
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "로그인 및 회원가입",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                height: 34,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: Color(0xFF898D93),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 22),
                kHorizontalLine,
                const SizedBox(height: 14),
                Mi.MenuItem(
                  iconData: Icons.notifications_none_outlined,
                  title: "알림",
                  onPressed: () {
                    Get.toNamed(AlarmListPage.routeName);
                  },
                ),
                Mi.MenuItem(
                  iconData: Icons.system_security_update_good_outlined,
                  title: "푸시알림",
                  onPressed: () {
                    _isPushAlarm = !_isPushAlarm;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  isSwitchItem: true,
                  switchOnOff: _isPushAlarm,
                ),
                const SizedBox(height: 14),
                kHorizontalLine,
                const SizedBox(height: 14),
                Mi.MenuItem(
                  iconData: Icons.check,
                  title: (_loginUser == null || _loginUser!.type == "0") ? "서비스 신청" : "서비스 지원",
                  onPressed: () {
                    if (_loginUser == null) {
                      Get.toNamed(LoginEmailPage.routeName, arguments: "BookingTypePage");
                      return;
                    }

                    if (_loginUser!.type == "0") {
                      Get.toNamed(BookingTypePage.routeName);
                    } else {
                      widget.onChangedScreen!("서비스 지원");
                      Get.back();
                    }
                  },
                ),
                Mi.MenuItem(
                  iconData: Icons.list_alt,
                  title: (_loginUser == null || _loginUser!.type == "0") ? "예약내역" : "지원내역",
                  onPressed: () {
                    if (_loginUser == null) {
                      Get.toNamed(LoginEmailPage.routeName, arguments: "ReservationTab");
                      return;
                    }

                    if (_loginUser!.type == "0") {
                      widget.onChangedScreen!("예약내역");
                      Get.back();
                    } else {
                      widget.onChangedScreen!("지원내역");
                      Get.back();
                    }
                  },
                ),
                Mi.MenuItem(
                  iconData: Icons.monetization_on_outlined,
                  imagePath: "assets/images/icons_won.png",
                  title: (_loginUser == null || _loginUser!.type == "0") ? "결제내역" : "정산내역",
                  onPressed: () {
                    if (_loginUser == null || _loginUser!.type == "0") {
                      Get.back();
                      Get.toNamed(PaymentListPage.routeName);
                    } else {
                      Get.back();
                      Get.toNamed(IncomeListPage.routeName);
                    }
                  },
                ),
                const SizedBox(height: 14),
                kHorizontalLine,
                const SizedBox(height: 14),
                Mi.MenuItem(
                  iconData: Icons.support_agent_outlined,
                  title: "고객센터",
                  onPressed: () {
                    widget.onChangedScreen!("고객센터");
                    Get.back();
                  },
                ),
                Mi.MenuItem(
                  iconData: Icons.privacy_tip_outlined,
                  title: "서비스 약관",
                  onPressed: () {
                    Get.toNamed(ServiceTermsPage.routeName);
                  },
                ),
                if (_isLogin)
                  Mi.MenuItem(
                    iconData: Icons.logout,
                    title: "로그아웃",
                    onPressed: () {
                      LoginService().logOut();
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
