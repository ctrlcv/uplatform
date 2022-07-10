class LoginUser {
  String? status;
  String? message;
  String? dormant;
  String? type;
  String? token;
  String? email;
  String? snsKey;

  LoginUser({this.status, this.message, this.dormant, this.type, this.token, this.email});

  factory LoginUser.fromJson(Map<String, dynamic> parsedJson) {
    return LoginUser(
      status: parsedJson['status'],
      message: parsedJson['msg'],
      dormant: parsedJson['dormant'],
      type: parsedJson['type'],
      token: parsedJson['token'],
      email: parsedJson['email'],
    );
  }

  @override
  String toString() {
    return 'LoginUser{status: $status, message: $message, dormant: $dormant, type: $type, token: $token, email: $email}';
  }
}

class SignUpResponse {
  String? status;
  String? message;
  String? data;
  String? token;

  SignUpResponse({this.status, this.message, this.token, this.data});

  factory SignUpResponse.fromJson(Map<String, dynamic> parsedJson) {
    return SignUpResponse(
      status: parsedJson['status'],
      message: parsedJson['msg'],
      token: parsedJson['token'],
      data: parsedJson['data'],
    );
  }
}

class KakaoUser {
  String? id;
  String? nickName;
  String? email;

  KakaoUser({this.id, this.nickName, this.email});

  factory KakaoUser.fromJson(Map<String, dynamic> parsedJson) {
    var properties = parsedJson['properties'];
    var kakaoAccount = parsedJson['kakao_account'];

    return KakaoUser(
      id: parsedJson['id'],
      nickName: properties['nickname'],
      email: kakaoAccount['email'],
    );
  }

  @override
  String toString() {
    return 'KakaoUser{id: $id, nickName: $nickName, email: $email}';
  }
}

class NaverUser {
  String? id;
  String? name;
  String? nickName;
  String? email;
  String? accessToken;
  String? refreshToken;

  NaverUser({this.id, this.name, this.nickName, this.email, this.accessToken, this.refreshToken});

  factory NaverUser.fromJson(Map<String, dynamic> parsedJson) {
    var account = parsedJson['account'];

    return NaverUser(
      id: account['id'],
      name: account['name'],
      nickName: account['nickname'],
      email: account['email'],
    );
  }
}

class UserInfo {
  String? userId;
  String? snsKey;
  String? name;
  String? phoneNumber;
  String? email;
  String? userType;
  String? gender;
  String? birth;
  String? regNo;
  String? dormant;

  UserInfo(
      {this.userId,
      this.snsKey,
      this.name,
      this.phoneNumber,
      this.email,
      this.userType,
      this.gender,
      this.birth,
      this.regNo,
      this.dormant});

  factory UserInfo.fromJson(Map<String, dynamic> parsedJson) {
    var jsonData = parsedJson['data'];

    return UserInfo(
      userId: jsonData['id'].toString(),
      snsKey: jsonData['sns_key'],
      name: jsonData['name'],
      phoneNumber: jsonData['phone'],
      email: jsonData['email'],
      userType: jsonData['user_type'].toString(),
      gender: jsonData['gender'],
      birth: jsonData['birthday'],
      regNo: jsonData['reg_no'],
      dormant: jsonData['dormant'],
    );
  }
}

class AreaInfo {
  String? id;
  String? userId;
  String? position;
  String? interestService;
  String? houseType;
  String? peoples;
  String? houseSize;
  String? areaSize;
  String? address;
  String? addAddress;
  String? tel;
  String? shopType;
  String? shopSize;
  String? kitchenSize;
  String? refrigerator;
  String? refrigeratorSize;
  String? shopName;
  String? ceoName;

  AreaInfo(
      {this.id,
      this.userId,
      this.position,
      this.interestService,
      this.houseType,
      this.peoples,
      this.houseSize,
      this.areaSize,
      this.address,
      this.addAddress,
      this.tel,
      this.shopType,
      this.shopSize,
      this.kitchenSize,
      this.refrigerator,
      this.refrigeratorSize,
      this.shopName,
      this.ceoName});

  factory AreaInfo.fromJson(Map<String, dynamic> parsedJson) {
    var jsonData = parsedJson['data'];

    return AreaInfo(
      id: jsonData['id'].toString(),
      userId: jsonData['user_id'].toString(),
      position: jsonData['position'],
      interestService: jsonData['interest_service'],
      houseType: jsonData['house_type'],
      peoples: jsonData['peoples'],
      houseSize: jsonData['house_size'],
      areaSize: jsonData['area_size'],
      address: jsonData['address'],
      addAddress: jsonData['address2'],
      tel: jsonData['tel'],
      shopType: jsonData['shop_type'],
      shopSize: jsonData['shop_size'],
      kitchenSize: jsonData['kitchen_size'],
      refrigerator: jsonData['refrigerator'],
      refrigeratorSize: jsonData['refrigerator_size'],
      shopName: jsonData['shop_name'],
      ceoName: jsonData['ceo_name'],
    );
  }
}

class PartnerInfo {
  String? id;
  String? userId;
  String? serviceType;
  String? partnerType;
  String? confirmHistory;
  String? activityDistance;
  String? licenseImages;
  String? regImages;
  String? position;
  String? job;
  String? bizType;
  String? regNo;
  String? bizName;
  String? address;
  String? addAddress;
  String? ceoName;
  String? tel;

  PartnerInfo(
      {this.id,
      this.userId,
      this.serviceType,
      this.partnerType,
      this.confirmHistory,
      this.activityDistance,
      this.licenseImages,
      this.regImages,
      this.position,
      this.job,
      this.bizType,
      this.regNo,
      this.bizName,
      this.address,
      this.addAddress,
      this.ceoName,
      this.tel});

  factory PartnerInfo.fromJson(Map<String, dynamic> parsedJson) {
    var jsonData = parsedJson['data'];

    return PartnerInfo(
      id: jsonData['id'].toString(),
      userId: jsonData['user_id'].toString(),
      serviceType: jsonData['service_type'],
      partnerType: jsonData['partner_type'],
      confirmHistory: jsonData['confirm_history'],
      activityDistance: jsonData['activity_distance'],
      licenseImages: jsonData['license_img'],
      regImages: jsonData['reg_img'],
      position: jsonData['position'],
      job: jsonData['job'],
      bizType: jsonData['biz_type'],
      regNo: jsonData['reg_no'],
      bizName: jsonData['biz_name'],
      address: jsonData['address'],
      addAddress: jsonData['address2'],
      ceoName: jsonData['ceo_name'],
      tel: jsonData['tel'],
    );
  }
}

class PasswordResponse {
  String? status;
  String? message;

  PasswordResponse({this.status, this.message});

  factory PasswordResponse.fromJson(Map<String, dynamic> parsedJson) {
    return PasswordResponse(
      status: parsedJson['status'],
      message: parsedJson['msg'],
    );
  }
}
