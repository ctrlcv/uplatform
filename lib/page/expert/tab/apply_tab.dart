import 'package:flutter/material.dart';
import 'package:uplatform/components/container_progress.dart';
import 'package:uplatform/components/no_item_panel.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/request_model.dart';
import 'package:uplatform/page/expert/apply_detail_page.dart';
import 'package:uplatform/services/network.dart';
import 'package:get/get.dart';

class ApplyTab extends StatefulWidget {
  const ApplyTab({Key? key}) : super(key: key);

  @override
  _ApplyTabState createState() => _ApplyTabState();
}

class _ApplyTabState extends State<ApplyTab> with SingleTickerProviderStateMixin {
  String _tabApplyTab = "신규 지원내역";
  String _tabPastApplyTab = "지난 지원내역";

  TabController? _tabController;

  List<ApplyItem>? _applyItemList = [];
  List<ApplyItem>? _pastApplyItemList = [];

  final ScrollController _scrollController = ScrollController();
  final ScrollController _pastScrollController = ScrollController();

  bool _isLoading = false;

  bool _isMoreLoading = false;
  bool _isMorePastLoading = false;

  int _applyCount = 0;
  int _pastRequestCount = 0;

  String _lastItemId = "";
  String _morePastItemId = "";

  bool _isNoItem = false;
  bool _isNoPastItem = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        debugPrint('Slide to the bottom ${_scrollController.position.pixels}');
        loadApplyItemListMore();
      }
    });

    _pastScrollController.addListener(() {
      if (_pastScrollController.position.pixels == _pastScrollController.position.maxScrollExtent) {
        debugPrint('Local Slide to the bottom ${_pastScrollController.position.pixels}');
        loadPastApplyItemListMore();
      }
    });

    loadApplyItemList();
    loadPastApplyItemList();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _scrollController.dispose();
    _pastScrollController.dispose();

    super.dispose();
  }

  Future loadApplyItemList() async {
    _isLoading = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};
    params['type'] = "ing";
    params['start_no'] = "0";
    params['row'] = kListLoadCount.toString();

    ApplyItemList? applyItemList = await Network().reqApplyList(params);

    _applyItemList = applyItemList!.result;

    if (_applyItemList == null || _applyItemList!.isEmpty) {
      _applyItemList = [];
      _isNoItem = true;
      _tabApplyTab = "신규 지원내역";
      _lastItemId = "0";
    } else {
      _isNoItem = false;
      _applyCount = applyItemList.count ?? 0;
      _tabApplyTab = "서비스 요청 (${_applyCount.toString()}건)";

      if (_applyItemList != null && _applyItemList!.isNotEmpty) {
        ApplyItem lastApplyItem = _applyItemList![_applyItemList!.length - 1];
        _lastItemId = lastApplyItem.applyId ?? "0";
      }
    }

    _isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future loadApplyItemListMore() async {
    if (_applyItemList != null && _applyItemList!.length >= _applyCount) {
      return;
    }

    _isMoreLoading = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};
    params['type'] = "ing";
    params['start_no'] = _lastItemId;
    params['row'] = kListLoadCount.toString();

    ApplyItemList? applyItemList = await Network().reqApplyList(params);

    if (applyItemList == null) {
      return;
    }

    List<ApplyItem>? applyList = applyItemList.result;
    if (applyList != null) {
      _applyItemList?.addAll(applyList);
    }

    if (_applyItemList != null && _applyItemList!.isNotEmpty) {
      ApplyItem lastApplyItem = _applyItemList![_applyItemList!.length - 1];
      _lastItemId = lastApplyItem.applyId ?? "0";
    }

    _isMoreLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future loadPastApplyItemList() async {
    _isLoading = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};
    params['type'] = "end";
    params['start_no'] = "0";
    params['row'] = kListLoadCount.toString();

    ApplyItemList? applyItemList = await Network().reqApplyList(params);

    _pastApplyItemList = applyItemList!.result;

    if (_pastApplyItemList == null || _pastApplyItemList!.isEmpty) {
      _isNoPastItem = true;
      _tabPastApplyTab = "지난 지원내역";
      _pastApplyItemList = [];
      _morePastItemId = "0";
    } else {
      _isNoPastItem = false;
      _pastRequestCount = applyItemList.count ?? 0;
      _tabPastApplyTab = "지난 지원내역 (${_pastRequestCount.toString()}건)";

      if (_pastApplyItemList != null && _pastApplyItemList!.isNotEmpty) {
        ApplyItem lastApplyItem = _pastApplyItemList![_pastApplyItemList!.length - 1];
        _morePastItemId = lastApplyItem.applyId ?? "0";
      }
    }

    _isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future loadPastApplyItemListMore() async {
    if (_pastApplyItemList!.length >= _pastRequestCount) {
      return;
    }

    _isMorePastLoading = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};
    params['type'] = "end";
    params['start_no'] = _morePastItemId;
    params['row'] = kListLoadCount.toString();

    ApplyItemList? applyItemList = await Network().reqApplyList(params);

    if (applyItemList == null) {
      return;
    }

    List<ApplyItem>? applyList = applyItemList.result;
    if (applyList != null) {
      _pastApplyItemList?.addAll(applyList);
    }

    if (_pastApplyItemList != null && _pastApplyItemList!.isNotEmpty) {
      ApplyItem lastApplyItem = _pastApplyItemList![_pastApplyItemList!.length - 1];
      _morePastItemId = lastApplyItem.applyId ?? "0";
    }

    _isMorePastLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 16),
              const TextTitle(
                titleText: "서비스 지원내역",
                cellHeight: 34,
                fontSize: 26,
                fontColor: Colors.black,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 40,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFFE4E7ED),
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: TabBar(
                            controller: _tabController,
                            labelColor: Colors.black,
                            unselectedLabelColor: const Color(0xFFE4E7ED),
                            indicatorWeight: 2,
                            indicatorColor: Colors.black,
                            labelStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            unselectedLabelStyle: const TextStyle(
                              fontSize: 15,
                              color: Color(0xFF898D93),
                              fontWeight: FontWeight.w400,
                            ),
                            tabs: [
                              Tab(
                                text: _tabApplyTab,
                              ),
                              Tab(
                                text: _tabPastApplyTab,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: DefaultTabController(
                        length: 2,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Container(
                              child: _isLoading
                                  ? const ContainerProgress()
                                  : _isNoItem
                                      ? buildNoApplyItems()
                                      : Stack(
                                          children: [
                                            RefreshIndicator(
                                              child: ListView.builder(
                                                controller: _scrollController,
                                                shrinkWrap: true,
                                                padding: const EdgeInsets.only(top: 18),
                                                physics: const ClampingScrollPhysics(),
                                                itemCount: _applyItemList!.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  return buildApplyItem(
                                                    _applyItemList![index],
                                                    (index == _applyItemList!.length - 1),
                                                  );
                                                },
                                              ),
                                              onRefresh: loadApplyItemList,
                                            ),
                                            Offstage(
                                              offstage: !_isMoreLoading,
                                              child: const Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            ),
                                          ],
                                        ),
                            ),
                            Container(
                              child: _isLoading
                                  ? const ContainerProgress()
                                  : _isNoPastItem
                                      ? buildNoPastApplyItems()
                                      : Stack(
                                          children: [
                                            RefreshIndicator(
                                              child: ListView.builder(
                                                controller: _pastScrollController,
                                                shrinkWrap: true,
                                                padding: const EdgeInsets.only(top: 18),
                                                physics: const ClampingScrollPhysics(),
                                                itemCount: _pastApplyItemList!.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  return buildApplyItem(
                                                    _pastApplyItemList![index],
                                                    (index == _pastApplyItemList!.length - 1),
                                                  );
                                                },
                                              ),
                                              onRefresh: loadPastApplyItemList,
                                            ),
                                            Offstage(
                                              offstage: !_isMorePastLoading,
                                              child: const Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            ),
                                          ],
                                        ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNoApplyItems() {
    return Column(
      children: [
        Expanded(child: Container()),
        const NoItemPanel(
          title: "지원 내역이 없습니다.",
        ),
        Expanded(child: Container()),
      ],
    );
  }

  Widget buildNoPastApplyItems() {
    return Column(
      children: [
        Expanded(child: Container()),
        const NoItemPanel(
          title: "지난 지원 내역이 없습니다.",
        ),
        Expanded(child: Container()),
      ],
    );
  }

  Widget buildApplyItem(ApplyItem applyItem, bool isLastItem) {
    return GestureDetector(
      onTap: () async {
        debugPrint("applyItem.applyId ${applyItem.applyId}");

        var result = await Get.toNamed(ApplyDetailPage.routeName, arguments: applyItem.applyId);

        // debugPrint("result: $result");

        if (result == "cancel_apply") {
          loadPastApplyItemList();

          for (int i = 0; i < _applyItemList!.length; i++) {
            if (_applyItemList![i].applyId == applyItem.applyId) {
              _applyItemList!.removeAt(i);

              _applyCount--;
              if (_applyCount <= 0) {
                _applyCount = 0;
                _tabApplyTab = "서비스 요청";
              } else {
                _tabApplyTab = "서비스 요청 (${_applyCount.toString()}건)";
              }

              if (mounted) {
                setState(() {});
              }
              break;
            }
          }
        }
      },
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 20,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          (applyItem.reservationType != "LC") ? applyItem.serviceDateTime ?? "" : applyItem.learnDay ?? "",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.0,
                            color: Color(0xFF898D93),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 20,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          applyItem.reservationTypeStr ?? "",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (applyItem.status != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: (applyItem.statusStr == "확정")
                          ? const Color(0xFFF4FAFF)
                          : (applyItem.statusStr == "지원취소")
                              ? const Color(0xFFFFF4F4)
                              : const Color(0xFFF5F6F8),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      applyItem.statusStr ?? "",
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.1,
                        color: (applyItem.statusStr == "확정")
                            ? const Color(0xFF10A2DC)
                            : (applyItem.statusStr == "지원취소")
                                ? const Color(0xFFF16A34)
                                : const Color(0xFF686C73),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            if (!isLastItem) kHorizontalLineNoMargin,
          ],
        ),
      ),
    );
  }
}
