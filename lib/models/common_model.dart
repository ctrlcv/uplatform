class CommonResponse {
  String? status;
  String? message;

  CommonResponse({this.status, this.message});

  factory CommonResponse.fromJson(Map<String, dynamic> parsedJson) {
    return CommonResponse(
      status: parsedJson['status'],
      message: parsedJson['msg'],
    );
  }

  @override
  String toString() {
    return 'CommonResponse{status: $status, message: $message}';
  }
}

class ReservationResponse {
  String? status;
  String? message;
  String? insertId;

  ReservationResponse({this.status, this.message, this.insertId});

  factory ReservationResponse.fromJson(Map<String, dynamic> parsedJson) {
    return ReservationResponse(
      status: parsedJson['status'],
      message: parsedJson['msg'],
      insertId: parsedJson['insert_id'].toString(),
    );
  }

  @override
  String toString() {
    return 'ReservationResponse{status: $status, message: $message, insertId: $insertId}';
  }
}

class AlarmItem {
  String? alarmId;
  String? userId;
  String? content;
  String? sendDate;
  String? type;
  String? targetUser;
  String? targetId;
  String? state;
  String? createdAt;
  String? updatedAt;

  AlarmItem({
    this.alarmId,
    this.userId,
    this.content,
    this.sendDate,
    this.type,
    this.targetUser,
    this.targetId,
    this.state,
    this.createdAt,
    this.updatedAt,
  });

  factory AlarmItem.fromJson(Map<String, dynamic> parsedJson) {
    return AlarmItem(
      alarmId: parsedJson['id'].toString(),
      userId: parsedJson['user_id'].toString(),
      content: parsedJson['content'],
      sendDate: parsedJson['send_date'],
      type: parsedJson['type'],
      targetUser: parsedJson['target_user'],
      targetId: parsedJson['target_id'].toString(),
      state: parsedJson['status'],
      createdAt: parsedJson['created_at'],
      updatedAt: parsedJson['update_at'],
    );
  }
}

class AlarmItemList {
  String? status;
  int? count;
  List<AlarmItem>? result;

  AlarmItemList({this.status, this.count, this.result});

  factory AlarmItemList.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    List<AlarmItem> resultList = list.map((i) => AlarmItem.fromJson(i)).toList();

    return AlarmItemList(
      status: parsedJson['status'],
      count: parsedJson['cnt'],
      result: resultList,
    );
  }
}

class FindIdResponse {
  String? status;
  String? message;
  String? email;
  String? snsKey;

  FindIdResponse({this.status, this.message, this.email, this.snsKey});

  factory FindIdResponse.fromJson(Map<String, dynamic> parsedJson) {
    return FindIdResponse(
      status: parsedJson['status'],
      message: parsedJson['msg'],
      email: parsedJson['email'],
      snsKey: parsedJson['sns_key'],
    );
  }
}
