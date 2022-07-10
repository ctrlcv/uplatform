class Meta {
  int? totalCount;
  int? pageableCount;
  bool? isEnd;

  Meta({this.totalCount, this.pageableCount, this.isEnd});

  factory Meta.fromJson(Map<String, dynamic> parsedJson) {
    return Meta(
      totalCount: parsedJson['total_count'],
      pageableCount: parsedJson['pageable_count'],
      isEnd: parsedJson['is_end'],
    );
  }

  @override
  String toString() {
    return 'Meta{totalCount: $totalCount, pageableCount: $pageableCount, isEnd: $isEnd}';
  }
}

class Address {
  String? addressName;
  String? region1DepthName;
  String? region2DepthName;
  String? region3DepthName;
  String? region3DepthHName;
  String? hCode;
  String? bCode;
  String? mountainYn;
  String? mainAddressNo;
  String? subAddressNo;
  String? zipCode;
  String? xCode;
  String? yCode;

  Address({
    this.addressName,
    this.region1DepthName,
    this.region2DepthName,
    this.region3DepthName,
    this.region3DepthHName,
    this.hCode,
    this.bCode,
    this.mountainYn,
    this.mainAddressNo,
    this.subAddressNo,
    this.zipCode,
    this.xCode,
    this.yCode,
  });

  factory Address.fromJson(Map<String, dynamic> parsedJson) {
    return Address(
      addressName: parsedJson['address_name'],
      region1DepthName: parsedJson['region_1depth_name'],
      region2DepthName: parsedJson['region_2depth_name'],
      region3DepthName: parsedJson['region_3depth_name'],
      region3DepthHName: parsedJson['region_3depth_h_name'],
      hCode: parsedJson['h_code'],
      bCode: parsedJson['b_code'],
      mountainYn: parsedJson['mountain_yn'],
      mainAddressNo: parsedJson['main_address_no'],
      subAddressNo: parsedJson['sub_address_no'],
      zipCode: parsedJson['zip_code'],
      xCode: parsedJson['x'],
      yCode: parsedJson['y'],
    );
  }

  @override
  String toString() {
    return 'Address{addressName: $addressName, region1DepthName: $region1DepthName, region2DepthName: $region2DepthName, region3DepthName: $region3DepthName, region3DepthHName: $region3DepthHName, hCode: $hCode, bCode: $bCode, mountainYn: $mountainYn, mainAddressNo: $mainAddressNo, subAddressNo: $subAddressNo, zipCode: $zipCode, xCode: $xCode, yCode: $yCode}';
  }
}

class RoadAddress {
  String? addressName;
  String? region1DepthName;
  String? region2DepthName;
  String? region3DepthName;
  String? roadName;
  String? undergroundYn;
  String? mainBuildingNo;
  String? subBuildingNo;
  String? buildingName;
  String? zoneNo;
  String? xCode;
  String? yCode;

  RoadAddress({
    this.addressName,
    this.region1DepthName,
    this.region2DepthName,
    this.region3DepthName,
    this.roadName,
    this.undergroundYn,
    this.mainBuildingNo,
    this.subBuildingNo,
    this.buildingName,
    this.zoneNo,
    this.xCode,
    this.yCode,
  });

  factory RoadAddress.fromJson(Map<String, dynamic> parsedJson) {
    return RoadAddress(
      addressName: parsedJson['address_name'],
      region1DepthName: parsedJson['region_1depth_name'],
      region2DepthName: parsedJson['region_2depth_name'],
      region3DepthName: parsedJson['region_3depth_name'],
      roadName: parsedJson['road_name'],
      undergroundYn: parsedJson['underground_yn'],
      mainBuildingNo: parsedJson['main_building_no'],
      subBuildingNo: parsedJson['sub_building_no'],
      buildingName: parsedJson['building_name'],
      zoneNo: parsedJson['zone_no'],
      xCode: parsedJson['x'],
      yCode: parsedJson['y'],
    );
  }

  @override
  String toString() {
    return 'RoadAddress{addressName: $addressName, region1DepthName: $region1DepthName, region2DepthName: $region2DepthName, region3DepthName: $region3DepthName, roadName: $roadName, undergroundYn: $undergroundYn, mainBuildingNo: $mainBuildingNo, subBuildingNo: $subBuildingNo, buildingName: $buildingName, zoneNo: $zoneNo, xCode: $xCode, yCode: $yCode}';
  }
}

class Documents {
  String? addressName;
  String? addressType;
  String? longitude;
  String? latitude;
  Address? address;
  RoadAddress? roadAddress;

  Documents({
    this.addressName,
    this.addressType,
    this.longitude,
    this.latitude,
    this.address,
    this.roadAddress,
  });

  factory Documents.fromJson(Map<String, dynamic> parsedJson) {
    var addressJson = parsedJson['address'];
    Address? resultAddress = (addressJson != null) ? Address.fromJson(addressJson) : null;

    var roadAddressJson = parsedJson['road_address'];
    RoadAddress? resultRoadAddress = (roadAddressJson != null) ? RoadAddress.fromJson(roadAddressJson) : null;

    return Documents(
      addressName: parsedJson['address_name'],
      addressType: parsedJson['address_type'],
      longitude: parsedJson['x'],
      latitude: parsedJson['y'],
      address: resultAddress,
      roadAddress: resultRoadAddress,
    );
  }

  @override
  String toString() {
    return 'Documents{addressName: $addressName, addressType: $addressType, longitude: $longitude, latitude: $latitude, address: $address, roadAddress: $roadAddress}';
  }
}

class AddressResponse {
  Meta? meta;
  List<Documents>? documents;

  AddressResponse({
    this.meta,
    this.documents,
  });

  factory AddressResponse.fromJson(Map<String, dynamic> parsedJson) {
    var metaJson = parsedJson['meta'];
    Meta? resultMeta = (metaJson != null) ? Meta.fromJson(metaJson) : null;

    var docLists = parsedJson['documents'] as List;
    List<Documents> resultList = docLists.map((i) => Documents.fromJson(i)).toList();

    return AddressResponse(
      meta: resultMeta,
      documents: resultList,
    );
  }

  @override
  String toString() {
    return 'AddressResponse{meta: $meta, documents: $documents}';
  }
}

class Juso {
  String? zipNo;
  String? roadAddress;
  String? jibunAddress;

  Juso({this.zipNo, this.roadAddress, this.jibunAddress});

  factory Juso.fromJson(Map<String, dynamic> parsedJson) {
    return Juso(
      zipNo: parsedJson['zipNo'],
      roadAddress: parsedJson['roadAddr'],
      jibunAddress: parsedJson['jibunAddr'],
    );
  }
}

class JusoResult {
  String? errorMessage;
  String? countPerPage;
  String? totalCount;
  String? errorCode;
  String? currentPage;
  List<Juso>? resultList;

  JusoResult({
    this.errorMessage,
    this.countPerPage,
    this.totalCount,
    this.errorCode,
    this.currentPage,
    this.resultList,
  });

  factory JusoResult.fromJson(Map<String, dynamic> parsedJson) {
    var resultJson = parsedJson['results'];
    var commonJson = resultJson['common'];
    var jusoLists = resultJson['juso'] as List;
    List<Juso> resultList = jusoLists.map((i) => Juso.fromJson(i)).toList();

    return JusoResult(
      errorMessage: commonJson['errorMessage'],
      countPerPage: commonJson['countPerPage'],
      totalCount: commonJson['totalCount'],
      errorCode: commonJson['errorCode'],
      currentPage: commonJson['currentPage'],
      resultList: resultList,
    );
  }
}
