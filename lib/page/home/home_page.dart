import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/user_model.dart';
import 'package:uplatform/page/common/alarm_list_page.dart';
import 'package:uplatform/page/home/tab/help_center_tab.dart';
import 'package:uplatform/page/home/tab/home_tab.dart';
import 'package:uplatform/page/home/tab/profile_tab.dart';
import 'package:uplatform/page/home/tab/reservation_tab.dart';
import 'package:uplatform/page/menu/navigation_drawer.dart';
import 'package:uplatform/services/firebase_service.dart';
import 'package:uplatform/services/login_service.dart';
import 'package:uplatform/services/network.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final List<String> _bottomTabs = ["홈", "예약내역", "프로필", "고객센터"];
  final GlobalKey<ScaffoldState> _scaffoldHomeKey = GlobalKey<ScaffoldState>();

  TabController? _tabController;
  FToast? _fToast;
  DateTime? _currentBackPressTime;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _bottomTabs.length);
    _tabController!.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    loadUserInfo();

    debugPrint("Get.arguments ${Get.arguments}");

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      _fToast = FToast();
      _fToast!.init(context);

      if (Get.arguments == "ReservationTab") {
        _tabController!.animateTo(1, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      } else if (Get.arguments == "1:1" || Get.arguments == "FAQ") {
        _tabController!.animateTo(3, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }

      await LoginService().calcUnReadAlarmCount();

      int unReadAlarmCount = LoginService().getUnReadAlarmCount();
      if (unReadAlarmCount > 0 && mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void loadUserInfo() async {
    LoginUser? loginUser = LoginService().getLoginUser();

    if (loginUser != null) {
      UserInfo? userInfo = await Network().reqUserInfo();

      if (userInfo != null) {
        LoginService().setUserInfo(userInfo);
      }

      AreaInfo? userAreaInfo = await Network().reqAreaInfo();

      if (userAreaInfo != null) {
        LoginService().setUserAreaInfo(userAreaInfo);
      }

      FirebaseService().initState();
    }
  }

  Future<bool> _onBackPressed() {
    debugPrint('HomePage() _onBackPressed()');

    DateTime nowTime = DateTime.now();

    if (_scaffoldHomeKey.currentState!.isEndDrawerOpen) {
      Get.back();
      return Future.value(false);
    }

    if (_tabController != null) {
      debugPrint("_tabController!.index ${_tabController!.index}");
      if (_tabController!.index != 0) {
        _tabController!.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);

        return Future.value(false);
      }
    }

    if (_currentBackPressTime == null || nowTime.difference(_currentBackPressTime!) > const Duration(seconds: 2)) {
      _currentBackPressTime = nowTime;
      _showToast();
      return Future.value(false);
    }

    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }

  void _showToast() {
    final double screenWidth = MediaQuery.of(context).size.width;

    Widget toast = Container(
      width: screenWidth,
      height: 44,
      alignment: Alignment.center,
      child: Container(
        width: 343,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: const Color(0xFF282828).withOpacity(0.65),
        ),
        alignment: Alignment.center,
        child: const Text(
          "'뒤로' 버튼을 한번 더 누르시면 종료됩니다.",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );

    _fToast!.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 2),
      positionedToastBuilder: (context, child) {
        return Positioned(
          child: child,
          left: 0,
          bottom: 80,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          key: _scaffoldHomeKey,
          backgroundColor: Colors.white,
          appBar: buildAppBar(context),
          extendBodyBehindAppBar: true,
          endDrawer: NavigationDrawer(
            onChangedScreen: (value) {
              debugPrint(value);
              if (value == "예약내역") {
                _tabController!.animateTo(1, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
              } else if (value == "고객센터") {
                _tabController!.animateTo(3, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
              }
            },
          ),
          body: Column(
            children: [
              Expanded(
                child: DefaultTabController(
                  length: _bottomTabs.length,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      HomeTab(
                        onPressedHelpCenterTab: () {
                          _tabController!
                              .animateTo(3, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
                        },
                      ),
                      const ReservationTab(),
                      ProfileTab(
                        onPressedBookingTab: () {
                          _tabController!
                              .animateTo(1, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
                        },
                      ),
                      HelpCenterTab(
                          startTab: (Get.arguments == "1:1")
                              ? 2
                              : (Get.arguments == "FAQ")
                                  ? 1
                                  : 0),
                    ],
                  ),
                ),
              ),
              Container(
                height: 80,
                alignment: Alignment.center,
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  labelColor: const Color(0xFF4A4E55),
                  unselectedLabelColor: const Color(0xFF898D93),
                  indicatorWeight: 0.1,
                  indicatorColor: Colors.transparent,
                  labelStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  tabs: [
                    Tab(
                      icon: Icon(
                        (_tabController != null && _tabController?.index == 0) ? Icons.home : Icons.home_outlined,
                        size: 28,
                      ),
                      text: "홈",
                      iconMargin: const EdgeInsets.only(bottom: 4.0),
                    ),
                    Tab(
                      icon: Icon(
                        (_tabController != null && _tabController?.index == 1)
                            ? Icons.description
                            : Icons.description_outlined,
                        size: 28,
                      ),
                      text: "예약내역",
                      iconMargin: const EdgeInsets.only(bottom: 4.0),
                    ),
                    Tab(
                      icon: Icon(
                        (_tabController != null && _tabController?.index == 2) ? Icons.person : Icons.person_outline,
                        size: 28,
                      ),
                      text: "프로필",
                      iconMargin: const EdgeInsets.only(bottom: 4.0),
                    ),
                    Tab(
                      icon: Icon(
                        (_tabController != null && _tabController?.index == 3)
                            ? Icons.help_center
                            : Icons.help_center_outlined,
                        size: 28,
                      ),
                      text: "고객센터",
                      iconMargin: const EdgeInsets.only(bottom: 4.0),
                    ),
                  ],
                ),
              ),
              buildBottomBar,
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      toolbarHeight: 48.0,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: (_tabController != null && _tabController!.index == 0)
          ? Container(
              height: 48,
              color: Colors.transparent,
              padding: const EdgeInsets.only(left: 8),
              alignment: Alignment.centerLeft,
              child: Image.asset(
                "assets/images/title.png",
                width: 110,
                fit: BoxFit.fitWidth,
              ),
            )
          : Container(),
      actions: [
        GestureDetector(
          onTap: () {
            Get.toNamed(AlarmListPage.routeName);
          },
          child: Stack(
            children: [
              Container(
                width: 40,
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/icons_notifications.png",
                  width: 28,
                  height: 28,
                ),
              ),
              GetBuilder<AlarmCountController>(
                init: AlarmCountController(),
                builder: (_) {
                  int unreadCount = _.unReadCount;
                  if (unreadCount > 0) {
                    return Positioned(
                      top: 11,
                      right: 9,
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF10000),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            _scaffoldHomeKey.currentState!.openEndDrawer();
          },
          child: Container(
            width: 40,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 20),
            child: Image.asset(
              "assets/images/icons_menu.png",
              width: 28,
              height: 28,
            ),
          ),
        ),
      ],
    );
  }
}
