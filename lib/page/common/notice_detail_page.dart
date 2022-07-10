import 'package:flutter/material.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/container_progress.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/text_paragraph.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/notice_model.dart';
import 'package:get/get.dart';
import 'package:uplatform/services/network.dart';
import 'package:flutter_html/flutter_html.dart';

class NoticeDetailPage extends StatefulWidget {
  const NoticeDetailPage({Key? key}) : super(key: key);

  static const routeName = '/NoticeDetailPage';

  @override
  _NoticeDetailPageState createState() => _NoticeDetailPageState();
}

class _NoticeDetailPageState extends State<NoticeDetailPage> {
  String _noticeId = "0";
  NoticeDetail? _noticeDetail;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _noticeId = Get.arguments;
    loadNoticeDetail();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future loadNoticeDetail() async {
    _isLoading = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};

    params['notice_id'] = _noticeId;

    _noticeDetail = await Network().reqNoticeDetail(params);

    if (_noticeDetail == null) {
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
            : Column(
                children: [
                  const SizedBox(height: 12),
                  TextParagraph(
                    paraText: "${_noticeDetail!.title}",
                    fontSize: 18,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 8),
                  TextTitle(
                    titleText: "${_noticeDetail!.noticeDateTime}",
                    fontSize: 13,
                    fontColor: const Color(0xFF898D93),
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(height: 24),
                  kHorizontalLine,
                  const SizedBox(height: 24),
                  Expanded(
                    child: SingleChildScrollView(
                      // child: Column(
                      //   children: [
                      //     TextParagraph(
                      //       paraText: "${_noticeDetail!.content}",
                      //       fontSize: 15,
                      //       fontColor: Colors.black,
                      //       fontWeight: FontWeight.w400,
                      //     ),
                      //   ],
                      // ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Html(
                          data: _noticeDetail!.content ?? "",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_noticeDetail!.prevNoticeId != null) kHorizontalLine,
                  if (_noticeDetail!.prevNoticeId != null) const SizedBox(height: 20),
                  if (_noticeDetail!.prevNoticeId != null)
                    GestureDetector(
                      onTap: () {
                        _noticeId = _noticeDetail!.prevNoticeId ?? _noticeId;
                        loadNoticeDetail();
                      },
                      child: Container(
                        height: 18,
                        color: Colors.transparent,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.arrow_drop_up, color: Color(0xFF898D93), size: 24),
                            const SizedBox(width: 8),
                            const Text(
                              "이전글",
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.0,
                                color: Color(0xFF898D93),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: Text(
                                "${_noticeDetail!.prevNoticeTitle}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 1.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (_noticeDetail!.nextNoticeId != null) const SizedBox(height: 20),
                  if (_noticeDetail!.nextNoticeId != null) kHorizontalLine,
                  if (_noticeDetail!.nextNoticeId != null) const SizedBox(height: 20),
                  if (_noticeDetail!.nextNoticeId != null)
                    GestureDetector(
                      onTap: () {
                        _noticeId = _noticeDetail!.nextNoticeId ?? _noticeId;
                        loadNoticeDetail();
                      },
                      child: Container(
                        height: 18,
                        color: Colors.transparent,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.arrow_drop_down, color: Color(0xFF898D93), size: 24),
                            const SizedBox(width: 8),
                            const Text(
                              "다음글",
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.0,
                                color: Color(0xFF898D93),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: Text(
                                "${_noticeDetail!.nextNoticeTitle}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 1.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  kHorizontalLine,
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BorderRoundedButton(
                      text: "목록",
                      textColor: const Color(0xFF686C73),
                      buttonColor: Colors.white,
                      borderColor: const Color(0xFFE4E7ED),
                      fontSize: 15,
                      buttonHeight: 48,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  buildBottomBar,
                ],
              ),
      ),
    );
  }
}
