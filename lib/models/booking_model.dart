class Reservation {
  String? reservationId;
  String? reservationType;
  String? serviceDate;
  String? serviceTime;
  String? status;

  Reservation({
    this.reservationId,
    this.reservationType,
    this.serviceDate,
    this.serviceTime,
    this.status,
  });

  factory Reservation.fromJson(Map<String, dynamic> parsedJson) {
    return Reservation(
      reservationId: parsedJson['reservation_id'].toString(),
      reservationType: parsedJson['reservation_type'],
      serviceDate: (parsedJson['reservation_type'] != "LC") ? parsedJson['service_date'] : parsedJson['learn_day'],
      serviceTime: parsedJson['service_time'],
      status: parsedJson['status'],
    );
  }
}

class ReservationDetail {
  String? reservationId;
  String? reservationType;
  String? serviceDate;
  String? serviceTime;
  String? services;
  String? status;
  String? reservationNo;
  String? serviceAddress;
  String? memo;
  String? phone;
  String? serviceDetail;
  String? learnDay;
  String? price;
  String? createdAt;
  String? finishedDateTime;
  String? canceledDateTime;
  String? cancelComment;
  String? serviceComment;
  String? partnerName;
  String? partnerPhone;

  ReservationDetail({
    this.reservationId,
    this.reservationType,
    this.serviceDate,
    this.serviceTime,
    this.services,
    this.status,
    this.reservationNo,
    this.serviceAddress,
    this.memo,
    this.phone,
    this.serviceDetail,
    this.learnDay,
    this.price,
    this.createdAt,
    this.finishedDateTime,
    this.canceledDateTime,
    this.cancelComment,
    this.serviceComment,
    this.partnerName,
    this.partnerPhone,
  });

  factory ReservationDetail.fromJson(Map<String, dynamic> parsedJson) {
    return ReservationDetail(
      reservationId: parsedJson['reservation_id'].toString(),
      reservationType: parsedJson['reservation_type'],
      serviceDate: (parsedJson['reservation_type'] != "LC") ? parsedJson['service_date'] : parsedJson['learn_day'],
      serviceTime: parsedJson['service_time'],
      services: parsedJson['services'],
      status: parsedJson['status'],
      reservationNo: parsedJson['reservation_no'],
      serviceAddress: parsedJson['service_addr'],
      memo: parsedJson['memo'],
      phone: parsedJson['phone'],
      serviceDetail: parsedJson['service_detail'],
      learnDay: parsedJson['learn_day'],
      price: parsedJson['price'].toString(),
      createdAt: parsedJson['created_at'],
      finishedDateTime: parsedJson['finished_at'],
      canceledDateTime: parsedJson['canceled_at'],
      cancelComment: parsedJson['cancel_comment'],
      serviceComment: parsedJson['service_comment'],
      partnerName: parsedJson['partner_name'],
      partnerPhone: parsedJson['partner_phone'],
    );
  }
}

class ReservationList {
  String? status;
  int? count;
  List<Reservation>? result;

  ReservationList({this.status, this.count, this.result});

  factory ReservationList.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    List<Reservation> resultList = list.map((i) => Reservation.fromJson(i)).toList();

    return ReservationList(
      status: parsedJson['status'],
      count: parsedJson['cnt'],
      result: resultList,
    );
  }
}

class BookingItem {
  String? type;
  String? title;
  String? detail;
  int? price;

  BookingItem({this.type, this.title, this.detail, this.price});
}
