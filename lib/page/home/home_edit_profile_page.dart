import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iamport_flutter/model/certification_data.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/input_bottom_sheet.dart';
import 'package:uplatform/components/input_edit_text_underline.dart';
import 'package:uplatform/components/input_title.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/dialogs/certification_dialog.dart';
import 'package:uplatform/models/common_model.dart';
import 'package:uplatform/models/user_model.dart';
import 'package:uplatform/page/common/address_search_page.dart';
import 'package:uplatform/page/common/change_password_page.dart';
import 'package:uplatform/page/common/find_address_page.dart';
import 'package:uplatform/page/common/phone_certification.dart';
import 'package:uplatform/services/login_service.dart';
import 'package:uplatform/services/network.dart';

class HomeEditProfilePage extends StatefulWidget {
  const HomeEditProfilePage({Key? key}) : super(key: key);

  static const routeName = '/HomeEditProfilePage';

  @override
  _HomeEditProfilePageState createState() => _HomeEditProfilePageState();
}

class _HomeEditProfilePageState extends State<HomeEditProfilePage> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'HomeEditProfilePage');

  final TextEditingController _emailEditController = TextEditingController();
  final FocusNode _emailEditFocus = FocusNode();

  final TextEditingController _snsTypeEditController = TextEditingController();
  final FocusNode _snsTypeEditFocus = FocusNode();

  final TextEditingController _passwordEditController = TextEditingController();
  final FocusNode _passwordEditFocus = FocusNode();

  final TextEditingController _phoneEditController = TextEditingController();
  final FocusNode _phoneEditFocus = FocusNode();

  final TextEditingController _nameEditController = TextEditingController();
  final FocusNode _nameEditFocus = FocusNode();

  final TextEditingController _birthEditController = TextEditingController();
  final FocusNode _birthEditFocus = FocusNode();

  final TextEditingController _ceoEditController = TextEditingController();
  final FocusNode _ceoEditFocus = FocusNode();

  final TextEditingController _housePhoneEditController = TextEditingController();
  final FocusNode _housePhoneEditFocus = FocusNode();

  final TextEditingController _addressEditController = TextEditingController();
  final FocusNode _addressEditFocus = FocusNode();

  final TextEditingController _addAddressEditController = TextEditingController();
  final FocusNode _addAddressEditFocus = FocusNode();

  final ScrollController _scrollController = ScrollController();

  bool _isVerifiedPhone = false;
  bool _isMen = false;
  bool _isWomen = false;

  String _selectedJobTitle = "";

  bool _isInterestCleanRestaurants = false;
  bool _isInterestCleanSpace = false;
  bool _isInterestEudClean = false;
  bool _isInterestNothing = false;

  bool _isHouseTypeSingle = false;
  bool _isHouseTypeVilla = false;
  bool _isHouseTypeApartment = false;
  bool _isHouseTypeOffice = false;
  bool _isHouseTypeMix = false;
  bool _isHouseTypeMarket = false;
  bool _isHouseTypeEtc = false;

  String _selectedFamilyCount = "";
  String _selectedHouseSize = "";
  String _selectedCleanSpace = "";

  bool _isRestaurantTypeKorea = false;
  bool _isRestaurantTypeJap = false;
  bool _isRestaurantTypeChina = false;
  bool _isRestaurantTypeWest = false;
  bool _isRestaurantTypeForeign = false;
  bool _isRestaurantTypeFusion = false;
  bool _isRestaurantTypeBakery = false;
  bool _isRestaurantTypeCafe = false;
  bool _isRestaurantTypeDelivery = false;
  bool _isRestaurantTypeEtc = false;

  String _selectedRestaurantSize = "";
  String _selectedKitchenSize = "";

  bool _isExistWorkInRef = false;
  bool _isNotExistWorkInRef = false;
  String _selectedWorkInRefSize = "";

  LoginUser? _loginUser;
  UserInfo? _loginUserInfo;
  AreaInfo? _loginUserAreaInfo;
  String _snsType = "";

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();

    _emailEditController.dispose();
    _emailEditFocus.dispose();

    _snsTypeEditController.dispose();
    _snsTypeEditFocus.dispose();

    _passwordEditController.dispose();
    _passwordEditFocus.dispose();

    _phoneEditController.dispose();
    _phoneEditFocus.dispose();

    _addressEditController.dispose();
    _addressEditFocus.dispose();

    _addAddressEditController.dispose();
    _addAddressEditFocus.dispose();

    _nameEditController.dispose();
    _nameEditFocus.dispose();

    _birthEditController.dispose();
    _birthEditFocus.dispose();

    _ceoEditController.dispose();
    _ceoEditFocus.dispose();

    _housePhoneEditController.dispose();
    _housePhoneEditFocus.dispose();
  }

  void loadUserData() {
    _loginUser = LoginService().getLoginUser();
    _loginUserInfo = LoginService().getUserInfo();
    _loginUserAreaInfo = LoginService().getUserAreaInfo();

    if (_loginUser != null) {
      _emailEditController.text = _loginUser?.email ?? "";
    }

    _passwordEditController.text = "**************";

    if (_loginUserInfo != null) {
      if ((_loginUserInfo?.snsKey ?? "").contains("kakao")) {
        _snsType = "KAKAO";
        _snsTypeEditController.text = "카카오톡";
      } else if ((_loginUserInfo?.snsKey ?? "").contains("naver")) {
        _snsType = "NAVER";
        _snsTypeEditController.text = "네이버";
      }

      _isMen = ((_loginUserInfo?.gender ?? "") == "M");
      _isWomen = ((_loginUserInfo?.gender ?? "") == "W");

      _phoneEditController.text = _loginUserInfo?.phoneNumber ?? "";
      _isVerifiedPhone = (_phoneEditController.text == _loginUserInfo?.phoneNumber);

      _nameEditController.text = _loginUserInfo?.name ?? "";
      _birthEditController.text = _loginUserInfo?.birth ?? "";
    }

    if (_loginUserAreaInfo != null) {
      _selectedJobTitle = _loginUserAreaInfo?.position ?? "";

      _isInterestCleanRestaurants = ((_loginUserAreaInfo?.interestService ?? "") == "음식점 위생정리");
      _isInterestCleanSpace = ((_loginUserAreaInfo?.interestService ?? "") == "공간정리");
      _isInterestEudClean = ((_loginUserAreaInfo?.interestService ?? "") == "정리 교육");
      _isInterestNothing = ((_loginUserAreaInfo?.interestService ?? "") == "없음");

      _isHouseTypeSingle = ((_loginUserAreaInfo?.houseType ?? "") == "단독");
      _isHouseTypeVilla = ((_loginUserAreaInfo?.houseType ?? "") == "빌라");
      _isHouseTypeApartment = ((_loginUserAreaInfo?.houseType ?? "") == "아파트");
      _isHouseTypeOffice = ((_loginUserAreaInfo?.houseType ?? "") == "오피스텔");
      _isHouseTypeMix = ((_loginUserAreaInfo?.houseType ?? "") == "주상복합");
      _isHouseTypeMarket = ((_loginUserAreaInfo?.houseType ?? "") == "상가");
      _isHouseTypeEtc = ((_loginUserAreaInfo?.houseType ?? "") == "기타");

      _isRestaurantTypeKorea = ((_loginUserAreaInfo?.shopType ?? "") == "한식");
      _isRestaurantTypeJap = ((_loginUserAreaInfo?.shopType ?? "") == "일식");
      _isRestaurantTypeChina = ((_loginUserAreaInfo?.shopType ?? "") == "중식");
      _isRestaurantTypeWest = ((_loginUserAreaInfo?.shopType ?? "") == "양식");
      _isRestaurantTypeForeign = ((_loginUserAreaInfo?.shopType ?? "") == "외국음식");
      _isRestaurantTypeFusion = ((_loginUserAreaInfo?.shopType ?? "") == "퓨전");
      _isRestaurantTypeBakery = ((_loginUserAreaInfo?.shopType ?? "") == "베이커리");
      _isRestaurantTypeCafe = ((_loginUserAreaInfo?.shopType ?? "") == "카페");
      _isRestaurantTypeDelivery = ((_loginUserAreaInfo?.shopType ?? "") == "배달전문");
      _isRestaurantTypeEtc = ((_loginUserAreaInfo?.shopType ?? "") == "기타");

      _selectedRestaurantSize = _loginUserAreaInfo?.shopSize ?? "";
      _selectedKitchenSize = _loginUserAreaInfo?.kitchenSize ?? "";

      _isExistWorkInRef = ((_loginUserAreaInfo?.refrigerator ?? "") == "있음");
      _isNotExistWorkInRef = ((_loginUserAreaInfo?.refrigerator ?? "") == "없음");
      _selectedWorkInRefSize = _loginUserAreaInfo?.refrigeratorSize ?? "";

      _selectedFamilyCount = _loginUserAreaInfo?.peoples ?? "";
      _selectedHouseSize = _loginUserAreaInfo?.houseSize ?? "";
      _selectedCleanSpace = _loginUserAreaInfo?.areaSize ?? "";

      _addressEditController.text = _loginUserAreaInfo?.address ?? "";
      _addAddressEditController.text = _loginUserAreaInfo?.addAddress ?? "";
      _ceoEditController.text = _loginUserAreaInfo?.ceoName ?? "";
      _housePhoneEditController.text = _loginUserAreaInfo?.tel ?? "";

      if (mounted) {
        setState(() {});
      }
    }
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 16),
                const TextTitle(
                  titleText: "회원정보 관리",
                  cellHeight: 32,
                  fontSize: 24,
                  fontColor: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 40),
                InputEditTextUnderline(
                  editingController: _emailEditController,
                  focusNode: _emailEditFocus,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  title: "이메일(아이디)",
                  hintText: "이메일 주소 입력",
                  isRequired: false,
                  isReadOnly: true,
                  inputType: TextInputType.emailAddress,
                ),
                if (_snsType == "KAKAO" || _snsType == "NAVER")
                  InputEditTextUnderline(
                    editingController: _snsTypeEditController,
                    focusNode: _snsTypeEditFocus,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    title: "소셜계정",
                    isRequired: false,
                    isReadOnly: true,
                    isPicture: true,
                    imagePath: (_snsType == "KAKAO")
                        ? "assets/images/icons_account_type_kakao.png"
                        : "assets/images/icons_account_type_naver.png",
                    inputType: TextInputType.emailAddress,
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: InputEditTextUnderline(
                          editingController: _passwordEditController,
                          focusNode: _passwordEditFocus,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          title: "비밀번호",
                          hintText: "8자 이상 영문, 숫자, 특수기호 혼합",
                          validator: (value) {
                            return null;
                          },
                          onSubmitted: (value) {
                            _phoneEditFocus.requestFocus();
                          },
                          isReadOnly: true,
                          isRequired: true,
                          isObscureText: true,
                        ),
                      ),
                      Container(
                        width: 88,
                        margin: const EdgeInsets.only(right: 20),
                        padding: const EdgeInsets.only(top: 14),
                        alignment: Alignment.topCenter,
                        child: BorderRoundedButton(
                          text: "변경",
                          active: true,
                          textColor: const Color(0xFF686C73),
                          buttonColor: Colors.white,
                          deActiveTextColor: const Color(0xFFE4E7ED),
                          deActiveColor: Colors.white,
                          deActiveLineColor: const Color(0xFFE4E7ED),
                          onPressed: () async {
                            String? result = await Get.toNamed(ChangePasswordPage.routeName);

                            if (result != null) {
                              _passwordEditController.text = result;
                            }

                            if (mounted) {
                              setState(() {});
                            }
                          },
                          fontSize: 15,
                          buttonHeight: 40,
                        ),
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: InputEditTextUnderline(
                        editingController: _phoneEditController,
                        focusNode: _phoneEditFocus,
                        padding: const EdgeInsets.only(left: 20, right: 8),
                        title: "휴대폰 번호",
                        hintText: "숫자만 입력",
                        onChanged: (value) {
                          _isVerifiedPhone = (_phoneEditController.text == _loginUserInfo?.phoneNumber);
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "휴대폰 번호를 입력하세요.";
                          }

                          return null;
                        },
                        onSubmitted: (value) {
                          _nameEditFocus.requestFocus();
                        },
                        isRequired: true,
                        inputType: TextInputType.number,
                      ),
                    ),
                    Container(
                      width: 88,
                      margin: const EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.only(top: 14),
                      alignment: Alignment.topCenter,
                      child: BorderRoundedButton(
                        text: _isVerifiedPhone ? "인증완료" : "인증하기",
                        active: !_isVerifiedPhone,
                        textColor: const Color(0xFF686C73),
                        buttonColor: Colors.white,
                        deActiveTextColor: const Color(0xFF10A2DC),
                        deActiveColor: Colors.white,
                        deActiveLineColor: const Color(0xFF10A2DC),
                        onPressed: () async {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          currentFocus.unfocus();

                          if (_phoneEditController.text.length < 10) {
                            Get.snackbar('휴대폰번호', '휴대폰 번호를 정확히 입력하세요',
                                snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                            return;
                          }

                          dynamic certResult;
                          bool certificationSuccess = false;

                          if (UniversalPlatform.isWeb) {
                            certResult = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CertificationDialog(
                                  phoneNumber: _phoneEditController.text,
                                );
                              },
                              barrierDismissible: false,
                            );

                            debugPrint("certResult $certResult");
                            final certResultJson = json.decode(certResult);

                            if (certResultJson != null) {
                              certificationSuccess = certResultJson["success"];
                              debugPrint("certResult certificationSuccess $certificationSuccess");
                            }
                          } else {
                            certResult = await Get.toNamed(
                              PhoneCertification.routeName,
                              arguments: CertificationData(
                                merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}',
                                carrier: "",
                                company: "유플랫폼",
                                name: _nameEditController.text,
                                phone: _phoneEditController.text,
                              ),
                            );

                            String isSuccess = "false";
                            if (certResult != null) {
                              isSuccess = certResult['success'];
                            }
                            certificationSuccess = (isSuccess == "true");
                          }

                          debugPrint("휴대폰인증 isSuccess $certificationSuccess");
                          _isVerifiedPhone = certificationSuccess;
                          _loginUserInfo?.phoneNumber = _phoneEditController.text;
                          if (!_isVerifiedPhone) {
                            Get.snackbar("인증실패", "휴대폰 인증에 실패하였습니다.", snackPosition: SnackPosition.BOTTOM);
                          } else {
                            _loginUserInfo?.phoneNumber = _phoneEditController.text;
                          }

                          if (mounted) {
                            setState(() {});
                          }
                        },
                        fontSize: 15,
                        buttonHeight: 40,
                      ),
                    ),
                  ],
                ),
                InputEditTextUnderline(
                  editingController: _nameEditController,
                  focusNode: _nameEditFocus,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  title: "이름",
                  hintText: "실명 입력",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "이름을 입력하세요.";
                    }

                    return null;
                  },
                  onSubmitted: (value) {
                    _birthEditFocus.requestFocus();
                  },
                  isRequired: true,
                ),
                InputEditTextUnderline(
                  editingController: _birthEditController,
                  focusNode: _birthEditFocus,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  title: "생년월일",
                  hintText: "(ex) 19981111",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "생년월일을 입력하세요.";
                    }

                    return null;
                  },
                  onSubmitted: (value) {
                    //
                  },
                  isRequired: UniversalPlatform.isIOS ? false : true,
                  inputType: TextInputType.number,
                ),
                InputTitle(
                  title: "성별",
                  isRequired: UniversalPlatform.isIOS ? false : true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _isMen = false;
                            _isWomen = true;

                            if (mounted) {
                              setState(() {});
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _isWomen ? kSelectColor : Colors.white,
                              border: Border.all(
                                color: _isWomen ? kSelectColor : const Color(0xFFE4E7ED),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "여자",
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.1,
                                color: _isWomen ? Colors.white : const Color(0xFF686C73),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _isMen = true;
                            _isWomen = false;

                            if (mounted) {
                              setState(() {});
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _isMen ? kSelectColor : Colors.white,
                              border: Border.all(
                                color: _isMen ? kSelectColor : const Color(0xFFE4E7ED),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "남자",
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.1,
                                color: _isMen ? Colors.white : const Color(0xFF686C73),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 36),
                InputBottomSheet(
                  title: "직위",
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  items: const ["주부", "워킹맘", "직장인", "사장", "직원", "기타"],
                  selectedItem: _selectedJobTitle,
                  onChanged: (value) {
                    _selectedJobTitle = value;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                ),
                const SizedBox(height: 34),
                if (_selectedJobTitle == "주부" ||
                    _selectedJobTitle == "워킹맘" ||
                    _selectedJobTitle == "직장인" ||
                    _selectedJobTitle == "기타")
                  buildHouseKeeperInputs()
                else if (_selectedJobTitle == "사장" || _selectedJobTitle == "직원")
                  buildRestaurantWorkerInput(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BorderRoundedButton(
                    text: "확인",
                    active: true,
                    buttonColor: kMainColor,
                    onPressed: () async {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      currentFocus.unfocus();

                      if (_loginUserInfo?.phoneNumber != _phoneEditController.text) {
                        if (!_isVerifiedPhone) {
                          Get.snackbar('휴대폰 인증', "변경된 휴대폰 번호를 인증하세요",
                              snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                          return;
                        }
                      }

                      if (!_formKey.currentState!.validate()) {
                        if (_passwordEditController.text.isEmpty) {
                          _scrollController.animateTo(_scrollController.position.minScrollExtent + (93 * 1),
                              duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
                          _passwordEditFocus.requestFocus();
                          return;
                        }

                        if (_phoneEditController.text.isEmpty || !_isVerifiedPhone) {
                          _scrollController.animateTo(_scrollController.position.minScrollExtent + (93 * 3),
                              duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
                          _phoneEditFocus.requestFocus();
                          return;
                        }

                        if (_nameEditController.text.isEmpty) {
                          _scrollController.animateTo(_scrollController.position.minScrollExtent + (93 * 4),
                              duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
                          _nameEditFocus.requestFocus();
                          return;
                        }

                        if (_birthEditController.text.isEmpty) {
                          _scrollController.animateTo(_scrollController.position.minScrollExtent + (93 * 6),
                              duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
                          _birthEditFocus.requestFocus();
                          return;
                        }
                      }

                      Map<String, dynamic> params = {};

                      params['name'] = _nameEditController.text;
                      params['phone'] = _phoneEditController.text;

                      if (_birthEditController.text.isNotEmpty) {
                        params['birthday'] = _birthEditController.text;
                      }

                      if (_isMen || _isWomen) {
                        params['gender'] = _isMen ? "M" : "W";
                      }

                      if (_selectedJobTitle.isNotEmpty) {
                        params['position'] = _selectedJobTitle;
                      }

                      if (_selectedJobTitle.isNotEmpty) {
                        if (_selectedJobTitle == "주부" ||
                            _selectedJobTitle == "워킹맘" ||
                            _selectedJobTitle == "직장인" ||
                            _selectedJobTitle == "기타") {
                          if (_isInterestCleanRestaurants) {
                            params['interest_service'] = "음식점 위생정리";
                          } else if (_isInterestCleanSpace) {
                            params['interest_service'] = "공간정리";
                          } else if (_isInterestEudClean) {
                            params['interest_service'] = "정리교육";
                          } else if (_isInterestNothing) {
                            params['interest_service'] = "없음";
                          }

                          if (_isHouseTypeSingle) {
                            params['house_type'] = "단독";
                          } else if (_isHouseTypeVilla) {
                            params['house_type'] = "빌라";
                          } else if (_isHouseTypeApartment) {
                            params['house_type'] = "아파트";
                          } else if (_isHouseTypeOffice) {
                            params['house_type'] = "오피스텔";
                          } else if (_isHouseTypeMix) {
                            params['house_type'] = "주상복합";
                          } else if (_isHouseTypeMarket) {
                            params['house_type'] = "상가";
                          } else if (_isHouseTypeEtc) {
                            params['house_type'] = "기타";
                          }

                          if (_selectedFamilyCount.isNotEmpty) {
                            params['peoples'] = _selectedFamilyCount;
                          }

                          if (_selectedHouseSize.isNotEmpty) {
                            params['house_size'] = _selectedHouseSize;
                          }

                          if (_selectedCleanSpace.isNotEmpty) {
                            params['area_size'] = _selectedCleanSpace;
                          }
                        } else if (_selectedJobTitle == "사장" || _selectedJobTitle == "직원") {
                          if (_isRestaurantTypeKorea) {
                            params['shop_type'] = "한식";
                          } else if (_isRestaurantTypeJap) {
                            params['shop_type'] = "일식";
                          } else if (_isRestaurantTypeChina) {
                            params['shop_type'] = "중식";
                          } else if (_isRestaurantTypeWest) {
                            params['shop_type'] = "양식";
                          } else if (_isRestaurantTypeWest) {
                            params['shop_type'] = "외국음식";
                          } else if (_isRestaurantTypeFusion) {
                            params['shop_type'] = "퓨전";
                          } else if (_isRestaurantTypeBakery) {
                            params['shop_type'] = "베이커리";
                          } else if (_isRestaurantTypeCafe) {
                            params['shop_type'] = "카페";
                          } else if (_isRestaurantTypeDelivery) {
                            params['shop_type'] = "배달전문";
                          } else if (_isRestaurantTypeEtc) {
                            params['shop_type'] = "기타";
                          }

                          if (_selectedRestaurantSize.isNotEmpty) {
                            params['shop_size'] = _selectedRestaurantSize;
                          }

                          if (_selectedKitchenSize.isNotEmpty) {
                            params['kitchen_size'] = _selectedKitchenSize;
                          }

                          if (_isExistWorkInRef) {
                            params['refrigerator'] = "있음";
                          } else if (_isNotExistWorkInRef) {
                            params['refrigerator'] = "없음";
                          }

                          if (_selectedWorkInRefSize.isNotEmpty) {
                            params['refrigerator_size'] = _selectedWorkInRefSize;
                          }

                          if (_ceoEditController.text.isNotEmpty) {
                            params['ceo_name'] = _ceoEditController.text;
                          }
                        }
                      }

                      if (_addressEditController.text.isNotEmpty) {
                        params['address'] = _addressEditController.text;
                      }

                      if (_addAddressEditController.text.isNotEmpty) {
                        params['address2'] = _addAddressEditController.text;
                      }

                      if (_housePhoneEditController.text.isNotEmpty) {
                        params['tel'] = _housePhoneEditController.text;
                      }

                      CommonResponse response = await Network().reqUpdateUser(params);
                      debugPrint('response $response');

                      if (response.status == "200") {
                        debugPrint('response.status is 200');
                        if (_loginUserInfo != null) {
                          if (_isMen || _isWomen) {
                            _loginUserInfo?.gender = _isMen ? "M" : "W";
                          }

                          _loginUserInfo?.phoneNumber = _phoneEditController.text;
                          _loginUserInfo?.name = _nameEditController.text;

                          if (_birthEditController.text.isNotEmpty) {
                            _loginUserInfo?.birth = _birthEditController.text;
                          }
                        }

                        if (_loginUserAreaInfo != null) {
                          _loginUserAreaInfo?.position = _selectedJobTitle;

                          if (_isInterestCleanRestaurants) {
                            _loginUserAreaInfo?.interestService = "음식점 위생정리";
                          } else if (_isInterestCleanSpace) {
                            _loginUserAreaInfo?.interestService = "공간정리";
                          } else if (_isInterestEudClean) {
                            _loginUserAreaInfo?.interestService = "정리 교육";
                          } else if (_isInterestNothing) {
                            _loginUserAreaInfo?.interestService = "없음";
                          }

                          if (_isHouseTypeSingle) {
                            _loginUserAreaInfo?.houseType = "단독";
                          } else if (_isHouseTypeVilla) {
                            _loginUserAreaInfo?.houseType = "빌라";
                          } else if (_isHouseTypeApartment) {
                            _loginUserAreaInfo?.houseType = "아파트";
                          } else if (_isHouseTypeOffice) {
                            _loginUserAreaInfo?.houseType = "오피스텔";
                          } else if (_isHouseTypeMix) {
                            _loginUserAreaInfo?.houseType = "주상복합";
                          } else if (_isHouseTypeMarket) {
                            _loginUserAreaInfo?.houseType = "상가";
                          } else if (_isHouseTypeEtc) {
                            _loginUserAreaInfo?.houseType = "기타";
                          }

                          if (_isRestaurantTypeKorea) {
                            _loginUserAreaInfo?.shopType = "한식";
                          } else if (_isRestaurantTypeJap) {
                            _loginUserAreaInfo?.shopType = "일식";
                          } else if (_isRestaurantTypeChina) {
                            _loginUserAreaInfo?.shopType = "중식";
                          } else if (_isRestaurantTypeWest) {
                            _loginUserAreaInfo?.shopType = "양식";
                          } else if (_isRestaurantTypeForeign) {
                            _loginUserAreaInfo?.shopType = "외국음식";
                          } else if (_isRestaurantTypeFusion) {
                            _loginUserAreaInfo?.shopType = "퓨전";
                          } else if (_isRestaurantTypeBakery) {
                            _loginUserAreaInfo?.shopType = "베이커리";
                          } else if (_isRestaurantTypeCafe) {
                            _loginUserAreaInfo?.shopType = "카페";
                          } else if (_isRestaurantTypeDelivery) {
                            _loginUserAreaInfo?.shopType = "배달전문";
                          } else if (_isRestaurantTypeEtc) {
                            _loginUserAreaInfo?.shopType = "기타";
                          }

                          _loginUserAreaInfo?.shopSize = _selectedRestaurantSize;
                          _loginUserAreaInfo?.kitchenSize = _selectedKitchenSize;

                          if (_isExistWorkInRef) {
                            _loginUserAreaInfo?.refrigerator = "있음";
                          } else if (_isNotExistWorkInRef) {
                            _loginUserAreaInfo?.refrigerator = "없음";
                          }

                          _loginUserAreaInfo?.refrigeratorSize = _selectedWorkInRefSize;

                          _loginUserAreaInfo?.peoples = _selectedFamilyCount;
                          _loginUserAreaInfo?.houseSize = _selectedHouseSize;
                          _loginUserAreaInfo?.areaSize = _selectedCleanSpace;

                          String address = "";
                          if (_addressEditController.text.isNotEmpty) {
                            address = _addressEditController.text;
                          }

                          if (_addAddressEditController.text.isNotEmpty) {
                            address = address + " " + _addAddressEditController.text;
                          }
                          _loginUserAreaInfo?.address = address;

                          _loginUserAreaInfo?.ceoName = _ceoEditController.text;
                          _loginUserAreaInfo?.tel = _housePhoneEditController.text;
                        }

                        Get.back();
                        Get.snackbar('정보변경', "회원정보가 변경되었습니다.",
                            snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                      } else {
                        Get.snackbar('변경실패', "회원정보 변경에 실패하였습니다.",
                            snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                      }
                    },
                  ),
                ),
                const SizedBox(height: 32),
                buildBottomBar
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRestaurantWorkerInput() {
    return Column(
      children: [
        const InputTitle(
          title: "음식점 유형",
          isRequired: false,
          padding: EdgeInsets.symmetric(horizontal: 20),
        ),
        const SizedBox(height: 8),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isRestaurantTypeKorea = true;
                    _isRestaurantTypeJap = false;
                    _isRestaurantTypeChina = false;
                    _isRestaurantTypeWest = false;
                    _isRestaurantTypeForeign = false;
                    _isRestaurantTypeFusion = false;
                    _isRestaurantTypeBakery = false;
                    _isRestaurantTypeCafe = false;
                    _isRestaurantTypeDelivery = false;
                    _isRestaurantTypeEtc = false;

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isRestaurantTypeKorea ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _isRestaurantTypeKorea ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "한식",
                      style: TextStyle(
                        fontSize: 15,
                        color: _isRestaurantTypeKorea ? Colors.white : const Color(0xFF686C73),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isRestaurantTypeKorea = false;
                    _isRestaurantTypeJap = true;
                    _isRestaurantTypeChina = false;
                    _isRestaurantTypeWest = false;
                    _isRestaurantTypeForeign = false;
                    _isRestaurantTypeFusion = false;
                    _isRestaurantTypeBakery = false;
                    _isRestaurantTypeCafe = false;
                    _isRestaurantTypeDelivery = false;
                    _isRestaurantTypeEtc = false;

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isRestaurantTypeJap ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _isRestaurantTypeJap ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "일식",
                      style: TextStyle(
                        fontSize: 15,
                        color: _isRestaurantTypeJap ? Colors.white : const Color(0xFF686C73),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isRestaurantTypeKorea = false;
                    _isRestaurantTypeJap = false;
                    _isRestaurantTypeChina = true;
                    _isRestaurantTypeWest = false;
                    _isRestaurantTypeForeign = false;
                    _isRestaurantTypeFusion = false;
                    _isRestaurantTypeBakery = false;
                    _isRestaurantTypeCafe = false;
                    _isRestaurantTypeDelivery = false;
                    _isRestaurantTypeEtc = false;

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isRestaurantTypeChina ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _isRestaurantTypeChina ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "중식",
                      style: TextStyle(
                        fontSize: 15,
                        color: _isRestaurantTypeChina ? Colors.white : const Color(0xFF686C73),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isRestaurantTypeKorea = false;
                    _isRestaurantTypeJap = false;
                    _isRestaurantTypeChina = false;
                    _isRestaurantTypeWest = true;
                    _isRestaurantTypeForeign = false;
                    _isRestaurantTypeFusion = false;
                    _isRestaurantTypeBakery = false;
                    _isRestaurantTypeCafe = false;
                    _isRestaurantTypeDelivery = false;
                    _isRestaurantTypeEtc = false;

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isRestaurantTypeWest ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _isRestaurantTypeWest ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "양식",
                      style: TextStyle(
                        fontSize: 15,
                        color: _isRestaurantTypeWest ? Colors.white : const Color(0xFF686C73),
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
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isRestaurantTypeKorea = false;
                    _isRestaurantTypeJap = false;
                    _isRestaurantTypeChina = false;
                    _isRestaurantTypeWest = false;
                    _isRestaurantTypeForeign = true;
                    _isRestaurantTypeFusion = false;
                    _isRestaurantTypeBakery = false;
                    _isRestaurantTypeCafe = false;
                    _isRestaurantTypeDelivery = false;
                    _isRestaurantTypeEtc = false;

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isRestaurantTypeForeign ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _isRestaurantTypeForeign ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "외국음식",
                      style: TextStyle(
                        fontSize: 15,
                        color: _isRestaurantTypeForeign ? Colors.white : const Color(0xFF686C73),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isRestaurantTypeKorea = false;
                    _isRestaurantTypeJap = false;
                    _isRestaurantTypeChina = false;
                    _isRestaurantTypeWest = false;
                    _isRestaurantTypeForeign = false;
                    _isRestaurantTypeFusion = true;
                    _isRestaurantTypeBakery = false;
                    _isRestaurantTypeCafe = false;
                    _isRestaurantTypeDelivery = false;
                    _isRestaurantTypeEtc = false;

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isRestaurantTypeFusion ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _isRestaurantTypeFusion ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "퓨전",
                      style: TextStyle(
                        fontSize: 15,
                        color: _isRestaurantTypeFusion ? Colors.white : const Color(0xFF686C73),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isRestaurantTypeKorea = false;
                    _isRestaurantTypeJap = false;
                    _isRestaurantTypeChina = false;
                    _isRestaurantTypeWest = false;
                    _isRestaurantTypeForeign = false;
                    _isRestaurantTypeFusion = false;
                    _isRestaurantTypeBakery = true;
                    _isRestaurantTypeCafe = false;
                    _isRestaurantTypeDelivery = false;
                    _isRestaurantTypeEtc = false;

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isRestaurantTypeBakery ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _isRestaurantTypeBakery ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "베이커리",
                      style: TextStyle(
                        fontSize: 15,
                        color: _isRestaurantTypeBakery ? Colors.white : const Color(0xFF686C73),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isRestaurantTypeKorea = false;
                    _isRestaurantTypeJap = false;
                    _isRestaurantTypeChina = false;
                    _isRestaurantTypeWest = false;
                    _isRestaurantTypeForeign = false;
                    _isRestaurantTypeFusion = false;
                    _isRestaurantTypeBakery = false;
                    _isRestaurantTypeCafe = true;
                    _isRestaurantTypeDelivery = false;
                    _isRestaurantTypeEtc = false;

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isRestaurantTypeCafe ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _isRestaurantTypeCafe ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "카페",
                      style: TextStyle(
                        fontSize: 15,
                        color: _isRestaurantTypeCafe ? Colors.white : const Color(0xFF686C73),
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
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isRestaurantTypeKorea = false;
                    _isRestaurantTypeJap = false;
                    _isRestaurantTypeChina = false;
                    _isRestaurantTypeWest = false;
                    _isRestaurantTypeForeign = false;
                    _isRestaurantTypeFusion = false;
                    _isRestaurantTypeBakery = false;
                    _isRestaurantTypeCafe = false;
                    _isRestaurantTypeDelivery = true;
                    _isRestaurantTypeEtc = false;

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isRestaurantTypeDelivery ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _isRestaurantTypeDelivery ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "배달전문",
                      style: TextStyle(
                        fontSize: 15,
                        color: _isRestaurantTypeDelivery ? Colors.white : const Color(0xFF686C73),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isRestaurantTypeKorea = false;
                    _isRestaurantTypeJap = false;
                    _isRestaurantTypeChina = false;
                    _isRestaurantTypeWest = false;
                    _isRestaurantTypeForeign = false;
                    _isRestaurantTypeFusion = false;
                    _isRestaurantTypeBakery = false;
                    _isRestaurantTypeCafe = false;
                    _isRestaurantTypeDelivery = false;
                    _isRestaurantTypeEtc = true;

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isRestaurantTypeEtc ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _isRestaurantTypeEtc ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "기타",
                      style: TextStyle(
                        fontSize: 15,
                        color: _isRestaurantTypeEtc ? Colors.white : const Color(0xFF686C73),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(child: Container()),
              const SizedBox(width: 8),
              Expanded(child: Container()),
            ],
          ),
        ),
        const SizedBox(height: 36),
        InputBottomSheet(
          title: "업소면적",
          padding: const EdgeInsets.symmetric(horizontal: 20),
          items: const ["10평 이하", "11평 ~ 20평 이하", "21평 ~ 50평 이하", "50평 이상"],
          selectedItem: _selectedRestaurantSize,
          onChanged: (value) {
            _selectedRestaurantSize = value;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        const SizedBox(height: 36),
        InputBottomSheet(
          title: "주방(창고) 면적",
          padding: const EdgeInsets.symmetric(horizontal: 20),
          items: const ["1평 ~ 10평 이하", "11평 ~ 20평 이하", "21평 ~ 30평 이하", "30평 이상"],
          selectedItem: _selectedKitchenSize,
          onChanged: (value) {
            _selectedKitchenSize = value;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        const SizedBox(height: 32),
        const InputTitle(
          title: "워크인 냉장고",
          isRequired: false,
          padding: EdgeInsets.symmetric(horizontal: 20),
        ),
        const SizedBox(height: 8),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isExistWorkInRef = true;
                    _isNotExistWorkInRef = false;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isExistWorkInRef ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _isExistWorkInRef ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "있음",
                      style: TextStyle(
                        fontSize: 15,
                        color: _isExistWorkInRef ? Colors.white : const Color(0xFF686C73),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isExistWorkInRef = false;
                    _isNotExistWorkInRef = true;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isNotExistWorkInRef ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _isNotExistWorkInRef ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "없음",
                      style: TextStyle(
                        fontSize: 15,
                        color: _isNotExistWorkInRef ? Colors.white : const Color(0xFF686C73),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 36),
        InputBottomSheet(
          title: "워크인 냉장고 면적",
          padding: const EdgeInsets.symmetric(horizontal: 20),
          items: const ["1평 이하", "2평 이하", "3평 이하", "모름"],
          selectedItem: _selectedWorkInRefSize,
          onChanged: (value) {
            _selectedWorkInRefSize = value;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        const SizedBox(height: 36),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: InputEditTextUnderline(
                editingController: _addressEditController,
                focusNode: _addressEditFocus,
                padding: const EdgeInsets.only(left: 20, right: 8),
                title: "주소",
                hintText: "주소 입력",
                onSubmitted: (value) {
                  _addAddressEditFocus.requestFocus();
                },
                isRequired: false,
              ),
            ),
            Container(
              width: 88,
              margin: const EdgeInsets.only(right: 20),
              padding: const EdgeInsets.only(top: 14),
              alignment: Alignment.topCenter,
              child: BorderRoundedButton(
                text: "주소검색",
                active: true,
                textColor: const Color(0xFF686C73),
                buttonColor: Colors.white,
                deActiveTextColor: const Color(0xFFE4E7ED),
                deActiveColor: Colors.white,
                onPressed: () async {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  currentFocus.unfocus();

                  Map<String, dynamic>? searchResult = {};
                  searchResult = await Get.toNamed(FindAddressPage.routeName);

                  if (searchResult != null) {
                    _addressEditController.text = searchResult['address'] ?? "";
                    _addAddressEditController.text = searchResult['add_address'] ?? "";
                  }
                },
                fontSize: 15,
                buttonHeight: 40,
              ),
            ),
          ],
        ),
        InputEditTextUnderline(
          editingController: _addAddressEditController,
          focusNode: _addAddressEditFocus,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          title: "추가주소",
          hintText: "추가 주소를 입력하세요.",
          onSubmitted: (value) {
            _ceoEditFocus.requestFocus();
          },
        ),
        InputEditTextUnderline(
          editingController: _ceoEditController,
          focusNode: _ceoEditFocus,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          title: "대표자",
          hintText: "대표자 입력",
          onChanged: (value) {
            //
          },
          validator: (value) {
            return null;
          },
          onSubmitted: (value) {
            //
          },
        ),
        InputEditTextUnderline(
          editingController: _housePhoneEditController,
          focusNode: _housePhoneEditFocus,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          title: "전화번호",
          hintText: "숫자만 입력",
          onChanged: (value) {
            //
          },
          validator: (value) {
            return null;
          },
          onSubmitted: (value) {
            //
          },
          inputType: TextInputType.number,
        ),
      ],
    );
  }

  Widget buildHouseKeeperInputs() {
    return Column(
      children: [
        const InputTitle(
          title: "관심서비스",
          isRequired: false,
          padding: EdgeInsets.symmetric(horizontal: 20),
        ),
        const SizedBox(height: 8),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isInterestCleanRestaurants = true;
                    _isInterestCleanSpace = false;
                    _isInterestEudClean = false;
                    _isInterestNothing = false;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isInterestCleanRestaurants ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _isInterestCleanRestaurants ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "음식점 위생정리",
                      style: TextStyle(
                        fontSize: 15,
                        color: _isInterestCleanRestaurants ? Colors.white : const Color(0xFF686C73),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isInterestCleanRestaurants = false;
                    _isInterestCleanSpace = true;
                    _isInterestEudClean = false;
                    _isInterestNothing = false;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isInterestCleanSpace ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _isInterestCleanSpace ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "공간정리",
                      style: TextStyle(
                        fontSize: 15,
                        color: _isInterestCleanSpace ? Colors.white : const Color(0xFF686C73),
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
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isInterestCleanRestaurants = false;
                    _isInterestCleanSpace = false;
                    _isInterestEudClean = true;
                    _isInterestNothing = false;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isInterestEudClean ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _isInterestEudClean ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "정리 교육",
                      style: TextStyle(
                        fontSize: 15,
                        color: _isInterestEudClean ? Colors.white : const Color(0xFF686C73),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isInterestCleanRestaurants = false;
                    _isInterestCleanSpace = false;
                    _isInterestEudClean = false;
                    _isInterestNothing = true;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isInterestNothing ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _isInterestNothing ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "없음",
                      style: TextStyle(
                        fontSize: 15,
                        color: _isInterestNothing ? Colors.white : const Color(0xFF686C73),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 36, bottom: 8),
          child: Column(
            children: [
              const SizedBox(height: 1),
              Container(
                height: 16,
                alignment: Alignment.centerLeft,
                child: const Text(
                  "주거 형태",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                  ),
                ),
              ),
              const SizedBox(height: 1),
            ],
          ),
        ),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isHouseTypeSingle = true;
                    _isHouseTypeVilla = false;
                    _isHouseTypeApartment = false;
                    _isHouseTypeOffice = false;
                    _isHouseTypeMix = false;
                    _isHouseTypeMarket = false;
                    _isHouseTypeEtc = false;

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isHouseTypeSingle ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _isHouseTypeSingle ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "단독",
                      style: TextStyle(
                        fontSize: 15,
                        color: _isHouseTypeSingle ? Colors.white : const Color(0xFF686C73),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isHouseTypeSingle = false;
                    _isHouseTypeVilla = true;
                    _isHouseTypeApartment = false;
                    _isHouseTypeOffice = false;
                    _isHouseTypeMix = false;
                    _isHouseTypeMarket = false;
                    _isHouseTypeEtc = false;

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isHouseTypeVilla ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _isHouseTypeVilla ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "빌라",
                      style: TextStyle(
                        fontSize: 15,
                        color: _isHouseTypeVilla ? Colors.white : const Color(0xFF686C73),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isHouseTypeSingle = false;
                    _isHouseTypeVilla = false;
                    _isHouseTypeApartment = true;
                    _isHouseTypeOffice = false;
                    _isHouseTypeMix = false;
                    _isHouseTypeMarket = false;
                    _isHouseTypeEtc = false;

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isHouseTypeApartment ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _isHouseTypeApartment ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "아파트",
                      style: TextStyle(
                        fontSize: 15,
                        color: _isHouseTypeApartment ? Colors.white : const Color(0xFF686C73),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isHouseTypeSingle = false;
                    _isHouseTypeVilla = false;
                    _isHouseTypeApartment = false;
                    _isHouseTypeOffice = true;
                    _isHouseTypeMix = false;
                    _isHouseTypeMarket = false;
                    _isHouseTypeEtc = false;

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isHouseTypeOffice ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _isHouseTypeOffice ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "오피스텔",
                      style: TextStyle(
                        fontSize: 15,
                        color: _isHouseTypeOffice ? Colors.white : const Color(0xFF686C73),
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
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isHouseTypeSingle = false;
                    _isHouseTypeVilla = false;
                    _isHouseTypeApartment = false;
                    _isHouseTypeOffice = false;
                    _isHouseTypeMix = true;
                    _isHouseTypeMarket = false;
                    _isHouseTypeEtc = false;

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isHouseTypeMix ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _isHouseTypeMix ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "주상복합",
                      style: TextStyle(
                        fontSize: 15,
                        color: _isHouseTypeMix ? Colors.white : const Color(0xFF686C73),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isHouseTypeSingle = false;
                    _isHouseTypeVilla = false;
                    _isHouseTypeApartment = false;
                    _isHouseTypeOffice = false;
                    _isHouseTypeMix = false;
                    _isHouseTypeMarket = true;
                    _isHouseTypeEtc = false;

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isHouseTypeMarket ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _isHouseTypeMarket ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "상가",
                      style: TextStyle(
                        fontSize: 15,
                        color: _isHouseTypeMarket ? Colors.white : const Color(0xFF686C73),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isHouseTypeSingle = false;
                    _isHouseTypeVilla = false;
                    _isHouseTypeApartment = false;
                    _isHouseTypeOffice = false;
                    _isHouseTypeMix = false;
                    _isHouseTypeMarket = false;
                    _isHouseTypeEtc = true;

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isHouseTypeEtc ? kSelectColor : Colors.white,
                      border: Border.all(
                        color: _isHouseTypeEtc ? kSelectColor : const Color(0xFFE4E7ED),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "기타",
                      style: TextStyle(
                        fontSize: 15,
                        color: _isHouseTypeEtc ? Colors.white : const Color(0xFF686C73),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(child: Container()),
            ],
          ),
        ),
        const SizedBox(height: 36),
        InputBottomSheet(
          title: "가구원수",
          padding: const EdgeInsets.symmetric(horizontal: 20),
          items: const ["1인", "2인", "3인", "4인", "5인", "6인", "7인", "8인", "9인", "10인 이상"],
          selectedItem: _selectedFamilyCount,
          onChanged: (value) {
            _selectedFamilyCount = value;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        const SizedBox(height: 36),
        InputBottomSheet(
          title: "주거공간 평수",
          padding: const EdgeInsets.symmetric(horizontal: 20),
          items: const [
            "1평 ~ 9평",
            "10평 ~ 19평",
            "20평 ~ 29평",
            "30평 ~ 39평",
            "40평 ~ 49평",
            "50평 ~ 59평",
            "60평 ~ 99평",
            "100평 이상"
          ],
          selectedItem: _selectedHouseSize,
          onChanged: (value) {
            _selectedHouseSize = value;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        const SizedBox(height: 36),
        InputBottomSheet(
          title: "정리가 필요한 공간",
          padding: const EdgeInsets.symmetric(horizontal: 20),
          items: const ["전체", "드레스룸", "안방", "주방", "냉장고", "거실", "서재", "장난감방", "공부방", "베란다", "창고", "펜트리", "기타"],
          selectedItem: _selectedCleanSpace,
          onChanged: (value) {
            _selectedCleanSpace = value;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        const SizedBox(height: 36),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: InputEditTextUnderline(
                editingController: _addressEditController,
                focusNode: _addressEditFocus,
                padding: const EdgeInsets.only(left: 20, right: 8),
                title: "주소",
                hintText: "주소 입력",
                onSubmitted: (value) {
                  _addAddressEditFocus.requestFocus();
                },
                isRequired: false,
              ),
            ),
            Container(
              width: 88,
              margin: const EdgeInsets.only(right: 20),
              padding: const EdgeInsets.only(top: 14),
              alignment: Alignment.topCenter,
              child: BorderRoundedButton(
                text: "주소검색",
                active: true,
                textColor: const Color(0xFF686C73),
                buttonColor: Colors.white,
                deActiveTextColor: const Color(0xFFE4E7ED),
                deActiveColor: Colors.white,
                onPressed: () async {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  currentFocus.unfocus();

                  if (UniversalPlatform.isWeb) {
                    Map<String, dynamic>? searchResult = {};
                    searchResult = await Get.toNamed(FindAddressPage.routeName);

                    if (searchResult != null) {
                      _addressEditController.text = searchResult['address'] ?? "";
                      _addAddressEditController.text = searchResult['add_address'] ?? "";
                    }
                  } else {
                    dynamic searchResult;
                    searchResult = await Get.toNamed(AddressSearchPage.routeName);

                    if (searchResult != null && searchResult.isNotEmpty) {
                      _addressEditController.text = searchResult;
                    }
                  }
                },
                fontSize: 15,
                buttonHeight: 40,
              ),
            ),
          ],
        ),
        InputEditTextUnderline(
          editingController: _addAddressEditController,
          focusNode: _addAddressEditFocus,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          title: "추가주소",
          hintText: "추가 주소를 입력하세요.",
          onSubmitted: (value) {
            _housePhoneEditFocus.requestFocus();
          },
        ),
        InputEditTextUnderline(
          editingController: _housePhoneEditController,
          focusNode: _housePhoneEditFocus,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          title: "전화번호",
          hintText: "숫자만 입력",
          onChanged: (value) {
            //
          },
          validator: (value) {
            return null;
          },
          onSubmitted: (value) {
            //
          },
          inputType: TextInputType.number,
        ),
      ],
    );
  }
}
