class IncomeItem {
  String? month;
  String? count;
  String? amount;
  String? paidAmount;

  IncomeItem({this.month, this.count, this.amount, this.paidAmount});

  factory IncomeItem.fromJson(Map<String, dynamic> parsedJson) {
    return IncomeItem(
      month: parsedJson['month'],
      count: parsedJson['count'].toString(),
      amount: parsedJson['amount'],
      paidAmount: parsedJson['paid_amount'],
    );
  }
}

class IncomeItemList {
  String? status;
  int? count;
  List<IncomeItem>? result;

  IncomeItemList({this.status, this.count, this.result});

  factory IncomeItemList.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    List<IncomeItem> resultList = list.map((i) => IncomeItem.fromJson(i)).toList();

    return IncomeItemList(
      status: parsedJson['status'],
      count: parsedJson['cnt'],
      result: resultList,
    );
  }
}

class IncomeDetailItem {
  String? date;
  String? reservationNo;
  String? reservationType;
  String? reservationTypeStr;
  int? amount;
  int? price;
  String? state;

  IncomeDetailItem({
    this.date,
    this.reservationNo,
    this.reservationType,
    this.reservationTypeStr,
    this.amount,
    this.price,
    this.state,
  });

  factory IncomeDetailItem.fromJson(Map<String, dynamic> parsedJson) {
    String reservationTypeStr = "";
    if (parsedJson['reservation_type'] == "CS") {
      reservationTypeStr = "음식점 위생정리";
    } else if (parsedJson['reservation_type'] == "CR") {
      reservationTypeStr = "공간정리";
    } else {
      reservationTypeStr = "정리교육";
    }

    return IncomeDetailItem(
      date: parsedJson['date'],
      reservationNo: parsedJson['reservation_no'],
      reservationType: parsedJson['reservation_type'],
      reservationTypeStr: reservationTypeStr,
      amount: parsedJson['amount'],
      price: parsedJson['price'],
      state: parsedJson['state'],
    );
  }
}

class IncomeDetail {
  String? totalAmount;
  String? paidAmount;
  String? count;
  String? status;
  List<IncomeDetailItem>? data;

  IncomeDetail({this.totalAmount, this.paidAmount, this.count, this.status, this.data});

  factory IncomeDetail.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    List<IncomeDetailItem> resultList = list.map((i) => IncomeDetailItem.fromJson(i)).toList();

    return IncomeDetail(
      totalAmount: parsedJson['total_amount'],
      paidAmount: parsedJson['paid_amount'],
      count: parsedJson['count'].toString(),
      status: parsedJson['status'],
      data: resultList,
    );
  }
}
