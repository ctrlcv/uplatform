import 'package:flutter/material.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/input_bottom_sheet.dart';
import 'package:uplatform/components/input_edit_text_underline.dart';
import 'package:uplatform/components/input_image_picker.dart';
import 'package:uplatform/components/input_title.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/common_model.dart';
import 'package:uplatform/models/user_model.dart';
import 'package:uplatform/page/common/address_search_page.dart';
import 'package:uplatform/page/common/find_address_page.dart';
import 'package:uplatform/services/login_service.dart';
import 'package:get/get.dart';
import 'package:uplatform/services/network.dart';
import 'package:universal_platform/universal_platform.dart';

class TransferToExpertPage extends StatefulWidget {
  const TransferToExpertPage({Key? key}) : super(key: key);

  static const routeName = '/TransferToExpertPage';

  @override
  _TransferToExpertPageState createState() => _TransferToExpertPageState();
}

class _TransferToExpertPageState extends State<TransferToExpertPage> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'TransferToExpertPage');

  final TextEditingController _emailEditController = TextEditingController();
  final FocusNode _emailEditFocus = FocusNode();

  final TextEditingController _snsTypeEditController = TextEditingController();
  final FocusNode _snsTypeEditFocus = FocusNode();

  final TextEditingController _passwordEditController = TextEditingController();
  final FocusNode _passwordEditFocus = FocusNode();

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

  LoginUser? _loginUser;
  UserInfo? _loginUserInfo;

  String _snsType = "";

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  @override
  void dispose() {
    super.dispose();

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

    _businessNumberEditController.dispose();
    _businessNumberEditFocus.dispose();

    _businessNameEditController.dispose();
    _businessNameEditFocus.dispose();

    _scrollController.dispose();
  }

  void loadUserData() {
    _loginUser = LoginService().getLoginUser();
    _loginUserInfo = LoginService().getUserInfo();

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
      _nameEditController.text = _loginUserInfo?.name ?? "";
      _birthEditController.text = _loginUserInfo?.birth ?? "";
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
                  titleText: "전문가회원으로 전환",
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
                  InputEditTextUnderline(
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
                InputEditTextUnderline(
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
                  onSubmitted: (value) {
                    _nameEditFocus.requestFocus();
                  },
                  isRequired: true,
                  isReadOnly: true,
                  inputType: TextInputType.number,
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
                  isReadOnly: true,
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
                  isRequired: UniversalPlatform.isIOS ? false : true,
                  isReadOnly: true,
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
                      if (_isWomen)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _isMen = false;
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
                                  color: _isWomen ? Colors.white : const Color(0xFF686C73),
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (_isMen)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _isMen = true;
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
                  isRequired: true,
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

                          dynamic searchResult;
                          searchResult = await Get.toNamed(FindAddressPage.routeName);

                          if (searchResult != null && searchResult.isNotEmpty) {
                            _addressEditController.text = searchResult;
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
                    text: "확인",
                    active: true,
                    buttonColor: kMainColor,
                    onPressed: () async {
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

                      if (_selectedExpertType.isEmpty) {
                        _scrollController.animateTo(_scrollController.position.minScrollExtent + (93 * 7),
                            duration: const Duration(milliseconds: 200), curve: Curves.easeOut);

                        Get.snackbar('전문가 유형', "전문가 유형을 선택하세요",
                            snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));

                        if (mounted) {
                          setState(() {});
                        }
                      }

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

                      params['user_id'] = _loginUserInfo!.userId;

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
                          businessRegStr = businessRegStr + ((i != 0) ? "," : "") + _selectBusinessRegistrations[i]
                              .filePath!;
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

                      if (_addressEditController.text.isNotEmpty) {
                        params['address'] = _addressEditController.text;
                      }

                      if (_addAddressEditController.text.isNotEmpty) {
                        params['address2'] = _addAddressEditController.text;
                      }

                      if (_housePhoneEditController.text.isNotEmpty) {
                        params['tel'] = _housePhoneEditController.text;
                      }

                      CommonResponse result = await Network().reqInsertPartner(params);

                      if (result.status == "200") {
                        Get.back();
                      } else {
                        Get.snackbar('변경실패', "회원정보 추가에 실패하였습니다.",
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
