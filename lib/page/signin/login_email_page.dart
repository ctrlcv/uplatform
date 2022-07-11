import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/border_rounded_image_button.dart';
import 'package:uplatform/components/check_box.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/user_model.dart';
import 'package:uplatform/page/booking/booking_restaurant_page.dart';
import 'package:uplatform/page/booking/booking_space_page.dart';
import 'package:uplatform/page/booking/booking_type_page.dart';
import 'package:uplatform/page/home/home_page.dart';
import 'package:uplatform/page/signup/signup_terms_page.dart';
import 'package:uplatform/services/login_service.dart';
import 'package:uplatform/services/network.dart';
import 'package:uplatform/services/shared_preference.dart';

import '../expert/expert_home_page.dart';
import '../home/payment_list_page.dart';
import '../temp_page.dart';
import 'find_id_page.dart';
import 'find_password_page.dart';

class LoginEmailPage extends StatefulWidget {
  const LoginEmailPage({Key? key}) : super(key: key);

  static const routeName = '/LoginEmailPage';

  @override
  _LoginEmailPageState createState() => _LoginEmailPageState();
}

class _LoginEmailPageState extends State<LoginEmailPage> {
  bool _isProfessionalMember = false;
  bool _isAutoLogin = false;

  final TextEditingController _emailEditController = TextEditingController();
  final TextEditingController _passwordEditController = TextEditingController();

  final FocusNode _emailEditingFocus = FocusNode();
  final FocusNode _passwordEditingFocus = FocusNode();

  String _getArguments = "";

  @override
  void initState() {
    super.initState();

    if (Get.arguments != null) {
      debugPrint("Get.arguments is NOT NULL");
      _getArguments = Get.arguments;
    }
  }

  @override
  void dispose() {
    super.dispose();

    _emailEditController.dispose();
    _passwordEditController.dispose();

    _emailEditingFocus.dispose();
    _passwordEditingFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          iconData: (_getArguments.isNotEmpty) ? Icons.arrow_back : Icons.close,
        ),
        body: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: const Text(
                "로그인",
                style: TextStyle(
                  fontSize: 24,
                  height: 1.2,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 48,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F2F4),
                        border: Border.all(color: const Color(0xFFF1F2F4), width: 2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _isProfessionalMember = false;
                                if (mounted) {
                                  setState(() {});
                                }
                              },
                              child: Container(
                                height: 44,
                                decoration: BoxDecoration(
                                  color: _isProfessionalMember ? const Color(0xFFF1F2F4) : Colors.white,
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "일반회원",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: _isProfessionalMember ? const Color(0xFF898D93) : Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _isProfessionalMember = true;
                                if (mounted) {
                                  setState(() {});
                                }
                              },
                              child: Container(
                                height: 44,
                                decoration: BoxDecoration(
                                  color: !_isProfessionalMember ? const Color(0xFFF1F2F4) : Colors.white,
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "전문가회원",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: !_isProfessionalMember ? const Color(0xFF898D93) : Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 48,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFE4E7ED), width: 1),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        controller: _emailEditController,
                        focusNode: _emailEditingFocus,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          hintText: "이메일 주소",
                          hintStyle: TextStyle(
                            color: Color(0xFFCDD0D3),
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          _passwordEditingFocus.requestFocus();
                        },
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 48,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFE4E7ED), width: 1),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        controller: _passwordEditController,
                        focusNode: _passwordEditingFocus,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          hintText: "비밀번호",
                          hintStyle: TextStyle(
                            color: Color(0xFFCDD0D3),
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        obscureText: true,
                        onFieldSubmitted: (value) async {
                          if (value.isNotEmpty) {
                            await processLogin();
                          }
                        },
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        _isAutoLogin = !_isAutoLogin;
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      child: Container(
                        height: 20,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            CheckBox(isSelected: _isAutoLogin),
                            const SizedBox(width: 12),
                            Container(
                              height: 20,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(top: 1),
                              child: const Text(
                                "자동 로그인",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: BorderRoundedButton(
                        text: "로그인",
                        buttonColor: kMainColor,
                        onPressed: () async {
                          await processLogin();
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(FindIdPage.routeName);
                            },
                            child: const Text(
                              "아이디 찾기",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF898D93),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(width: 1, height: 11, color: const Color(0xFFE4E7ED)),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(FindPasswordPage.routeName);
                            },
                            child: const Text(
                              "비밀번호 찾기",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF898D93),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (UniversalPlatform.isAndroid && _getArguments.isNotEmpty)
                      Column(
                        children: [
                          const SizedBox(height: 23),
                          Container(
                            height: 16,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(child: Container(height: 1, color: const Color(0xFFF5F6F8))),
                                const SizedBox(width: 16),
                                Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "또는",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFFB1B4B7),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(child: Container(height: 1, color: const Color(0xFFF5F6F8))),
                              ],
                            ),
                          ),
                          const SizedBox(height: 26),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: BorderRoundedImageButton(
                              imagePath: "assets/images/icons_account_type_kakao.png",
                              buttonText: "카카오톡으로 로그인",
                              onPressed: () async {
                                KakaoUser? kakaoUser;

                                if (await checkKakaoLogin() == true) {
                                  kakaoUser = await LoginService().loginByKakaoWithToken();
                                } else {
                                  kakaoUser = await LoginService().loginByKakao();
                                }

                                if (kakaoUser != null) {
                                  bool started = await startWithKakaoUser(kakaoUser);
                                  if (!started) {
                                    Get.offAllNamed(SignUpTermsPage.routeName, arguments: "KAKAO");
                                  }
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: BorderRoundedImageButton(
                              imagePath: "assets/images/icons_account_type_naver.png",
                              buttonText: "네이버로 로그인",
                              onPressed: () async {
                                NaverUser? naverUser;
                                if (await checkKakaoLogin() == true) {
                                  naverUser = await LoginService().loginByNaverWithToken();
                                } else {
                                  naverUser = await LoginService().loginByNaver();
                                }

                                if (naverUser != null) {
                                  bool started = await startWithNaverUser(naverUser);
                                  if (!started) {
                                    Get.offAllNamed(SignUpTermsPage.routeName, arguments: "KAKAO");
                                  }
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      )
                    else
                      Container(),
                  ],
                ),
              ),
            ),
            Container(
              height: 16,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "아직 회원이 아니신가요?",
                    style: TextStyle(
                      fontSize: 13,
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
                        color: kBlueColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 64),
            buildBottomBar,
          ],
        ),
      ),
    );
  }

  Future processLogin() async {
    if (_emailEditController.text.isEmpty) {
      Get.snackbar('입력오류', '이메일을 입력하세요.',
          snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
      return;
    }

    if (_passwordEditController.text.isEmpty) {
      Get.snackbar('입력오류', '비밀번호를 입력하세요.',
          snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
      return;
    }

    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailEditController.text)) {
      Get.snackbar('입력오류', '이메일 형식이 맞지 않습니다.',
          snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
    }

    Map<String, dynamic> params = {};
    params['email'] = _emailEditController.text;
    params['password'] = _passwordEditController.text;

    LoginUser user = await Network().reqLogIn(params);

    if (user.status == "200") {
      user.email = _emailEditController.text;
      LoginService().setLoginUser(user);

      if (_isAutoLogin) {
        SharedPreference().saveUserId(_emailEditController.text);
        SharedPreference().savePassword(_passwordEditController.text);
        SharedPreference().saveKeepMeLogIn(true);
      } else {
        SharedPreference().clear();
      }

      if (_getArguments == "BACK") {
        Get.back(result: "login");
      } else {
        if (user.type == "1") {
          Get.offAllNamed(ExpertHomePage.routeName, arguments: _getArguments);
        } else {
          Get.offAllNamed(HomePage.routeName, arguments: _getArguments);
          if (_getArguments == "BookingTypePage") {
            Get.toNamed(BookingTypePage.routeName);
          } else if (_getArguments == "BookingRestaurantPage") {
            Get.toNamed(BookingRestaurantPage.routeName);
          } else if (_getArguments == "BookingSpacePage") {
            Get.toNamed(BookingSpacePage.routeName);
          } else if (_getArguments == "BookingEducationPage") {
            Get.toNamed(BookingEducationPage.routeName);
          } else if (_getArguments == "PaymentListPage") {
            Get.toNamed(PaymentListPage.routeName);
          }
        }
      }
    } else {
      Get.snackbar(
        '로그인 오류',
        user.message!,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(milliseconds: 1500),
      );
    }
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

      if (_getArguments == "BACK") {
        Get.back(result: "login");
      } else {
        if (user.type == "1") {
          Get.offAllNamed(ExpertHomePage.routeName);
        } else {
          debugPrint("shit!");
          Get.offAllNamed(HomePage.routeName);
          if (_getArguments == "BookingTypePage") {
            Get.toNamed(BookingTypePage.routeName);
          } else if (_getArguments == "BookingRestaurantPage") {
            Get.toNamed(BookingRestaurantPage.routeName);
          } else if (_getArguments == "BookingSpacePage") {
            Get.toNamed(BookingSpacePage.routeName);
          } else if (_getArguments == "BookingEducationPage") {
            Get.toNamed(BookingEducationPage.routeName);
          } else if (_getArguments == "PaymentListPage") {
            Get.toNamed(PaymentListPage.routeName);
          }
        }
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

      if (_getArguments == "BACK") {
        Get.back(result: "login");
      } else {
        if (user.type == "1") {
          Get.offAllNamed(ExpertHomePage.routeName);
        } else {
          Get.offAllNamed(HomePage.routeName);
          if (_getArguments == "BookingTypePage") {
            Get.toNamed(BookingTypePage.routeName);
          } else if (_getArguments == "BookingRestaurantPage") {
            Get.toNamed(BookingRestaurantPage.routeName);
          } else if (_getArguments == "BookingSpacePage") {
            Get.toNamed(BookingSpacePage.routeName);
          } else if (_getArguments == "BookingEducationPage") {
            Get.toNamed(BookingEducationPage.routeName);
          } else if (_getArguments == "PaymentListPage") {
            Get.toNamed(PaymentListPage.routeName);
          }
        }
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
