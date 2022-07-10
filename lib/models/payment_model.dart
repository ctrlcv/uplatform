class PaymentItem {
  String? paymentId;
  String? paidDateTime;
  String? reservationType;
  String? reservationTypeStr;
  String? services;
  int? price;
  String? payMethod;
  String? cardName;
  String? cardNumber;

  PaymentItem({
    this.paymentId,
    this.paidDateTime,
    this.reservationType,
    this.reservationTypeStr,
    this.services,
    this.price,
    this.payMethod,
    this.cardName,
    this.cardNumber,
  });

  factory PaymentItem.fromJson(Map<String, dynamic> parsedJson) {
    String reservationTypeStr = "";
    if (parsedJson['reservation_type'] == "CS") {
      reservationTypeStr = "음식점 위생정리";
    } else if (parsedJson['reservation_type'] == "CR") {
      reservationTypeStr = "공간정리";
    } else if (parsedJson['reservation_type'] == "LC") {
      reservationTypeStr = "정리교육";
    }

    return PaymentItem(
      paymentId: parsedJson['payment_id'].toString(),
      paidDateTime: parsedJson['paid_at'],
      reservationType: parsedJson['reservation_type'],
      reservationTypeStr: reservationTypeStr,
      services: parsedJson['services'],
      price: parsedJson['price'],
      payMethod: parsedJson['pay_method'],
      cardName: parsedJson['card_name'],
      cardNumber: parsedJson['card_number'],
    );
  }
}

class PaymentItemList {
  String? status;
  int? count;
  List<PaymentItem>? result;

  PaymentItemList({this.status, this.count, this.result});

  factory PaymentItemList.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    List<PaymentItem> resultList = list.map((i) => PaymentItem.fromJson(i)).toList();

    return PaymentItemList(
      status: parsedJson['status'],
      count: parsedJson['cnt'],
      result: resultList,
    );
  }
}
