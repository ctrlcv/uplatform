import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/components/container_progress.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/text_paragraph.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/dialogs/ask_dialog.dart';
import 'package:uplatform/models/notice_model.dart';
import 'package:uplatform/page/common/qna_input_page.dart';
import 'package:uplatform/services/network.dart';

class QnaDetailPage extends StatefulWidget {
  const QnaDetailPage({Key? key}) : super(key: key);

  static const routeName = '/QnaDetailPage';

  @override
  _NoticeDetailPageState createState() => _NoticeDetailPageState();
}

class _NoticeDetailPageState extends State<QnaDetailPage> {
  String _qnaId = "0";
  QnaItemDetail? _qnaItemDetail;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _qnaId = Get.arguments;
    loadQnaDetail();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future loadQnaDetail() async {
    _isLoading = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};
    params['qna_id'] = _qnaId;

    _qnaItemDetail = await Network().reqQnaDetail(params);

    if (_qnaItemDetail == null) {
      _isLoading = false;
      Get.back();
      return;
    }

    _isLoading = false;
    if (mounted) {
      setState(() {});
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
        body: _isLoading
            ? const ContainerProgress()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    TextParagraph(
                      paraText: "[${_qnaItemDetail!.type}] ${_qnaItemDetail!.title}",
                      fontSize: 18,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 6),
                    TextTitle(
                      titleText: "${_qnaItemDetail!.askDateTime}",
                      fontSize: 13,
                      fontColor: const Color(0xFF898D93),
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 16),
                    kHorizontalLine,
                    const SizedBox(height: 24),
                    TextParagraph(
                      paraText: _qnaItemDetail!.content ?? "",
                      fontSize: 15,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            dynamic result = await Get.toNamed(QnaInputPage.routeName, arguments: _qnaId);
                            if (result != null && result == "UPDATE") {
                              loadQnaDetail();
                            }
                          },
                          child: const Text(
                            "수정",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF898D93),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 1,
                          height: 11,
                          color: const Color(0xFF898D93),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () async {
                            String resultStr = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AskDialog(title: "삭제", contents: "삭제 하시겠습니까?");
                              },
                              barrierDismissible: false,
                            );

                            if (resultStr != "YES") {
                              return;
                            }

                            Map<String, dynamic> params = {};
                            params['qna_id'] = _qnaId;

                            var result = await Network().reqDelQnaItem(params);
                            debugPrint("result $result");
                            Get.back(result: "DELETE");
                          },
                          child: const Text(
                            "삭제",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF898D93),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 12,
                      color: const Color(0xFFF1F2F4),
                    ),
                    const SizedBox(height: 28),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color:
                                  (_qnaItemDetail!.status == "W") ? const Color(0xFFF4FAFF) : const Color(0xFFF5F6F8),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            height: 28,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            alignment: Alignment.center,
                            child: Text(
                              (_qnaItemDetail!.status == "W") ? "확인중" : "답변완료",
                              style: TextStyle(
                                fontSize: 13,
                                height: 1.0,
                                color:
                                    (_qnaItemDetail!.status == "W") ? const Color(0xFF10A2DC) : const Color(0xFF686C73),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextTitle(
                      titleText: (_qnaItemDetail!.status == "W") ? "답변을 준비 중에 있습니다." : "${_qnaItemDetail!.answerTitle}",
                      fontSize: 18,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: (_qnaItemDetail!.status == "W") ? 8 : 4),
                    if (_qnaItemDetail!.status == "W")
                      const TextParagraph(
                        paraText: "문의 주신 내용을 정확하게 확인하여 빠르게 답변 드릴 수 있도록 하겠습니다.",
                        fontSize: 15,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    if (_qnaItemDetail!.status == "S")
                      TextTitle(
                        titleText: "${_qnaItemDetail!.answerDateTime}",
                        fontSize: 13,
                        fontColor: const Color(0xFF898D93),
                        fontWeight: FontWeight.w400,
                      ),
                    if (_qnaItemDetail!.status == "S") const SizedBox(height: 24),
                    if (_qnaItemDetail!.status == "S") kHorizontalLine,
                    if (_qnaItemDetail!.status == "S") const SizedBox(height: 24),
                    if (_qnaItemDetail!.status == "S")
                      TextParagraph(
                        paraText: "${_qnaItemDetail!.answer}",
                        fontSize: 15,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    const SizedBox(height: 32),
                    buildBottomBar,
                  ],
                ),
              ),
      ),
    );
  }
}
