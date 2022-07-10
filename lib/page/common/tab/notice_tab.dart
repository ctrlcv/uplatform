import 'package:flutter/material.dart';
import 'package:uplatform/components/container_progress.dart';
import 'package:uplatform/components/no_item_panel.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/notice_model.dart';
import 'package:uplatform/services/network.dart';
import 'package:get/get.dart';

import '../notice_detail_page.dart';

class NoticeTab extends StatefulWidget {
  const NoticeTab({Key? key}) : super(key: key);

  @override
  _NoticeTabState createState() => _NoticeTabState();
}

class _NoticeTabState extends State<NoticeTab> {
  final ScrollController _scrollController = ScrollController();

  bool _isLoading = false;
  bool _isNoItem = false;
  bool _isMoreLoading = false;
  String _lastItemId = "";
  int _requestCount = 0;

  List<Notice> _noticeList = [];

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        debugPrint('Slide to the bottom ${_scrollController.position.pixels}');
        loadNoticeListMore();
      }
    });

    loadNoticeList();
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  Future loadNoticeList() async {
    _isLoading = true;

    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};

    params['start_no'] = "0";
    params['row'] = kListLoadCount.toString();

    NoticeList noticeList = await Network().reqNoticeList(params);

    if (noticeList.status != "200" || noticeList.count == 0) {
      _isLoading = false;
      _isNoItem = true;
      _noticeList = [];

      if (mounted) {
        setState(() {});
      }
      return;
    }

    _isNoItem = false;
    _noticeList = noticeList.result!;
    _requestCount = noticeList.count ?? 0;

    if (_noticeList.isNotEmpty) {
      Notice lastNotice = _noticeList[_noticeList.length - 1];
      _lastItemId = lastNotice.noticeId ?? "0";
    }

    _isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future loadNoticeListMore() async {
    if (_noticeList.isNotEmpty && _noticeList.length >= _requestCount) {
      return;
    }

    _isMoreLoading = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};
    params['start_no'] = _lastItemId;
    params['row'] = kListLoadCount.toString();

    NoticeList noticeList = await Network().reqNoticeList(params);

    if (noticeList.status != "200" || noticeList.count == 0) {
      _isMoreLoading = false;
      if (mounted) {
        setState(() {});
      }
      return;
    }

    List<Notice>? noticeItemList = noticeList.result;
    if (noticeItemList != null) {
      _noticeList.addAll(noticeItemList);
    }

    if (_noticeList.isNotEmpty) {
      Notice lastNotice = _noticeList[_noticeList.length - 1];
      _lastItemId = lastNotice.noticeId ?? "0";
    }

    _isMoreLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _isLoading
          ? const ContainerProgress()
          : _isNoItem
              ? buildNoNoticeItems()
              : Stack(
                  children: [
                    RefreshIndicator(
                      child: ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: _noticeList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return buildNoticeItem(
                            _noticeList[index],
                            (index == _noticeList.length - 1),
                          );
                        },
                      ),
                      onRefresh: loadNoticeList,
                    ),
                    Offstage(
                      offstage: !_isMoreLoading,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget buildNoticeItem(Notice notice, bool isLastItem) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(NoticeDetailPage.routeName, arguments: notice.noticeId);
      },
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text(
              notice.title ?? "",
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              notice.noticeDateTime ?? "",
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF898D93),
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 24),
            if (!isLastItem) kHorizontalLineNoMargin,
          ],
        ),
      ),
    );
  }

  Widget buildNoNoticeItems() {
    return Column(
      children: [
        Expanded(child: Container()),
        const NoItemPanel(
          title: "공지사항이 없습니다.",
        ),
        Expanded(child: Container()),
      ],
    );
  }
}
