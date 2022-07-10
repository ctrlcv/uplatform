import 'package:uplatform/utils/utils.dart';

class Request {
  String? reservationId;
  String? reservationType;
  String? reservationTypeTitle;
  String? serviceDate;
  String? serviceTime;
  String? serviceDateTime;
  String? learnDay;
  String? applyCount;
  String? applied;
  String? serviceAddress;

  Request({
    this.reservationId,
    this.reservationType,
    this.reservationTypeTitle,
    this.serviceDate,
    this.serviceTime,
    this.serviceDateTime,
    this.learnDay,
    this.applyCount,
    this.applied,
    this.serviceAddress,
  });

  factory Request.fromJson(Map<String, dynamic> parsedJson) {
    String reservationTypeStr = "";

    if (parsedJson['reservation_type'] == "CS") {
      reservationTypeStr = "음식점 위생정리";
    } else if (parsedJson['reservation_type'] == "CR") {
      reservationTypeStr = "공간정리";
    } else if (parsedJson['reservation_type'] == "LC") {
      reservationTypeStr = "정리교육";
    }

    String serviceDateTimeStr =
        Utils().getDisplayDateTime(parsedJson['service_date'].toString(), parsedJson['service_time'].toString());
    return Request(
      reservationId: parsedJson['reservation_id'].toString(),
      reservationType: parsedJson['reservation_type'],
      reservationTypeTitle: reservationTypeStr,
      serviceDate: parsedJson['service_date'],
      serviceTime: parsedJson['service_time'],
      serviceDateTime: serviceDateTimeStr,
      learnDay: parsedJson['learn_day'],
      applyCount: parsedJson['apply_cnt'].toString(),
      applied: parsedJson['applied'],
      serviceAddress: parsedJson['service_addr'],
    );
  }
}

class RequestList {
  String? status;
  int? count;
  List<Request>? result;

  RequestList({this.status, this.count, this.result});

  factory RequestList.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    List<Request> resultList = list.map((i) => Request.fromJson(i)).toList();

    return RequestList(
      status: parsedJson['status'],
      count: parsedJson['cnt'],
      result: resultList,
    );
  }
}

class RequestDetail {
  String? reservationId;
  String? reservationType;
  String? reservationTypeStr;
  String? serviceDate;
  String? serviceTime;
  String? serviceDateTime;
  String? services;
  String? status;
  String? statusStr;
  String? reservationNo;
  String? serviceAddress;
  String? memo;
  String? phone;
  String? serviceDetail;
  String? learnDay;
  int? price;
  String? createdDateTime;
  String? finishedDateTime;
  String? applyCount;
  String? applied;
  String? appliedDateTime;
  String? applyId;

  RequestDetail({
    this.reservationId,
    this.reservationType,
    this.reservationTypeStr,
    this.serviceDate,
    this.serviceTime,
    this.serviceDateTime,
    this.services,
    this.status,
    this.statusStr,
    this.reservationNo,
    this.serviceAddress,
    this.memo,
    this.phone,
    this.serviceDetail,
    this.learnDay,
    this.price,
    this.createdDateTime,
    this.finishedDateTime,
    this.applyCount,
    this.applied,
    this.appliedDateTime,
    this.applyId,
  });

  factory RequestDetail.fromJson(Map<String, dynamic> parsedJson) {
    String reservationTypeStr = "";
    if (parsedJson['reservation_type'] == "CS") {
      reservationTypeStr = "음식점 위생정리";
    } else if (parsedJson['reservation_type'] == "CR") {
      reservationTypeStr = "공간정리";
    } else if (parsedJson['reservation_type'] == "LC") {
      reservationTypeStr = "정리교육";
    }

    String statusStr = "";
    if (parsedJson['status'] == "W") {
      statusStr = "대기";
    } else if (parsedJson['status'] == "R") {
      statusStr = "예약완료";
    } else if (parsedJson['status'] == "S") {
      statusStr = "서비스완료";
    } else if (parsedJson['status'] == "C") {
      statusStr = "취소";
    }

    String serviceDateTimeStr = Utils().getDisplayDateTime(
      parsedJson['service_date'].toString(),
      parsedJson['service_time'].toString(),
    );

    return RequestDetail(
      reservationId: parsedJson['reservation_id'].toString(),
      reservationType: parsedJson['reservation_type'],
      reservationTypeStr: reservationTypeStr,
      serviceDate: parsedJson['service_date'],
      serviceTime: parsedJson['service_time'],
      serviceDateTime: serviceDateTimeStr,
      services: parsedJson['services'],
      status: parsedJson['status'],
      statusStr: statusStr,
      reservationNo: parsedJson['reservation_no'],
      serviceAddress: parsedJson['service_addr'],
      memo: parsedJson['memo'],
      phone: parsedJson['phone'],
      serviceDetail: parsedJson['service_detail'],
      learnDay: parsedJson['learn_day'],
      price: parsedJson['price'],
      createdDateTime: parsedJson['created_at'],
      finishedDateTime: parsedJson['finished_at'],
      applyCount:
          (parsedJson['apply_cnt'] == 0 || parsedJson['apply_cnt'] == null) ? "0" : parsedJson['apply_cnt'].toString(),
      applied: parsedJson['applied'],
      appliedDateTime: parsedJson['applied_at'],
      applyId: parsedJson['apply_id'].toString(),
    );
  }
}

class ApplyItem {
  String? applyId;
  String? reservationType;
  String? reservationTypeStr;
  String? serviceDate;
  String? serviceTime;
  String? serviceDateTime;
  String? learnDay;
  String? status;
  String? statusStr;

  ApplyItem({
    this.applyId,
    this.reservationType,
    this.reservationTypeStr,
    this.serviceDate,
    this.serviceTime,
    this.serviceDateTime,
    this.learnDay,
    this.status,
    this.statusStr,
  });

  factory ApplyItem.fromJson(Map<String, dynamic> parsedJson) {
    String reservationTypeStr = "";
    if (parsedJson['reservation_type'] == "CS") {
      reservationTypeStr = "음식점 위생정리";
    } else if (parsedJson['reservation_type'] == "CR") {
      reservationTypeStr = "공간정리";
    } else if (parsedJson['reservation_type'] == "LC") {
      reservationTypeStr = "정리교육";
    }

    String statusStr = "";
    if (parsedJson['status'] == "A") {
      statusStr = "지원완료 대기중";
    } else if (parsedJson['status'] == "S") {
      statusStr = "확정";
    } else if (parsedJson['status'] == "E") {
      statusStr = "서비스 완료";
    } else if (parsedJson['status'] == "C") {
      statusStr = "지원취소";
    }

    String serviceDateTimeStr =
        Utils().getDisplayDateTime(parsedJson['service_date'].toString(), parsedJson['service_time'].toString());

    return ApplyItem(
      applyId: parsedJson['apply_id'].toString(),
      reservationType: parsedJson['reservation_type'],
      reservationTypeStr: reservationTypeStr,
      serviceDate: parsedJson['service_date'],
      serviceTime: parsedJson['service_time'],
      serviceDateTime: serviceDateTimeStr,
      learnDay: parsedJson['learn_day'],
      status: parsedJson['status'],
      statusStr: statusStr,
    );


  }

  @override
  String toString() {
    return 'ApplyItem{applyId: $applyId, reservationType: $reservationType, reservationTypeStr: $reservationTypeStr, serviceDate: $serviceDate, serviceTime: $serviceTime, serviceDateTime: $serviceDateTime, learnDay: $learnDay, status: $status, statusStr: $statusStr}';
  }
}

class ApplyItemList {
  String? status;
  int? count;
  List<ApplyItem>? result;

  ApplyItemList({this.status, this.count, this.result});

  factory ApplyItemList.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    List<ApplyItem> resultList = list.map((i) => ApplyItem.fromJson(i)).toList();

    return ApplyItemList(
      status: parsedJson['status'],
      count: parsedJson['cnt'],
      result: resultList,
    );
  }
}

class ApplyDetail {
  String? applyId;
  String? reservationType;
  String? reservationTypeStr;
  String? serviceDate;
  String? serviceTime;
  String? serviceDateTime;
  String? services;
  String? learnDay;
  String? status;
  String? statusStr;
  String? reservationNo;
  String? serviceAddress;
  String? memo;
  String? phoneNumber;
  String? serviceDetail;
  int? price;
  String? createDateTime;
  String? finishedDateTime;
  String? canceledDateTime;
  String? matchedDateTime;
  String? cancelComment;
  String? serviceComment;

  ApplyDetail(
      {this.applyId,
      this.reservationType,
      this.reservationTypeStr,
      this.serviceDate,
      this.serviceTime,
      this.serviceDateTime,
      this.services,
      this.learnDay,
      this.status,
      this.statusStr,
      this.reservationNo,
      this.serviceAddress,
      this.memo,
      this.phoneNumber,
      this.serviceDetail,
      this.price,
      this.createDateTime,
      this.finishedDateTime,
      this.canceledDateTime,
      this.matchedDateTime,
      this.cancelComment,
      this.serviceComment});

  factory ApplyDetail.fromJson(Map<String, dynamic> parsedJson) {
    String reservationTypeStr = "";
    if (parsedJson['reservation_type'] == "CS") {
      reservationTypeStr = "음식점 위생정리";
    } else if (parsedJson['reservation_type'] == "CR") {
      reservationTypeStr = "공간정리";
    } else if (parsedJson['reservation_type'] == "LC") {
      reservationTypeStr = "정리교육";
    }

    String statusStr = "";
    if (parsedJson['status'] == "A") {
      statusStr = "지원완료 대기중";
    } else if (parsedJson['status'] == "S") {
      statusStr = "확정";
    } else if (parsedJson['status'] == "E") {
      statusStr = "서비스 완료";
    } else if (parsedJson['status'] == "C") {
      statusStr = "지원취소";
    }

    String serviceDateTimeStr =
        Utils().getDisplayDateTime(parsedJson['service_date'].toString(), parsedJson['service_time'].toString());

    return ApplyDetail(
      applyId: parsedJson['apply_id'].toString(),
      reservationType: parsedJson['reservation_type'],
      reservationTypeStr: reservationTypeStr,
      serviceDate: parsedJson['service_date'],
      serviceTime: parsedJson['service_time'],
      serviceDateTime: serviceDateTimeStr,
      learnDay: parsedJson['learn_day'],
      status: parsedJson['status'],
      statusStr: statusStr,
      reservationNo: parsedJson['reservation_no'],
      serviceAddress: parsedJson['service_addr'],
      memo: parsedJson['memo'],
      phoneNumber: parsedJson['phone'],
      serviceDetail: parsedJson['service_detail'],
      price: parsedJson['price'],
      createDateTime: parsedJson['created_at'],
      finishedDateTime: parsedJson['finished_at'],
      services: parsedJson['services'],
      canceledDateTime: parsedJson['canceled_at'],
      matchedDateTime: parsedJson['matched_at'],
      cancelComment: parsedJson['cancel_comment'],
      serviceComment: parsedJson['service_comment'],
    );
  }
}

class ServiceItem {
  String? id;
  String? serviceType;
  String? serviceSubType;
  String? servicePart;
  String? serviceName;
  int? price;
  String? memo;

  ServiceItem({
    this.id,
    this.serviceType,
    this.serviceSubType,
    this.servicePart,
    this.serviceName,
    this.price,
    this.memo,
  });

  factory ServiceItem.fromJson(Map<String, dynamic> parsedJson) {
    return ServiceItem(
      id: parsedJson['id'].toString(),
      serviceType: parsedJson['service_type'],
      serviceSubType: parsedJson['service_sub_type'],
      servicePart: parsedJson['service_part'],
      serviceName: parsedJson['service_name'],
      price: parsedJson['price'],
      memo: parsedJson['memo'],
    );
  }

  @override
  String toString() {
    return 'ServiceItem{id: $id, serviceType: $serviceType, serviceSubType: $serviceSubType, servicePart: $servicePart, serviceName: $serviceName, price: $price, memo: $memo}';
  }
}

class ServiceItemList {
  String? status;
  int? count;
  List<ServiceItem>? result;

  ServiceItemList({this.status, this.count, this.result});

  factory ServiceItemList.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    List<ServiceItem> resultList = list.map((i) => ServiceItem.fromJson(i)).toList();

    return ServiceItemList(
      status: parsedJson['status'].toString(),
      count: parsedJson['cnt'],
      result: resultList,
    );
  }
}
