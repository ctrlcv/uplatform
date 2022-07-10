import 'package:uplatform/utils/utils.dart';

class Notice {
  String? noticeId;
  String? title;
  String? noticeDateTime;

  Notice({this.noticeId, this.title, this.noticeDateTime});

  factory Notice.fromJson(Map<String, dynamic> parsedJson) {
    String noticeDateTime = Utils().getDisplayDateTime2(parsedJson['created_at'] ?? "");

    return Notice(
      noticeId: parsedJson['notice_id'].toString(),
      title: parsedJson['title'],
      noticeDateTime: noticeDateTime,
    );
  }
}

class NoticeList {
  String? status;
  int? count;
  List<Notice>? result;

  NoticeList({this.status, this.count, this.result});

  factory NoticeList.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    List<Notice> resultList = list.map((i) => Notice.fromJson(i)).toList();

    return NoticeList(
      status: parsedJson['status'],
      count: parsedJson['cnt'],
      result: resultList,
    );
  }
}

class NoticeDetail {
  String? noticeId;
  String? title;
  String? content;
  String? noticeDateTime;
  String? prevNoticeId;
  String? prevNoticeTitle;
  String? nextNoticeId;
  String? nextNoticeTitle;

  NoticeDetail({
    this.noticeId,
    this.title,
    this.content,
    this.noticeDateTime,
    this.prevNoticeId,
    this.prevNoticeTitle,
    this.nextNoticeId,
    this.nextNoticeTitle,
  });

  factory NoticeDetail.fromJson(Map<String, dynamic> parsedJson) {
    var data = (parsedJson['data'][0]);
    var preData = parsedJson['pre_data'];
    var nextData = parsedJson['next_data'];

    String noticeDateTime = Utils().getDisplayDateTime2(data['created_at'] ?? "");

    return NoticeDetail(
      noticeId: data['notice_id'].toString(),
      title: data['title'],
      content: data['content'],
      noticeDateTime: noticeDateTime,
      prevNoticeId: (preData != null) ? preData['notice_id'].toString() : null,
      prevNoticeTitle: (preData != null) ? preData['title'] : null,
      nextNoticeId: (nextData != null) ? nextData['notice_id'].toString() : null,
      nextNoticeTitle: (nextData != null) ? nextData['title'] : null,
    );
  }
}

class FAQItem {
  String? faqId;
  String? type;
  String? title;
  String? faqDateTime;

  FAQItem({this.faqId, this.type, this.title, this.faqDateTime});

  factory FAQItem.fromJson(Map<String, dynamic> parsedJson) {
    String faqDateTime = Utils().getDisplayDateTime2(parsedJson['created_at'] ?? "");

    return FAQItem(
      faqId: parsedJson['faq_id'].toString(),
      type: parsedJson['type'],
      title: parsedJson['title'],
      faqDateTime: faqDateTime,
    );
  }
}

class FAQItemList {
  String? status;
  int? count;
  List<FAQItem>? result;

  FAQItemList({this.status, this.count, this.result});

  factory FAQItemList.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    List<FAQItem> resultList = list.map((i) => FAQItem.fromJson(i)).toList();

    return FAQItemList(
      status: parsedJson['status'],
      count: parsedJson['cnt'],
      result: resultList,
    );
  }
}

class FaqDetail {
  String? faqId;
  String? type;
  String? title;
  String? content;
  String? faqDateTime;
  String? prevFaqId;
  String? prevFaqTitle;
  String? nextFaqId;
  String? nextFaqTitle;

  FaqDetail({
    this.faqId,
    this.type,
    this.title,
    this.content,
    this.faqDateTime,
    this.prevFaqId,
    this.prevFaqTitle,
    this.nextFaqId,
    this.nextFaqTitle,
  });

  factory FaqDetail.fromJson(Map<String, dynamic> parsedJson) {
    var data = (parsedJson['data'][0]);
    var preData = parsedJson['pre_data'];
    var nextData = parsedJson['next_data'];

    String faqDateTime = Utils().getDisplayDateTime2(data['created_at'] ?? "");

    return FaqDetail(
      faqId: data['faq_id'].toString(),
      type: data['type'],
      title: data['title'],
      content: data['content'],
      faqDateTime: faqDateTime,
      prevFaqId: (preData != null) ? preData['faq_id'].toString() : null,
      prevFaqTitle: (preData != null) ? preData['title'] : null,
      nextFaqId: (nextData != null) ? nextData['faq_id'].toString() : null,
      nextFaqTitle: (nextData != null) ? nextData['title'] : null,
    );
  }
}

class QnaItem {
  String? qnaId;
  String? title;
  String? content;
  String? type;
  String? status;
  String? askDateTime;
  String? answerDateTime;

  QnaItem({
    this.qnaId,
    this.title,
    this.content,
    this.type,
    this.status,
    this.askDateTime,
    this.answerDateTime,
  });

  factory QnaItem.fromJson(Map<String, dynamic> parsedJson) {
    String askDateTime =
        (parsedJson['created_at'] != null) ? Utils().getDisplayDateTime2(parsedJson['created_at'] ?? "") : "";
    String answerDateTime =
        (parsedJson['answered_at'] != null) ? Utils().getDisplayDateTime2(parsedJson['answered_at'] ?? "") : "";

    return QnaItem(
      qnaId: parsedJson['qna_id'].toString(),
      title: parsedJson['title'],
      content: parsedJson['content'],
      type: parsedJson['type'],
      status: parsedJson['status'],
      askDateTime: askDateTime,
      answerDateTime: answerDateTime,
    );
  }
}

class QnaItemList {
  String? status;
  int? count;
  List<QnaItem>? result;

  QnaItemList({this.status, this.count, this.result});

  factory QnaItemList.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    List<QnaItem> resultList = list.map((i) => QnaItem.fromJson(i)).toList();

    return QnaItemList(
      status: parsedJson['status'],
      count: parsedJson['cnt'],
      result: resultList,
    );
  }
}

class QnaItemDetail {
  String? qnaId;
  String? title;
  String? content;
  String? type;
  String? status;
  String? answerTitle;
  String? answer;
  String? askDateTime;
  String? answerDateTime;
  String? fileSource;

  QnaItemDetail({
    this.qnaId,
    this.title,
    this.content,
    this.type,
    this.status,
    this.answerTitle,
    this.answer,
    this.askDateTime,
    this.answerDateTime,
    this.fileSource,
  });

  factory QnaItemDetail.fromJson(Map<String, dynamic> parsedJson) {
    String askDateTime =
        (parsedJson['created_at'] != null) ? Utils().getDisplayDateTime2(parsedJson['created_at'] ?? "") : "";
    String answerDateTime =
        (parsedJson['answered_at'] != null) ? Utils().getDisplayDateTime2(parsedJson['answered_at'] ?? "") : "";

    return QnaItemDetail(
      qnaId: parsedJson['qna_id'].toString(),
      title: parsedJson['title'],
      content: parsedJson['content'],
      type: parsedJson['type'],
      status: parsedJson['status'],
      answerTitle: parsedJson['answer_title'],
      answer: parsedJson['answer'],
      askDateTime: askDateTime,
      answerDateTime: answerDateTime,
      fileSource: parsedJson['file_src'],
    );
  }

  @override
  String toString() {
    return 'QnaItemDetail{qnaId: $qnaId, title: $title, content: $content, type: $type, status: $status, answerTitle: $answerTitle, answer: $answer, askDateTime: $askDateTime, answerDateTime: $answerDateTime, fileSource: $fileSource}';
  }
}
