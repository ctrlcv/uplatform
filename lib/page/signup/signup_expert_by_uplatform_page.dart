import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iamport_flutter/model/certification_data.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/input_bottom_sheet.dart';
import 'package:uplatform/components/input_edit_text_underline.dart';
import 'package:uplatform/components/input_image_picker.dart';
import 'package:uplatform/components/input_title.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/dialogs/certification_dialog.dart';
import 'package:uplatform/dialogs/transfer_noti_dialog.dart';
import 'package:uplatform/models/user_model.dart';
import 'package:uplatform/page/common/address_search_page.dart';
import 'package:uplatform/page/common/find_address_page.dart';
import 'package:uplatform/page/common/phone_certification.dart';
import 'package:uplatform/page/signup/signup_finish.dart';
import 'package:uplatform/services/login_service.dart';
import 'package:uplatform/services/network.dart';

import '../start_page.dart';

class SignUpExpertByUPlatformPage extends StatefulWidget {
  const SignUpExpertByUPlatformPage({Key? key}) : super(key: key);

  static const routeName = '/SignUpExpertByUPlatformPage';

  @override
  _SignUpExpertByUPlatformPageState createState() => _SignUpExpertByUPlatformPageState();
}

class _SignUpExpertByUPlatformPageState extends State<SignUpExpertByUPlatformPage> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'SignUpExpertByUPlatformPage');

  final TextEditingController _emailEditController = TextEditingController();
  final FocusNode _emailEditFocus = FocusNode();

  final TextEditingController _passwordEditController = TextEditingController();
  final FocusNode _passwordEditFocus = FocusNode();

  final TextEditingController _rePasswordEditController = TextEditingController();
  final FocusNode _rePasswordEditFocus = FocusNode();

  final TextEditingController _phoneEditController = TextEditingController();
  final FocusNode _phoneEditFocus = FocusNode();

  final TextEditingController _addressEditController = TextEditingController();
  final FocusNode _addressEditFocus = FocusNode();

  final TextEditingController _addAddressEditController = TextEditingController();
  final FocusNode _addAddressEditFocus = FocusNode();

  final TextEditingController _nameEditController = TextEditingController();
  final FocusNode _nameEditFocus = FocusNode();

  final TextEditingController _birthEditController = TextEditingController();
  final FocusNode _birthEditFocus = FocusNode();

  final TextEditingController _ceoEditController = TextEditingController();
  final FocusNode _ceoEditFocus = FocusNode();

  final TextEditingController _housePhoneEditController = TextEditingController();
  final FocusNode _housePhoneEditFocus = FocusNode();

  final TextEditingController _businessNumberEditController = TextEditingController();
  final FocusNode _businessNumberEditFocus = FocusNode();

  final TextEditingController _businessNameEditController = TextEditingController();
  final FocusNode _businessNameEditFocus = FocusNode();

  final ScrollController _scrollController = ScrollController();

  bool _isVerifiedPhone = false;
  bool _isMen = false;
  bool _isWomen = (UniversalPlatform.isIOS) ? false : true;
  String _selectedExpertType = "";

  List<PickImageFile> _selectCertificates = [];
  List<PickImageFile> _selectBusinessRegistrations = [];
  bool _selectCertificatesError = false;
  bool _selectBusinessRegistrationsError = false;

  bool _isPersonalBusiness = true;
  bool _isCompanyBusiness = false;
  bool _isNoneBusiness = false;
  String _selectedWorkType = "";
  String _selectedCleanPositionTypes = "";
  String _selectedCleanCareerCount = "";
  String _selectedCleanScopeOfActivity = "";

  String _selectedSpacePositionTypes = "";
  String _selectedSpaceCareerCount = "";
  String _selectedSpaceScopeOfActivity = "";

  String _selectedEduCareerCount = "";
  String _selectedEduScopeOfActivity = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _emailEditController.dispose();
    _emailEditFocus.dispose();

    _passwordEditController.dispose();
    _passwordEditFocus.dispose();

    _rePasswordEditController.dispose();
    _rePasswordEditFocus.dispose();

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

    _businessNumberEditController.dispose();
    _businessNumberEditFocus.dispose();

    _businessNameEditController.dispose();
    _businessNameEditFocus.dispose();

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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 16),
                const TextTitle(
                  titleText: "회원정보를 입력해 주세요.",
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "이메일을 입력하세요.";
                    }

                    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return "이메일 형식이 맞지 않습니다.";
                    }

                    return null;
                  },
                  onSubmitted: (value) {
                    _passwordEditFocus.requestFocus();
                  },
                  isRequired: true,
                  inputType: TextInputType.emailAddress,
                ),
                InputEditTextUnderline(
                  editingController: _passwordEditController,
                  focusNode: _passwordEditFocus,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  title: "비밀번호",
                  hintText: "8자 이상 영문, 숫자, 특수기호 혼합",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "비밀번호를 입력하세요.";
                    }

                    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return "8자 이상 영문, 숫자, 특수기호 혼합";
                    }

                    return null;
                  },
                  onSubmitted: (value) {
                    _rePasswordEditFocus.requestFocus();
                  },
                  isRequired: true,
                  isObscureText: true,
                ),
                InputEditTextUnderline(
                  editingController: _rePasswordEditController,
                  focusNode: _rePasswordEditFocus,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  title: "비밀번호 확인",
                  hintText: "비밀번호 재입력",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "비밀번호를 입력하세요.";
                    }

                    if (value != _passwordEditController.text) {
                      return "비밀번호가 일치하지 않습니다.";
                    }

                    return null;
                  },
                  onSubmitted: (value) {
                    _phoneEditFocus.requestFocus();
                  },
                  isRequired: true,
                  isObscureText: true,
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
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "휴대폰 번호를 입력하세요.";
                          }

                          if (!_isVerifiedPhone) {
                            return "휴대폰을 인증해 주세요.";
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
                            final certResult = await showDialog(
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

                          if (!_isVerifiedPhone) {
                            Get.snackbar("인증실패", "휴대폰 인증에 실패하였습니다.", snackPosition: SnackPosition.BOTTOM);
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
                  title: "전문가 유형",
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  items: const ["위생정리 전문가", "공간정리 전문가", "정리전문가 강사"],
                  isRequired: true,
                  selectedItem: _selectedExpertType,
                  onChanged: (value) {
                    _selectedExpertType = value;

                    if (mounted) {
                      setState(() {});
                    }
                  },
                ),
                if (_selectedExpertType == "위생정리 전문가") buildCleanExpertInputs(),
                if (_selectedExpertType == "공간정리 전문가") buildSpaceExpertInput(),
                if (_selectedExpertType == "정리전문가 강사") buildEducationExpertInput(),
                const SizedBox(height: 34),
                InputImagePicker(
                  key: GlobalKey(debugLabel: "Certificates"),
                  title: "증명서(자격) 첨부",
                  isRequired: false,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  selectedImagesPath: _selectCertificates,
                  showErrorText: _selectCertificatesError,
                  errorText: "증명서를 첨부하세요.",
                  onChanged: (values) {
                    _selectCertificates = values;
                  },
                ),
                const SizedBox(height: 6),
                InputImagePicker(
                  key: GlobalKey(debugLabel: "BusinessReg"),
                  title: "사업자 등록증 첨부",
                  isRequired: false,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  showErrorText: _selectBusinessRegistrationsError,
                  errorText: "사업자 등록증을 첨부하세요.",
                  selectedImagesPath: _selectBusinessRegistrations,
                  onChanged: (values) {
                    _selectBusinessRegistrations = values;
                  },
                ),
                const SizedBox(height: 8),
                const InputTitle(
                  title: "사업자 구분",
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
                            _isPersonalBusiness = true;
                            _isCompanyBusiness = false;
                            _isNoneBusiness = false;
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _isPersonalBusiness ? kSelectColor : Colors.white,
                              border: Border.all(
                                color: _isPersonalBusiness ? kSelectColor : const Color(0xFFE4E7ED),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "개인사업자",
                              style: TextStyle(
                                fontSize: 15,
                                color: _isPersonalBusiness ? Colors.white : const Color(0xFF686C73),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _isPersonalBusiness = false;
                            _isCompanyBusiness = true;
                            _isNoneBusiness = false;
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _isCompanyBusiness ? kSelectColor : Colors.white,
                              border: Border.all(
                                color: _isCompanyBusiness ? kSelectColor : const Color(0xFFE4E7ED),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "법인사업자",
                              style: TextStyle(
                                fontSize: 15,
                                color: _isCompanyBusiness ? Colors.white : const Color(0xFF686C73),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _isPersonalBusiness = false;
                            _isCompanyBusiness = false;
                            _isNoneBusiness = true;
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _isNoneBusiness ? kSelectColor : Colors.white,
                              border: Border.all(
                                color: _isNoneBusiness ? kSelectColor : const Color(0xFFE4E7ED),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "없음",
                              style: TextStyle(
                                fontSize: 15,
                                color: _isNoneBusiness ? Colors.white : const Color(0xFF686C73),
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
                  title: "직무",
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  items: const ["대표", "인턴", "팀원", "영역팀장", "전체팀장", "위생 컨설턴트", "기타"],
                  selectedItem: _selectedWorkType,
                  onChanged: (value) {
                    _selectedWorkType = value;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                ),
                const SizedBox(height: 34),
                InputEditTextUnderline(
                  editingController: _businessNumberEditController,
                  focusNode: _businessNumberEditFocus,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  title: "사업자번호",
                  hintText: "(-)없이 입력",
                  onSubmitted: (value) {
                    _businessNameEditFocus.requestFocus();
                  },
                  inputType: TextInputType.number,
                ),
                InputEditTextUnderline(
                  editingController: _businessNameEditController,
                  focusNode: _businessNameEditFocus,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  title: "상호명",
                  hintText: "사업자 상호명 입력",
                  onSubmitted: (value) {
                    _addressEditFocus.requestFocus();
                  },
                ),
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
                    _ceoEditFocus.requestFocus();
                  },
                ),
                InputEditTextUnderline(
                  editingController: _ceoEditController,
                  focusNode: _ceoEditFocus,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  title: "대표자",
                  hintText: "대표자 입력",
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
                  inputType: TextInputType.number,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BorderRoundedButton(
                    text: "회원가입",
                    active: true,
                    buttonColor: kMainColor,
                    onPressed: () async {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      currentFocus.unfocus();

                      if (!_formKey.currentState!.validate()) {
                        if (_emailEditController.text.isEmpty) {
                          _scrollController.animateTo(_scrollController.position.minScrollExtent,
                              duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
                          _emailEditFocus.requestFocus();
                          return;
                        }

                        if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(_emailEditController.text)) {
                          _scrollController.animateTo(_scrollController.position.minScrollExtent,
                              duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
                          _emailEditFocus.requestFocus();
                          return;
                        }

                        if (_passwordEditController.text.isEmpty) {
                          _scrollController.animateTo(_scrollController.position.minScrollExtent + (93 * 1),
                              duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
                          _passwordEditFocus.requestFocus();
                          return;
                        }

                        if (!RegExp(r"^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,}$")
                            .hasMatch(_passwordEditController.text)) {
                          _scrollController.animateTo(_scrollController.position.minScrollExtent + (93 * 1),
                              duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
                          _passwordEditFocus.requestFocus();
                          return;
                        }

                        if (_rePasswordEditController.text.isEmpty) {
                          _scrollController.animateTo(_scrollController.position.minScrollExtent + (93 * 2),
                              duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
                          _rePasswordEditFocus.requestFocus();
                          return;
                        }

                        if (_passwordEditController.text != _rePasswordEditController.text) {
                          _scrollController.animateTo(_scrollController.position.minScrollExtent + (93 * 2),
                              duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
                          _rePasswordEditFocus.requestFocus();
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

                      if (_selectedExpertType.isEmpty) {
                        _scrollController.animateTo(_scrollController.position.minScrollExtent + (93 * 7),
                            duration: const Duration(milliseconds: 200), curve: Curves.easeOut);

                        Get.snackbar('전문가 유형', "전문가 유형을 선택하세요",
                            snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));

                        if (mounted) {
                          setState(() {});
                        }
                      }

                      if (_selectCertificates.isEmpty) {
                        _scrollController.animateTo(_scrollController.position.minScrollExtent + (93 * 8),
                            duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
                        _selectCertificatesError = false;
                        if (mounted) {
                          setState(() {});
                        }
                        return;
                      }
                      //
                      // if (_selectBusinessRegistrations.isEmpty) {
                      //   _scrollController.animateTo(_scrollController.position.minScrollExtent + (93 * 9),
                      //       duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
                      //   _selectBusinessRegistrationsError = false;
                      //   if (mounted) {
                      //     setState(() {});
                      //   }
                      //   return;
                      // }

                      debugPrint("before upload _selectCertificates $_selectCertificates");
                      List<PickImageFile> uploadCertImages = [];

                      for (int i = 0; i < _selectCertificates.length; i++) {
                        if (_selectCertificates[i].fileType == PickImageFileType.networkFile) {
                          continue;
                        }

                        uploadCertImages.add(_selectCertificates[i]);
                      }

                      List<dynamic> uploadCertificatesResult = [];

                      if (uploadCertImages.isNotEmpty) {
                        uploadCertificatesResult = await Network().reqUploadImage(uploadCertImages);

                        int index = 0;
                        for (int i = 0; i < _selectCertificates.length; i++) {
                          if (_selectCertificates[i].fileType == PickImageFileType.networkFile) {
                            continue;
                          }

                          _selectCertificates[i].fileType = PickImageFileType.networkFile;
                          _selectCertificates[i].filePath = uploadCertificatesResult[index];
                          index++;
                        }
                      }

                      debugPrint("after upload _selectCertificates $_selectCertificates");
                      debugPrint("before upload _selectBusinessRegistrations $_selectBusinessRegistrations");

                      List<PickImageFile> uploadRegImages = [];

                      for (int i = 0; i < _selectBusinessRegistrations.length; i++) {
                        if (_selectBusinessRegistrations[i].fileType == PickImageFileType.networkFile) {
                          continue;
                        }

                        uploadRegImages.add(_selectBusinessRegistrations[i]);
                      }

                      List<dynamic> uploadBusinessRegistrationsResult = [];

                      if (uploadRegImages.isNotEmpty) {
                        uploadBusinessRegistrationsResult = await Network().reqUploadImage(uploadRegImages);

                        int index = 0;
                        for (int i = 0; i < _selectBusinessRegistrations.length; i++) {
                          if (_selectBusinessRegistrations[i].fileType == PickImageFileType.networkFile) {
                            continue;
                          }

                          _selectBusinessRegistrations[i].fileType = PickImageFileType.networkFile;
                          _selectBusinessRegistrations[i].filePath = uploadBusinessRegistrationsResult[index];
                          index++;
                        }
                      }

                      debugPrint("after upload _selectBusinessRegistrations $_selectBusinessRegistrations");

                      Map<String, dynamic> params = {};
                      params['email'] = _emailEditController.text;
                      params['password'] = _passwordEditController.text;
                      params['phone'] = _phoneEditController.text;
                      params['name'] = _nameEditController.text;

                      if (_birthEditController.text.isNotEmpty) {
                        params['birthday'] = _birthEditController.text;
                      }

                      if (_isMen || _isWomen) {
                        params['gender'] = _isMen ? "M" : "W";
                      }

                      if (_selectedExpertType.isNotEmpty) {
                        if (_selectedExpertType == "위생정리 전문가") {
                          params['partner_type'] = "CS";
                          if (_selectedCleanPositionTypes.isNotEmpty) {
                            if (_selectedCleanPositionTypes.substring(0, 1) == ',') {
                              _selectedCleanPositionTypes = _selectedCleanPositionTypes.substring(1);
                            }

                            params['position'] = _selectedCleanPositionTypes;
                          }

                          if (_selectedCleanCareerCount.isNotEmpty) {
                            params['confirm_history'] = _selectedCleanCareerCount;
                          }

                          if (_selectedCleanScopeOfActivity.isNotEmpty) {
                            params['activity_distance'] = _selectedCleanScopeOfActivity;
                          }
                        } else if (_selectedExpertType == "공간정리 전문가") {
                          params['partner_type'] = "CR";
                          if (_selectedSpacePositionTypes.isNotEmpty) {
                            if (_selectedSpacePositionTypes.substring(0, 1) == ',') {
                              _selectedSpacePositionTypes = _selectedSpacePositionTypes.substring(1);
                            }

                            params['position'] = _selectedSpacePositionTypes;
                          }

                          if (_selectedSpaceCareerCount.isNotEmpty) {
                            params['confirm_history'] = _selectedSpaceCareerCount;
                          }

                          if (_selectedSpaceScopeOfActivity.isNotEmpty) {
                            params['activity_distance'] = _selectedSpaceScopeOfActivity;
                          }
                        } else if (_selectedExpertType == "정리전문가 강사") {
                          params['partner_type'] = "LC";
                          if (_selectedEduCareerCount.isNotEmpty) {
                            params['confirm_history'] = _selectedEduCareerCount;
                          }

                          if (_selectedEduScopeOfActivity.isNotEmpty) {
                            params['activity_distance'] = _selectedEduScopeOfActivity;
                          }
                        }
                      }

                      if (_selectCertificates.isNotEmpty) {
                        String certificatesStr = "";
                        for (int i = 0; i < _selectCertificates.length; i++) {
                          certificatesStr = certificatesStr + ((i != 0) ? "," : "") + _selectCertificates[i].filePath!;
                        }
                        params['license_img'] = "[" + certificatesStr + "]";
                      }

                      if (_selectBusinessRegistrations.isNotEmpty) {
                        String businessRegStr = "";
                        for (int i = 0; i < _selectBusinessRegistrations.length; i++) {
                          businessRegStr =
                              businessRegStr + ((i != 0) ? "," : "") + _selectBusinessRegistrations[i].filePath!;
                        }
                        params['reg_img'] = "[" + businessRegStr + "]";
                      }

                      if (_isPersonalBusiness) {
                        params['biz_type'] = "개인사업자";
                      } else if (_isCompanyBusiness) {
                        params['biz_type'] = "법인사업자";
                      } else if (_isNoneBusiness) {
                        params['biz_type'] = "없음";
                      }

                      if (_selectedWorkType.isNotEmpty) {
                        params['job'] = _selectedWorkType;
                      }

                      if (_businessNumberEditController.text.isNotEmpty) {
                        params['biz_reg_no'] = _businessNumberEditController.text;
                      }

                      if (_businessNameEditController.text.isNotEmpty) {
                        params['biz_name'] = _businessNameEditController.text;
                      }

                      if (_ceoEditController.text.isNotEmpty) {
                        params['ceo_name'] = _ceoEditController.text;
                      }

                      String address = "";
                      if (_addressEditController.text.isNotEmpty) {
                        address = _addressEditController.text;
                      }

                      if (_addAddressEditController.text.isNotEmpty) {
                        address = address + " " + _addAddressEditController.text;
                      }

                      if (address.isNotEmpty) {
                        params['address'] = address;
                      }

                      if (_housePhoneEditController.text.isNotEmpty) {
                        params['tel'] = _housePhoneEditController.text;
                      }

                      SignUpResponse result = await Network().reqRegisterPartner(params);

                      if (result.status == "200") {
                        Map<String, dynamic> loginParams = {};
                        loginParams['email'] = _emailEditController.text;
                        loginParams['password'] = _passwordEditController.text;

                        LoginUser user = await Network().reqLogIn(params);

                        if (user.status == "200") {
                          user.email = _emailEditController.text;
                          LoginService().setLoginUser(user);
                        }
                        Get.toNamed(SignUpFinish.routeName, arguments: "isExpertMember");
                      } else {
                        if (result.status! == "602" && result.message! == "사용중인 이메일") {
                          String resultStr = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const TransferNotiDialog(
                                type: "email",
                                arguments: "Expert",
                              );
                            },
                            barrierDismissible: false,
                          );
                          return;
                        }

                        if (result.status! == "603" && result.message! == "사용중인 폰 번호") {
                          String resultStr = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const TransferNotiDialog(
                                type: "phone",
                                arguments: "Expert",
                              );
                            },
                            barrierDismissible: false,
                          );

                          _isVerifiedPhone = false;
                          if (mounted) {
                            setState(() {});
                          }
                          return;
                        }

                        Get.snackbar('가입실패', "회원가입에 실패하였습니다.(" + result.status! + ")",
                            snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));

                        Get.toNamed(StartPage.routeName);
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

  Widget buildCleanExpertInputs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          const SizedBox(height: 36),
          InputBottomSheet(
            key: GlobalKey(debugLabel: 'Clean'),
            title: "직위",
            padding: const EdgeInsets.symmetric(horizontal: 20),
            items: const ["대표", "인턴", "팀원", "영역팀장", "전체팀장", "위생 컨설턴트", "기타"],
            selectedItem: _selectedCleanPositionTypes,
            isMultiSelect: true,
            onChanged: (value) {
              _selectedCleanPositionTypes = value;

              if (mounted) {
                setState(() {});
              }
            },
          ),
          const SizedBox(height: 36),
          InputBottomSheet(
            key: GlobalKey(debugLabel: 'Clean'),
            title: "경력",
            padding: const EdgeInsets.symmetric(horizontal: 20),
            items: const ["0회 - 10회", "11회 - 20회", "21회 - 50회", "51회 이상"],
            selectedItem: _selectedCleanCareerCount,
            onChanged: (value) {
              _selectedCleanCareerCount = value;

              if (mounted) {
                setState(() {});
              }
            },
          ),
          const SizedBox(height: 36),
          InputBottomSheet(
            key: GlobalKey(debugLabel: 'Clean'),
            title: "활동범위",
            padding: const EdgeInsets.symmetric(horizontal: 20),
            items: const ["반경 2km", "반경 5km", "반경 10km", "반경 25km", "반경 50km", "반경 100km"],
            selectedItem: _selectedCleanScopeOfActivity,
            onChanged: (value) {
              _selectedCleanScopeOfActivity = value;

              if (mounted) {
                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildSpaceExpertInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          const SizedBox(height: 36),
          InputBottomSheet(
            key: GlobalKey(debugLabel: 'Space'),
            title: "직위",
            padding: const EdgeInsets.symmetric(horizontal: 20),
            items: const ["대표", "인턴", "팀원", "영역팀장", "전체팀장", "위생 컨설턴트", "기타"],
            selectedItem: _selectedSpacePositionTypes,
            isMultiSelect: true,
            onChanged: (value) {
              _selectedSpacePositionTypes = value;

              if (mounted) {
                setState(() {});
              }
            },
          ),
          const SizedBox(height: 36),
          InputBottomSheet(
            key: GlobalKey(debugLabel: 'Space'),
            title: "경력",
            padding: const EdgeInsets.symmetric(horizontal: 20),
            items: const ["0회 - 10회", "11회 - 30회", "31회 - 60회", "61회 - 99회", "100회 이상"],
            selectedItem: _selectedSpaceCareerCount,
            onChanged: (value) {
              _selectedSpaceCareerCount = value;

              if (mounted) {
                setState(() {});
              }
            },
          ),
          const SizedBox(height: 36),
          InputBottomSheet(
            key: GlobalKey(debugLabel: 'Space'),
            title: "활동범위",
            padding: const EdgeInsets.symmetric(horizontal: 20),
            items: const ["반경 2km", "반경 5km", "반경 10km", "반경 25km", "반경 50km", "반경 100km"],
            selectedItem: _selectedSpaceScopeOfActivity,
            onChanged: (value) {
              _selectedSpaceScopeOfActivity = value;

              if (mounted) {
                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildEducationExpertInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          const SizedBox(height: 36),
          InputBottomSheet(
            key: GlobalKey(debugLabel: 'Edu'),
            title: "교육누적시간",
            padding: const EdgeInsets.symmetric(horizontal: 20),
            items: const ["0 - 30시간", "100시간 미만", "300시간 미만", "300시간 이상"],
            selectedItem: _selectedEduCareerCount,
            onChanged: (value) {
              _selectedEduCareerCount = value;

              if (mounted) {
                setState(() {});
              }
            },
          ),
          const SizedBox(height: 36),
          InputBottomSheet(
            key: GlobalKey(debugLabel: 'Edu'),
            title: "활동가능거리",
            padding: const EdgeInsets.symmetric(horizontal: 20),
            items: const ["반경 20km", "반경 50km", "반경 100km", "전국", "온라인"],
            selectedItem: _selectedEduScopeOfActivity,
            isMultiSelect: true,
            onChanged: (value) {
              _selectedEduScopeOfActivity = value;

              if (mounted) {
                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }
}
