import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:uplatform/components/container_progress.dart';
import 'package:uplatform/components/no_item_panel.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/notice_model.dart';
import 'package:uplatform/models/user_model.dart';
import 'package:uplatform/page/expert/expert_home_page.dart';
import 'package:uplatform/page/home/home_page.dart';
import 'package:uplatform/page/signin/login_email_page.dart';
import 'package:uplatform/page/signup/signup_terms_page.dart';
import 'package:uplatform/services/login_service.dart';
import 'package:uplatform/services/network.dart';

import '../qna_detail_page.dart';
import '../qna_input_page.dart';

class QnaTab extends StatefulWidget {
  const QnaTab({Key? key}) : super(key: key);

  @override
  _QnaTabState createState() => _QnaTabState();
}

class _QnaTabState extends State<QnaTab> {
  final ScrollController _scrollController = ScrollController();

  LoginUser? _loginUser;
  bool _isShowQuestionPanel = false;

  bool _isLoading = false;
  bool _isNoItem = false;
  bool _isMoreLoading = false;
  String _lastItemId = "";
  int _requestCount = 0;

  List<QnaItem> _qnaItemList = [];

  @override
  void initState() {
    super.initState();

    _loginUser = LoginService().getLoginUser();
    _isShowQuestionPanel = (_loginUser == null);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        debugPrint('Slide to the bottom ${_scrollController.position.pixels}');
        loadQnaItemListMore();
      }
    });

    debugPrint("_isShowQuestionPanel $_isShowQuestionPanel");

    loadQnaItemList();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  Future loadQnaItemList() async {
    _isLoading = true;

    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};

    params['start_no'] = "0";
    params['row'] = kListLoadCount.toString();
    params['type'] = "일반문의";

    QnaItemList? qnaList = await Network().reqQnaList(params);

    if (qnaList == null || qnaList.status != "200" || qnaList.count == 0) {
      _isLoading = false;
      _isNoItem = true;
      _qnaItemList = [];

      if (mounted) {
        setState(() {});
      }
      return;
    }

    _isNoItem = false;
    _qnaItemList = qnaList.result!;
    _requestCount = qnaList.count ?? 0;

    if (_qnaItemList.isNotEmpty) {
      QnaItem lastQna = _qnaItemList[_qnaItemList.length - 1];
      _lastItemId = lastQna.qnaId ?? "0";
    }

    _isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future loadQnaItemListMore() async {
    if (_qnaItemList.isNotEmpty && _qnaItemList.length >= _requestCount) {
      return;
    }

    _isMoreLoading = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};
    params['start_no'] = _lastItemId;
    params['row'] = kListLoadCount.toString();
    params['type'] = "일반문의";

    QnaItemList qnaList = await Network().reqQnaList(params);

    if (qnaList.status != "200" || qnaList.count == 0) {
      _isMoreLoading = false;
      if (mounted) {
        setState(() {});
      }
      return;
    }

    List<QnaItem>? qnaItemList = qnaList.result;
    if (qnaItemList != null) {
      _qnaItemList.addAll(qnaItemList);
    }

    if (_qnaItemList.isNotEmpty) {
      QnaItem lastQna = _qnaItemList[_qnaItemList.length - 1];
      _lastItemId = lastQna.qnaId ?? "0";
    }

    _isMoreLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isShowQuestionPanel) {
      return buildNotLoginPanel();
    }

    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            await Get.toNamed(QnaInputPage.routeName);
            loadQnaItemList();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xFF10A2DC),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: const Text(
                "1:1 문의하기",
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF10A2DC),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: _isLoading
                ? const ContainerProgress()
                : _isNoItem
                    ? buildNoQnaItems()
                    : Stack(
                        children: [
                          RefreshIndicator(
                            child: ListView.builder(
                              controller: _scrollController,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: _qnaItemList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return buildQnAItem(
                                  _qnaItemList[index],
                                  (index == _qnaItemList.length - 1),
                                );
                              },
                            ),
                            onRefresh: loadQnaItemList,
                          ),
                          Offstage(
                            offstage: !_isMoreLoading,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      ),
          ),
        ),
      ],
    );
  }

  Widget buildQnAItem(QnaItem qnaItem, bool isLastItem) {
    return GestureDetector(
      onTap: () async {
        dynamic result = await Get.toNamed(QnaDetailPage.routeName, arguments: qnaItem.qnaId);
        if (result != null && result == "DELETE") {
          _qnaItemList.remove(qnaItem);
          if (mounted) {
            setState(() {});
          }
        }
      },
      child: Container(
        color: Colors.transparent,
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
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "[${qnaItem.type}] ${qnaItem.title}",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 16,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          qnaItem.askDateTime ?? "",
                          style: const TextStyle(
                            fontSize: 13,
                            height: 1.0,
                            color: Color(0xFF898D93),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (qnaItem.status != null) const SizedBox(width: 10),
                if (qnaItem.status != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: (qnaItem.status == "W") ? const Color(0xFFF4FAFF) : const Color(0xFFF5F6F8),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      (qnaItem.status == "S") ? "답변완료" : "확인중",
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.2,
                        color: (qnaItem.status == "W") ? const Color(0xFF10A2DC) : const Color(0xFF686C73),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            if (!isLastItem) kHorizontalLineNoMargin,
          ],
        ),
      ),
    );
  }

  Widget buildNoQnaItems() {
    return Column(
      children: [
        Expanded(child: Container()),
        const NoItemPanel(
          title: "1:1문의 내역이 없습니다.",
        ),
        Expanded(child: Container()),
      ],
    );
  }

  Widget buildNotLoginPanel() {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        children: [
          Expanded(child: Container()),
          Container(
            height: 28,
            alignment: Alignment.center,
            child: const Text(
              "1:1 문의는",
              style: TextStyle(
                fontSize: 18,
                height: 1.1,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            height: 28,
            alignment: Alignment.center,
            child: const Text(
              "로그인 후 이용할 수 있습니다.",
              style: TextStyle(
                fontSize: 18,
                height: 1.1,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (UniversalPlatform.isAndroid)
                GestureDetector(
                  onTap: () async {
                    KakaoUser? kakaoUser;

                    if (await checkKakaoLogin() == true) {
                      kakaoUser = await LoginService().loginByKakaoWithToken();
                    } else {
                      kakaoUser = await LoginService().loginByKakao();
                    }
                    if (kakaoUser != null) {
                      bool started = await startWithKakaoUser(kakaoUser);
                      if (!started) {
                        Get.toNamed(SignUpTermsPage.routeName, arguments: "KAKAO");
                      }
                    }
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/icons_login_kakao.png",
                        width: 60,
                        height: 60,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "카카오톡",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF686C73),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (UniversalPlatform.isAndroid) const SizedBox(width: 24),
              if (UniversalPlatform.isAndroid)
                GestureDetector(
                  onTap: () async {
                    NaverUser? naverUser;
                    if (await checkKakaoLogin() == true) {
                      naverUser = await LoginService().loginByNaverWithToken();
                    } else {
                      naverUser = await LoginService().loginByNaver();
                    }

                    if (naverUser != null) {
                      bool started = await startWithNaverUser(naverUser);
                      if (!started) {
                        Get.toNamed(SignUpTermsPage.routeName, arguments: "KAKAO");
                      }
                    }
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/icons_login_naver.png",
                        width: 60,
                        height: 60,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "네이버",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF686C73),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (UniversalPlatform.isAndroid) const SizedBox(width: 24),
              GestureDetector(
                onTap: () {
                  Get.toNamed(LoginEmailPage.routeName, arguments: "BACK");
                },
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE4E7ED), width: 1),
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      child: const Icon(
                        Icons.email_outlined,
                        color: Color(0xFF323232),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "이메일",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF686C73),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "아직 회원이 아니신가요?",
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.1,
                    color: Color(0xFF898D93),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(SignUpTermsPage.routeName);
                  },
                  child: const Text(
                    "회원가입",
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.1,
                      color: kBlueColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  Future<bool> startWithKakaoUser(KakaoUser kakaoUser) async {
    if (kakaoUser.id!.contains("kakao_") == false) {
      kakaoUser.id = "kakao_" + kakaoUser.id!;
      LoginService().setKakaoUser(kakaoUser);
    }

    Map<String, dynamic> params = {};
    params['sns_key'] = kakaoUser.id;
    LoginUser? user = await Network().reqSnsLogIn(params);

    if (user != null && user.status == "200") {
      user.email = kakaoUser.email;
      user.snsKey = kakaoUser.id;
      LoginService().setLoginUser(user);

      if (user.type == "1") {
        Get.toNamed(ExpertHomePage.routeName, arguments: "1:1");
      } else {
        debugPrint("shit!");
        Get.offAllNamed(HomePage.routeName, arguments: "1:1");
      }
      return true;
    }

    return false;
  }

  Future<bool> startWithNaverUser(NaverUser naverUser) async {
    if (naverUser.id!.contains("naver_") == false) {
      naverUser.id = "naver_" + naverUser.id!;
      LoginService().setNaverUser(naverUser);
    }

    Map<String, dynamic> params = {};
    params['sns_key'] = naverUser.id;
    LoginUser? user = await Network().reqSnsLogIn(params);
    debugPrint('user: $user');

    if (user != null && user.status == "200") {
      user.email = naverUser.email;
      user.snsKey = naverUser.id;
      LoginService().setLoginUser(user);

      if (user.type == "1") {
        Get.toNamed(ExpertHomePage.routeName, arguments: "1:1");
      } else {
        Get.offAllNamed(HomePage.routeName, arguments: "1:1");
      }
      return true;
    }

    return false;
  }

  Future<bool?> checkKakaoLogin() async {
    return (await AuthApi.instance.hasToken() == false);
  }

  Future<bool?> checkNaverLogin() async {
    return await FlutterNaverLogin.isLoggedIn;
  }
}
