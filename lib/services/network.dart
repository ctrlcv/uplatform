import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:uplatform/components/input_image_picker.dart';
import 'package:uplatform/models/address_model.dart';
import 'package:uplatform/models/booking_model.dart';
import 'package:uplatform/models/common_model.dart';
import 'package:uplatform/models/income_model.dart';
import 'package:uplatform/models/notice_model.dart';
import 'package:uplatform/models/payment_model.dart';
import 'package:uplatform/models/request_model.dart';
import 'package:uplatform/models/user_model.dart';

import 'login_service.dart';

class Network {
  Map<String, String> postHeaders = {HttpHeaders.contentTypeHeader: "application/json"};

  String getApiUrl() {
    return "api.hi-shiny-o.com";
  }

  String getApiPath() {
    return "/api/";
  }

  Map<String, String> getHeader() {
    Map<String, String> headers = {};
    headers["Accept"] = "applcation/json";
    headers["Content-Type"] = "application/json; charset=utf-8";
    LoginUser? loginUser = LoginService().getLoginUser();

    if (loginUser != null) {
      headers["Authorization"] = "Bearer " + loginUser.token!;
    }
    return headers;
  }

  Map<String, String> getPostHeader() {
    Map<String, String> headers = {};
    headers["Accept"] = "applcation/json";
    headers["Content-Type"] = "application/json; charset=utf-8";
    // headers["x-access-token"] = LoginManager().getLoginUser().accessToken;

    return headers;
  }

  Future reqLogIn(Map<String, dynamic> login) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'user/login');
    var jsonBody = jsonEncode(login);

    // debugPrint("reqLogIn $jsonBody");

    var response = await http.post(url, headers: postHeaders, body: jsonBody);
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqLogIn() jsonResponse is null, return');
        return null;
      }

      debugPrint("reqLogIn() jsonResponse $jsonResponse");

      LoginUser loginUser = LoginUser.fromJson(jsonResponse);
      return loginUser;
    } else {
      debugPrint('[Error] reqLogIn() response Error $jsonResponse');
      return null;
    }
  }

  Future reqRegisterUser(Map<String, dynamic> login) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'user/regist');
    var jsonBody = jsonEncode(login);

    // debugPrint('reqRegisterUser() $jsonBody');

    var response = await http.post(url, headers: postHeaders, body: jsonBody);
    dynamic jsonResponse;
    try {
      jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    } catch (e) {
      debugPrint('[Error] reqRegisterUser() decode error, response.body : ${response.body}, e: $e');
      return null;
    }

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqRegisterUser() jsonResponse is null, return');
        return null;
      }

      // debugPrint("reqRegisterUser() jsonResponse $jsonResponse");

      SignUpResponse signUpResponse = SignUpResponse.fromJson(jsonResponse);
      return signUpResponse;
    } else {
      debugPrint('[Error] reqRegisterUser() response Error $jsonResponse');
      return null;
    }
  }

  Future reqRegisterPartner(Map<String, dynamic> params) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'partner/regist');
    var jsonBody = jsonEncode(params);

    // debugPrint("reqRegisterPartner() $jsonBody");

    var response = await http.post(url, headers: postHeaders, body: jsonBody);
    dynamic jsonResponse;

    try {
      jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    } catch (e) {
      debugPrint('[Error] reqRegisterPartner() decode error, response.body : ${response.body}, e: $e');
      return null;
    }

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqRegisterPartner() jsonResponse is null, return');
        return null;
      }

      // debugPrint("reqRegisterPartner() jsonResponse $jsonResponse");

      SignUpResponse signUpResponse = SignUpResponse.fromJson(jsonResponse);
      return signUpResponse;
    } else {
      debugPrint('[Error] reqRegisterPartner() response Error $jsonResponse');
      return null;
    }
  }

  Future reqSnsLogIn(Map<String, dynamic> login) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'user/sns_login');
    var jsonBody = jsonEncode(login);

    // debugPrint("reqSnsLogIn() $jsonBody");

    var response = await http.post(url, headers: postHeaders, body: jsonBody);
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqSnsLogIn() jsonResponse is null, return');
        return null;
      }

      debugPrint("reqSnsLogIn() jsonResponse $jsonResponse");

      LoginUser loginUser = LoginUser.fromJson(jsonResponse);
      return loginUser;
    } else {
      debugPrint('[Error] reqSnsLogIn() response Error $jsonResponse');
      return null;
    }
  }

  Future reqUserInfo() async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'user/info');

    var response = await http.get(url, headers: getHeader());
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqUserInfo() jsonResponse is null, return');
        return null;
      }

      // debugPrint("reqUserInfo() jsonResponse $jsonResponse");

      UserInfo userInfo = UserInfo.fromJson(jsonResponse);
      return userInfo;
    } else {
      debugPrint('[Error] reqUserInfo() response Error $jsonResponse');
      return null;
    }
  }

  Future reqAreaInfo() async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'user/area_info');

    var response = await http.get(url, headers: getHeader());
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (jsonResponse == null) {
      debugPrint('[Error] reqAreaInfo() jsonResponse is null, return');
      return null;
    }

    if (response.statusCode == 200) {
      if (jsonResponse['status'] != "200") {
        debugPrint("[Error] reqPartnerInfo() jsonResponse['status'] ${jsonResponse['status']}");
        return null;
      }

      // debugPrint("reqAreaInfo() jsonResponse $jsonResponse");

      AreaInfo areaInfo = AreaInfo.fromJson(jsonResponse);
      return areaInfo;
    } else {
      debugPrint('[Error] reqAreaInfo() response Error $jsonResponse');
      return null;
    }
  }

  Future reqPartnerInfo() async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'user/partner_info');

    var response = await http.get(url, headers: getHeader());
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (jsonResponse == null) {
      debugPrint('[Error] reqPartnerInfo() jsonResponse is null, return');
      return null;
    }

    if (response.statusCode == 200) {
      if (jsonResponse['status'] != "200") {
        debugPrint("[Error] reqPartnerInfo() jsonResponse['status'] ${jsonResponse['status']}");
        return null;
      }

      debugPrint("reqPartnerInfo() jsonResponse $jsonResponse");

      PartnerInfo partnerInfo = PartnerInfo.fromJson(jsonResponse);
      return partnerInfo;
    } else {
      debugPrint('[Error] reqPartnerInfo() response Error $jsonResponse');
      return null;
    }
  }

  Future reqUploadImage(List<PickImageFile> files, {String type = "local"}) async {
    try {
      var url = Uri.https(getApiUrl(), getApiPath() + 'image/upload');
      var request = http.MultipartRequest('POST', url);

      request.fields['type'] = type;
      int index = 0;

      for (PickImageFile pickFile in files) {
        if (pickFile.fileType == PickImageFileType.networkFile) {
          continue;
        }

        if (pickFile.fileType == PickImageFileType.selectFile) {
          File file = File(pickFile.filePath!);

          request.files.add(
            http.MultipartFile(
              "img_$index",
              file.readAsBytes().asStream(),
              file.lengthSync(),
              filename: pickFile.filePath!,
            ),
          );
        } else if (pickFile.fileType == PickImageFileType.xFile) {
          XFile selectFile = pickFile.xFile!;
          Uint8List bytes = await selectFile.readAsBytes();

          request.files.add(
            http.MultipartFile(
              "img_$index",
              selectFile.readAsBytes().asStream(),
              bytes.length,
              filename: "filename_$index",
            ),
          );
        }
        index++;
      }

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);
      var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        if (jsonResponse == null) {
          debugPrint('[Error] reqUploadImage() jsonResponse is null, return');
          return null;
        }

        debugPrint('reqUploadImage() jsonResponse $jsonResponse');
        return jsonResponse['images'];
      } else {
        debugPrint('[Error] reqUploadImage() response Error $jsonResponse');
        return [];
      }
    } catch (e) {
      debugPrint("[Error] reqUploadImage() exception Error $e");
    }
    return [];
  }

  Future reqUpdateUser(Map<String, dynamic> login) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'user/update');
    var jsonBody = jsonEncode(login);

    // debugPrint("reqUpdateUser() $jsonBody");

    var response = await http.put(url, headers: getHeader(), body: jsonBody);
    dynamic jsonResponse;
    try {
      jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    } catch (e) {
      debugPrint('[Error] reqUpdateUser() decode error, response.body : ${response.body}, e: $e');
      return null;
    }

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqUpdateUser() jsonResponse is null, return');
        return null;
      }

      // debugPrint("reqUpdateUser() jsonResponse $jsonResponse");

      CommonResponse response = CommonResponse.fromJson(jsonResponse);
      return response;
    } else {
      debugPrint('[Error] reqUpdateUser() response Error $jsonResponse');
      return null;
    }
  }

  Future reqUpdatePartner(Map<String, dynamic> login) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'partner/update');
    var jsonBody = jsonEncode(login);

    // debugPrint("reqUpdatePartner() $jsonBody");

    var response = await http.put(url, headers: getHeader(), body: jsonBody);
    dynamic jsonResponse;
    try {
      jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    } catch (e) {
      debugPrint('[Error] reqUpdatePartner() decode error, response.body : ${response.body}, e: $e');
      return null;
    }

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqUpdatePartner() jsonResponse is null, return');
        return null;
      }

      // debugPrint("reqUpdatePartner() jsonResponse $jsonResponse");

      CommonResponse response = CommonResponse.fromJson(jsonResponse);
      return response;
    } else {
      debugPrint('[Error] reqUpdatePartner() response Error $jsonResponse');
      return null;
    }
  }

  Future reqInsertUserInfo(Map<String, dynamic> params) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'area/regist_info');
    var jsonBody = jsonEncode(params);

    // debugPrint("reqInsertPartner() $jsonBody");

    var response = await http.post(url, headers: getHeader(), body: jsonBody);
    dynamic jsonResponse;
    try {
      jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    } catch (e) {
      debugPrint('[Error] reqInsertUserInfo() decode error, response.body : ${response.body}, e: $e');
      return null;
    }

    if (jsonResponse == null) {
      debugPrint('[Error] reqInsertUserInfo() jsonResponse is null, return');
      return null;
    }

    if (response.statusCode == 200) {
      if (jsonResponse['status'] != "200") {
        debugPrint('[Error] reqRequestDetail() response status ${jsonResponse['status']}');
        return null;
      }

      debugPrint("reqInsertUserInfo() jsonResponse $jsonResponse");

      CommonResponse response = CommonResponse.fromJson(jsonResponse);
      return response;
    } else {
      debugPrint('[Error] reqInsertUserInfo() response Error $jsonResponse');
      return null;
    }
  }

  Future reqInsertPartner(Map<String, dynamic> params) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'partner/regist_info');
    var jsonBody = jsonEncode(params);

    // debugPrint("reqInsertPartner() $jsonBody");

    var response = await http.post(url, headers: getHeader(), body: jsonBody);
    dynamic jsonResponse;
    try {
      jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    } catch (e) {
      debugPrint('[Error] reqInsertPartner() decode error, response.body : ${response.body}, e: $e');
      return null;
    }

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqInsertPartner() jsonResponse is null, return');
        return null;
      }

      debugPrint("reqInsertPartner() jsonResponse $jsonResponse");

      CommonResponse response = CommonResponse.fromJson(jsonResponse);
      return response;
    } else {
      debugPrint('[Error] reqInsertPartner() response Error $jsonResponse');
      return null;
    }
  }

  Future reqUpdateUserType(Map<String, dynamic> params) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'user/change/type');
    var jsonBody = jsonEncode(params);

    // debugPrint("reqUpdateUserType() $jsonBody");

    var response = await http.put(url, headers: getHeader(), body: jsonBody);
    dynamic jsonResponse;
    try {
      jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    } catch (e) {
      debugPrint('[Error] reqUpdateUserType() decode error, response.body : ${response.body}, e: $e');
      return null;
    }

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqUpdateUserType() jsonResponse is null, return');
        return null;
      }

      debugPrint("reqUpdateUserType() jsonResponse $jsonResponse");

      CommonResponse response = CommonResponse.fromJson(jsonResponse);
      return response;
    } else {
      debugPrint('[Error] reqUpdateUserType() response Error $jsonResponse');
      return null;
    }
  }

  Future reqLeaveUser() async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'user/leave');
    var response = await http.put(url, headers: getHeader());

    dynamic jsonResponse;
    try {
      jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    } catch (e) {
      debugPrint('[Error] reqLeaveUser() decode error, response.body : ${response.body}, e: $e');
      return null;
    }

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqLeaveUser() jsonResponse is null, return');
        return null;
      }

      // debugPrint("reqLeaveUser() jsonResponse $jsonResponse");

      CommonResponse response = CommonResponse.fromJson(jsonResponse);
      return response;
    } else {
      debugPrint('[Error] reqLeaveUser() response Error $jsonResponse');
      return null;
    }
  }

  Future reqChangePassword(Map<String, dynamic> login) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'user/update/password');
    var jsonBody = jsonEncode(login);

    // debugPrint("reqChangePassword() $jsonBody");

    var response = await http.put(url, headers: getHeader(), body: jsonBody);
    dynamic jsonResponse;
    try {
      jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    } catch (e) {
      debugPrint('[Error] reqChangePassword() decode error, response.body : ${response.body}, e: $e');
      return null;
    }

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqChangePassword() jsonResponse is null, return');
        return null;
      }

      // debugPrint("reqChangePassword() jsonResponse $jsonResponse");

      PasswordResponse response = PasswordResponse.fromJson(jsonResponse);
      return response;
    } else {
      debugPrint('[Error] reqChangePassword() response Error $jsonResponse');
      return null;
    }
  }

  Future reqBookingList(Map<String, dynamic> params) async {
    var url = Uri.https(getApiUrl(), getApiPath() + "reservation/list/user", params);
    var response = await http.get(url, headers: getHeader());

    dynamic jsonResponse;
    try {
      jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    } catch (e) {
      debugPrint('[Error] reqBookingList() decode error, response.body : ${response.body}, e: $e');
      return null;
    }

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqBookingList() jsonResponse is null, return');
        return null;
      }

      // debugPrint("reqBookingList() jsonResponse $jsonResponse");

      ReservationList bookingList = ReservationList.fromJson(jsonResponse);
      if (bookingList.status != "200") {
        return null;
      }

      return bookingList;
    } else {
      debugPrint('[Error] reqBookingList() response Error $jsonResponse');
      return null;
    }
  }

  Future reqBookingDetail(Map<String, dynamic> params) async {
    var url = Uri.https(getApiUrl(), getApiPath() + "reservation/detail", params);
    var response = await http.get(url, headers: getHeader());

    dynamic jsonResponse;

    try {
      jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    } catch (e) {
      debugPrint('[Error] reqBookingDetail() decode error, response.body : ${response.body}, e: $e');
      return null;
    }

    if (jsonResponse == null) {
      debugPrint('[Error] reqBookingDetail() jsonResponse is null, return');
      return null;
    }

    if (response.statusCode == 200) {
      if (jsonResponse['status'] != "200") {
        debugPrint('[Error] reqBookingDetail() jsonResponse.status ${jsonResponse['status']}');
        return null;
      }

      // debugPrint("reqBookingDetail() jsonResponse $jsonResponse");

      ReservationDetail reservationDetail = ReservationDetail.fromJson(jsonResponse['data']);
      return reservationDetail;
    } else {
      debugPrint('[Error] reqBookingDetail() response Error $jsonResponse');
      return null;
    }
  }

  Future reqRequestDetail(Map<String, dynamic> params) async {
    var url = Uri.https(getApiUrl(), getApiPath() + "request/detail", params);
    var response = await http.get(url, headers: getHeader());

    dynamic jsonResponse;

    try {
      jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    } catch (e) {
      debugPrint('[Error] reqRequestDetail() decode error, response.body : ${response.body}, e: $e');
      return null;
    }

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqRequestDetail() jsonResponse is null, return');
        return null;
      }

      // debugPrint("reqRequestDetail() jsonResponse $jsonResponse");

      if (jsonResponse['status'] != "200") {
        debugPrint('[Error] reqRequestDetail() response status ${jsonResponse['status']}');
        return null;
      }

      RequestDetail requestDetail = RequestDetail.fromJson(jsonResponse['data']);
      return requestDetail;
    } else {
      debugPrint('[Error] reqRequestDetail() response Error $jsonResponse');
      return null;
    }
  }

  Future reqReservation(Map<String, dynamic> param) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'reservation/regist');
    var jsonBody = jsonEncode(param);

    // debugPrint("reqReservation() $jsonBody");

    var response = await http.post(url, headers: getHeader(), body: jsonBody);
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqReservation() jsonResponse is null, return');
        return null;
      }

      // debugPrint("reqReservation() jsonResponse $jsonResponse");

      ReservationResponse reservationResponse = ReservationResponse.fromJson(jsonResponse);
      return reservationResponse;
    } else {
      debugPrint('[Error] reqReservation() response Error $jsonResponse');
      return null;
    }
  }

  Future reqServiceList(Map<String, dynamic> param) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'service/list', param);

    var response = await http.get(url, headers: getHeader());
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqServiceList() jsonResponse is null, return');
        return null;
      }

      // debugPrint("reqServiceList() jsonResponse $jsonResponse");

      ServiceItemList serviceItemList = ServiceItemList.fromJson(jsonResponse);
      return serviceItemList.result;
    } else {
      debugPrint('[Error] reqServiceList() response Error $jsonResponse');
      return null;
    }
  }

  Future reqCancelReservation(Map<String, dynamic> param) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'reservation/cancel');
    var jsonBody = jsonEncode(param);

    // debugPrint("reqCancelReservation() $jsonBody");

    var response = await http.put(url, headers: getHeader(), body: jsonBody);
    dynamic jsonResponse;
    try {
      jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    } catch (e) {
      debugPrint('[Error] reqCancelReservation() decode error, response.body : ${response.body}, e: $e');
      return null;
    }

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqCancelReservation() jsonResponse is null, return');
        return null;
      }

      // debugPrint("reqCancelReservation() jsonResponse $jsonResponse");

      CommonResponse response = CommonResponse.fromJson(jsonResponse);
      return response;
    } else {
      debugPrint('[Error] reqCancelReservation() response Error $jsonResponse');
      return null;
    }
  }

  Future reqPartnerRequestList(Map<String, dynamic> params) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'request/list', params);

    var response = await http.get(url, headers: getHeader());
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqPartnerRequestList() jsonResponse is null, return');
        return null;
      }

      // debugPrint('reqPartnerRequestList() jsonResponse $jsonResponse');

      if (jsonResponse['status'] != "200") {
        debugPrint("reqPartnerRequestList() error status ${jsonResponse['status']}");
        return;
      }

      RequestList result = RequestList.fromJson(jsonResponse);
      return result;
    } else {
      debugPrint('[Error] reqPartnerRequestList() response Error $jsonResponse');
      return null;
    }
  }

  Future reqRegApply(Map<String, dynamic> param) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'apply/regist');
    var jsonBody = jsonEncode(param);

    // debugPrint("reqRegApply() $jsonBody");

    var response = await http.post(url, headers: getHeader(), body: jsonBody);
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqRegApply() jsonResponse is null, return');
        return null;
      }

      // debugPrint("reqRegApply() jsonResponse $jsonResponse");

      CommonResponse commonResponse = CommonResponse.fromJson(jsonResponse);
      return commonResponse;
    } else {
      debugPrint('[Error] reqRegApply() response Error $jsonResponse');
      return null;
    }
  }

  Future reqApplyList(Map<String, dynamic> params) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'apply/list/user', params);

    // debugPrint('reqApplyList() url $url');

    var response = await http.get(url, headers: getHeader());
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqApplyList() jsonResponse is null, return');
        return null;
      }

      // debugPrint('reqApplyList() jsonResponse $jsonResponse');
      if (jsonResponse['status'] != "200") {
        debugPrint("reqApplyList() error status ${jsonResponse['status']}");
        return;
      }

      ApplyItemList result = ApplyItemList.fromJson(jsonResponse);
      return result;
    } else {
      debugPrint('[Error] reqApplyList() response Error $jsonResponse');
      return null;
    }
  }

  Future reqApplyDetail(Map<String, dynamic> params) async {
    var url = Uri.https(getApiUrl(), getApiPath() + "apply/detail", params);
    // debugPrint('reqApplyDetail() url $url');

    var response = await http.get(url, headers: getHeader());

    dynamic jsonResponse;

    try {
      jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    } catch (e) {
      debugPrint('[Error] reqApplyDetail() decode error, response.body : ${response.body}, e: $e');
      return null;
    }

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqApplyDetail() jsonResponse is null, return');
        return null;
      }

      // debugPrint("reqApplyDetail() jsonResponse $jsonResponse");
      if (jsonResponse['status'] != "200") {
        debugPrint('[Error] reqApplyDetail() response status ${jsonResponse['status']}');
        return null;
      }

      ApplyDetail applyDetail = ApplyDetail.fromJson(jsonResponse['data']);
      return applyDetail;
    } else {
      debugPrint('[Error] reqApplyDetail() response Error $jsonResponse');
      return null;
    }
  }

  Future reqCancelApply(Map<String, dynamic> param) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'apply/cancel');
    var jsonBody = jsonEncode(param);
    //debugPrint("reqCancelApply() jsonBody $jsonBody");

    var response = await http.put(url, headers: getHeader(), body: jsonBody);
    dynamic jsonResponse;
    try {
      jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    } catch (e) {
      debugPrint('[Error] reqCancelApply() decode error, response.body : ${response.body}, e: $e');
      return null;
    }

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqCancelApply() jsonResponse is null, return');
        return null;
      }

      // debugPrint("reqCancelApply() jsonResponse $jsonResponse");

      CommonResponse response = CommonResponse.fromJson(jsonResponse);
      return response;
    } else {
      debugPrint('[Error] reqCancelApply() response Error $jsonResponse');
      return null;
    }
  }

  Future reqRegisterPayment(Map<String, dynamic> param) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'payment/regist');
    var jsonBody = jsonEncode(param);

    // debugPrint("reqRegisterPayment() jsonBody $jsonBody");

    var response = await http.post(url, headers: getHeader(), body: jsonBody);
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqRegisterPayment() jsonResponse is null, return');
        return null;
      }

      // debugPrint("reqRegisterPayment() jsonResponse $jsonResponse");

      CommonResponse response = CommonResponse.fromJson(jsonResponse);
      return response;
    } else {
      debugPrint('[Error] reqRegisterPayment() response Error $jsonResponse');
      return null;
    }
  }

  Future reqPaymentList(Map<String, dynamic> param) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'payment/list/user', param);

    var response = await http.get(url, headers: getHeader());
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqPaymentList() jsonResponse is null, return');
        return null;
      }

      // debugPrint("reqPaymentList() jsonResponse $jsonResponse");

      PaymentItemList paymentItemList = PaymentItemList.fromJson(jsonResponse);
      return paymentItemList;
    } else {
      debugPrint('[Error] reqPaymentList() response Error $jsonResponse');
      return null;
    }
  }

  Future reqNoticeList(Map<String, dynamic> param) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'notice/list', param);

    var response = await http.get(url, headers: getHeader());
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqNoticeList() jsonResponse is null, return');
        return null;
      }

      // debugPrint("reqNoticeList() jsonResponse $jsonResponse");

      NoticeList noticeList = NoticeList.fromJson(jsonResponse);
      return noticeList;
    } else {
      debugPrint('[Error] reqNoticeList() response Error $jsonResponse');
      return null;
    }
  }

  Future reqFaqList(Map<String, dynamic> param) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'faq/list', param);

    var response = await http.get(url, headers: getHeader());
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqFaqList() jsonResponse is null, return');
        return null;
      }

      debugPrint("reqFaqList() jsonResponse $jsonResponse");

      FAQItemList faqItemList = FAQItemList.fromJson(jsonResponse);
      return faqItemList;
    } else {
      debugPrint('[Error] reqFaqList() response Error $jsonResponse');
      return null;
    }
  }

  Future reqQnaList(Map<String, dynamic> param) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'qna/list', param);

    var response = await http.get(url, headers: getHeader());
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqQnaList() jsonResponse is null, return');
        return null;
      }

      // debugPrint("reqQnaList() jsonResponse $jsonResponse");

      QnaItemList qnaItemList = QnaItemList.fromJson(jsonResponse);
      return qnaItemList;
    } else {
      debugPrint('[Error] reqQnaList() response Error $jsonResponse');
      return null;
    }
  }

  Future reqNoticeDetail(Map<String, dynamic> param) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'notice/detail', param);

    var response = await http.get(url, headers: getHeader());
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqNoticeDetail() jsonResponse is null, return');
        return null;
      }

      // debugPrint("reqNoticeDetail() jsonResponse $jsonResponse");

      NoticeDetail noticeItem = NoticeDetail.fromJson(jsonResponse);
      return noticeItem;
    } else {
      debugPrint('[Error] reqNoticeDetail() response Error $jsonResponse');
      return null;
    }
  }

  Future reqFaqDetail(Map<String, dynamic> param) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'faq/detail', param);

    var response = await http.get(url, headers: getHeader());
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqFaqDetail() jsonResponse is null, return');
        return null;
      }

      // debugPrint("reqFaqDetail() jsonResponse $jsonResponse");

      FaqDetail faqItem = FaqDetail.fromJson(jsonResponse);
      return faqItem;
    } else {
      debugPrint('[Error] reqFaqDetail() response Error $jsonResponse');
      return null;
    }
  }

  Future reqQnaDetail(Map<String, dynamic> param) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'qna/detail', param);

    var response = await http.get(url, headers: getHeader());
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqQnaDetail() jsonResponse is null, return');
        return null;
      }

      // debugPrint("reqQnaDetail() jsonResponse $jsonResponse");

      QnaItemDetail qnaItem = QnaItemDetail.fromJson(jsonResponse['data']);
      return qnaItem;
    } else {
      debugPrint('[Error] reqQnaDetail() response Error $jsonResponse');
      return null;
    }
  }

  Future reqRegisterQuestion(Map<String, dynamic> param) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'qna/regist');
    var jsonBody = jsonEncode(param);

    // debugPrint("reqRegisterQuestion() $jsonBody");

    var response = await http.post(url, headers: getHeader(), body: jsonBody);
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqRegisterQuestion() jsonResponse is null, return');
        return null;
      }

      debugPrint("reqRegisterQuestion() jsonResponse $jsonResponse");

      CommonResponse commonResponse = CommonResponse.fromJson(jsonResponse);
      return commonResponse;
    } else {
      debugPrint('[Error] reqRegisterQuestion() response Error $jsonResponse');
      return null;
    }
  }

  Future reqModifyQuestion(Map<String, dynamic> param) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'qna/update');
    var jsonBody = jsonEncode(param);

    // debugPrint("reqRegisterQuestion() $jsonBody");

    var response = await http.put(url, headers: getHeader(), body: jsonBody);
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqModifyQuestion() jsonResponse is null, return');
        return null;
      }

      debugPrint("reqModifyQuestion() jsonResponse $jsonResponse");

      CommonResponse commonResponse = CommonResponse.fromJson(jsonResponse);
      return commonResponse;
    } else {
      debugPrint('[Error] reqModifyQuestion() response Error $jsonResponse');
      return null;
    }
  }

  Future reqAlarmList() async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'push/list');

    var response = await http.get(url, headers: getHeader());
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqAlarmList() jsonResponse is null, return');
        return null;
      }

      // debugPrint("reqAlarmList() jsonResponse $jsonResponse");

      AlarmItemList alarmList = AlarmItemList.fromJson(jsonResponse);
      return alarmList;
    } else {
      debugPrint('[Error] reqAlarmList() response Error $jsonResponse');
      return null;
    }
  }

  Future reqIncomeList(Map<String, dynamic> params) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'pay/list/user', params);

    var response = await http.get(url, headers: getHeader());
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      if (jsonResponse == null) {
        debugPrint('[Error] reqIncomeList() jsonResponse is null, return');
        return null;
      }

      // debugPrint("reqIncomeList() jsonResponse $jsonResponse");

      if (jsonResponse['status'] != "200") {
        debugPrint('[Error] reqIncomeList() response status ${jsonResponse['status']}');
        return null;
      }

      IncomeItemList resultList = IncomeItemList.fromJson(jsonResponse);
      return resultList;
    } else {
      debugPrint('[Error] reqIncomeList() response Error $jsonResponse');
      return null;
    }
  }

  Future reqIncomeDetail(Map<String, dynamic> params) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'pay/detail', params);

    var response = await http.get(url, headers: getHeader());
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (jsonResponse == null) {
      debugPrint('[Error] reqIncomeDetail() jsonResponse is null, return');
      return null;
    }

    if (response.statusCode == 200) {
      debugPrint("reqIncomeList() jsonResponse $jsonResponse");

      if (jsonResponse['status'] != "200") {
        debugPrint('[Error] reqIncomeDetail() response status ${jsonResponse['status']}');
        return null;
      }

      IncomeDetail result = IncomeDetail.fromJson(jsonResponse);
      return result;
    } else {
      debugPrint('[Error] reqIncomeDetail() response Error $jsonResponse');
      return null;
    }
  }

  Future updateFcmToken(String token) async {
    UserInfo? loginUserInfo = LoginService().getUserInfo();

    if (loginUserInfo == null) {
      debugPrint('[Error] updateFcmToken() loginUserInfo is NULL, return');
      return null;
    }

    Map<String, dynamic> params = {};

    params['user_id'] = loginUserInfo.userId;
    params['fcm_token'] = token;

    var url = Uri.https(getApiUrl(), getApiPath() + 'fcm/update');
    var jsonBody = jsonEncode(params);

    // debugPrint("updateFcmToken() $jsonBody");

    var response = await http.put(url, headers: getHeader(), body: jsonBody);
    dynamic jsonResponse;
    try {
      jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    } catch (e) {
      debugPrint('[Error] updateFcmToken() decode error, response.body : ${response.body}, e: $e');
      return null;
    }

    if (jsonResponse == null) {
      debugPrint('[Error] updateFcmToken() jsonResponse is null, return');
      return null;
    }

    if (response.statusCode == 200) {
      if (jsonResponse['status'] != "200") {
        debugPrint("[Error] updateFcmToken() jsonResponse['status'] ${jsonResponse['status']}");
        debugPrint("[Error] updateFcmToken() jsonResponse $jsonResponse");
        return null;
      }

      debugPrint("updateFcmToken() jsonResponse $jsonResponse");

      CommonResponse response = CommonResponse.fromJson(jsonResponse);
      return response;
    } else {
      debugPrint('[Error] updateFcmToken() response Error $jsonResponse');
      return null;
    }
  }

  Future reqGetEmail(Map<String, dynamic> params) async {
    var url = Uri.https(getApiUrl(), getApiPath() + "user/email", params);
    var response = await http.get(url, headers: getHeader());

    if (response.statusCode == 200) {
      dynamic jsonResponse;
      try {
        jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      } catch (e) {
        debugPrint('[Error] reqGetEmail() decode error, response.body : ${response.body}, e: $e');
        return null;
      }

      if (jsonResponse == null) {
        debugPrint('[Error] reqGetEmail() jsonResponse is null, return');
        return null;
      }

      debugPrint("reqGetEmail() jsonResponse $jsonResponse");

      FindIdResponse findIdResponse = FindIdResponse.fromJson(jsonResponse);

      if (findIdResponse.status != "200") {
        return null;
      }

      return findIdResponse;
    } else {
      debugPrint('[Error] reqGetEmail() response Error ${response.body}');
      return null;
    }
  }

  Future reqChangePasswordByPhone(Map<String, dynamic> params) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'user/update/password_by_phone');
    var jsonBody = jsonEncode(params);

    // debugPrint("reqChangePasswordByPhone() $jsonBody");
    var response = await http.put(url, headers: getHeader(), body: jsonBody);

    if (response.statusCode == 200) {
      dynamic jsonResponse;
      try {
        jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      } catch (e) {
        debugPrint('[Error] reqChangePasswordByPhone() decode error, response.body : ${response.body}, e: $e');
        return null;
      }

      if (jsonResponse == null) {
        debugPrint('[Error] reqChangePasswordByPhone() jsonResponse is null, return');
        return null;
      }

      debugPrint("reqChangePasswordByPhone() jsonResponse $jsonResponse");
      PasswordResponse passwordResponse = PasswordResponse.fromJson(jsonResponse);
      return passwordResponse;
    } else {
      debugPrint('[Error] reqChangePasswordByPhone() response Error ${response.body}');
      return null;
    }
  }

  Future reqRegisterPush(Map<String, dynamic> params) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'api/push/regist');
    var jsonBody = jsonEncode(params);

    debugPrint("reqRegisterPush() $jsonBody");

    var response = await http.post(url, headers: getHeader(), body: jsonBody);
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (jsonResponse == null) {
      debugPrint('[Error] reqRegisterPush() jsonResponse is null, return');
      return null;
    }

    if (response.statusCode == 200) {
      if (jsonResponse['status'] != "200") {
        debugPrint("[Error] reqRegisterPush() jsonResponse['status'] ${jsonResponse['status']}");
        return null;
      }

      debugPrint("reqRegisterPush() jsonResponse $jsonResponse");

      CommonResponse commonResponse = CommonResponse.fromJson(jsonResponse);
      return commonResponse;
    } else {
      debugPrint('[Error] reqRegisterPush() response Error $jsonResponse');
      return null;
    }
  }

  Future reqSearchAddressKeyword(Map<String, dynamic> params) async {
    var headers = {'Authorization': 'KakaoAK 120d8ad199fc0fcefdde7cd563f135b8'};
    var url = Uri.https("dapi.kakao.com", "v2/local/search/keyword.json", params);

    debugPrint("reqSearchAddress() $url");

    var response = await http.get(url, headers: headers);
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (jsonResponse == null) {
      debugPrint('[Error] reqSearchAddress() jsonResponse is null, return');
      return null;
    }

    if (response.statusCode == 200) {
      debugPrint("reqSearchAddress() jsonResponse $jsonResponse");

      AddressResponse addressResponse = AddressResponse.fromJson(jsonResponse);
      return addressResponse;
    } else {
      debugPrint('[Error] reqSearchAddress() response Error $jsonResponse');
      return null;
    }
  }

  Future reqSearchAddress(Map<String, dynamic> params) async {
    var headers = {'Authorization': 'KakaoAK 120d8ad199fc0fcefdde7cd563f135b8'};
    var url = Uri.https("dapi.kakao.com", "v2/local/search/address.json", params);

    debugPrint("reqSearchAddress() $url");

    var response = await http.get(url, headers: headers);
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (jsonResponse == null) {
      debugPrint('[Error] reqSearchAddress() jsonResponse is null, return');
      return null;
    }

    if (response.statusCode == 200) {
      debugPrint("reqSearchAddress() jsonResponse $jsonResponse");

      AddressResponse addressResponse = AddressResponse.fromJson(jsonResponse);
      return addressResponse;
    } else {
      debugPrint('[Error] reqSearchAddress() response Error $jsonResponse');
      return null;
    }
  }

  Future reqGetAddress(Map<String, dynamic> params) async {
    var url = Uri.https("www.juso.go.kr", "/addrlink/addrLinkApi.do", params);

    // debugPrint("reqGetAddress() $url");

    var response = await http.get(url, headers: null);
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (jsonResponse == null) {
      debugPrint('[Error] reqGetAddress() jsonResponse is null, return');
      return null;
    }

    if (response.statusCode == 200) {
      // debugPrint("reqGetAddress() jsonResponse $jsonResponse");

      JusoResult jusoResult = JusoResult.fromJson(jsonResponse);
      return jusoResult;
    } else {
      debugPrint('[Error] reqGetAddress() response Error $jsonResponse');
      return null;
    }
  }

  Future reqDelQnaItem(Map<String, dynamic> params) async {
    var url = Uri.https(getApiUrl(), getApiPath() + 'admin/qna/delete', params);

    var response = await http.delete(url, headers: getHeader());
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    if (jsonResponse == null) {
      debugPrint('[Error] reqDelQnaItem() jsonResponse is null, return');
      return null;
    }

    if (response.statusCode == 200) {
      if (jsonResponse['status'] != "200") {
        debugPrint("[Error] reqDelQnaItem() jsonResponse['status'] ${jsonResponse['status']}");
        return null;
      }

      debugPrint("reqDelQnaItem() jsonResponse $jsonResponse");

      CommonResponse commonResponse = CommonResponse.fromJson(jsonResponse);
      return commonResponse;
    } else {
      debugPrint('[Error] reqDelQnaItem() response Error $jsonResponse');
      return null;
    }
  }
}
