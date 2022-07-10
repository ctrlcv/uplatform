import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/components/container_progress.dart';
import 'package:uplatform/components/no_item_panel.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/common_model.dart';
import 'package:uplatform/models/request_model.dart';
import 'package:uplatform/page/expert/request_detail_page.dart';
import 'package:uplatform/services/network.dart';

import '../request_finish_page.dart';

class ExpertHomeTab extends StatefulWidget {
  const ExpertHomeTab({Key? key}) : super(key: key);

  @override
  _ExpertHomeTabState createState() => _ExpertHomeTabState();
}

class _ExpertHomeTabState extends State<ExpertHomeTab> with SingleTickerProviderStateMixin {
  String _tabServiceList = "서비스 요청";
  String _tabServiceInLocal = "같은 지역 내 요청";

  List<Request>? _serviceList = [];
  List<Request>? _serviceLocalList = [];

  final ScrollController _scrollController = ScrollController();
  final ScrollController _localScrollController = ScrollController();

  TabController? _tabController;

  bool _isLoading = false;

  bool _isMoreLoading = false;
  bool _isMoreLocalLoading = false;

  int _requestCount = 0;
  int _localRequestCount = 0;

  String _lastItemId = "";
  String _moreLastItemId = "";

  bool _isNoItem = false;
  bool _isNoLocalItem = false;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 2);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        debugPrint('Slide to the bottom ${_scrollController.position.pixels}');
        loadServiceRequestListMore();
      }
    });

    _localScrollController.addListener(() {
      if (_localScrollController.position.pixels == _localScrollController.position.maxScrollExtent) {
        debugPrint('Local Slide to the bottom ${_localScrollController.position.pixels}');
        loadLocalServiceRequestListMore();
      }
    });

    loadServiceRequestList();
    loadLocalServiceRequestList();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _scrollController.dispose();
    _localScrollController.dispose();

    super.dispose();
  }

  Future loadServiceRequestList() async {
    _isLoading = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};
    params['type'] = "all";
    params['start_no'] = "0";
    params['row'] = kListLoadCount.toString();

    RequestList? requestServiceList = await Network().reqPartnerRequestList(params);

    if (requestServiceList != null) {
      _serviceList = requestServiceList.result;
    }

    if (requestServiceList == null || _serviceList == null || _serviceList!.isEmpty) {
      _serviceList = [];
      _isNoItem = true;
      _tabServiceList = "서비스 요청";
      _lastItemId = "0";
    } else {
      _isNoItem = false;
      _requestCount = requestServiceList.count ?? 0;
      _tabServiceList = "서비스 요청 (${_requestCount.toString()}건)";

      if (_serviceList != null && _serviceList!.isNotEmpty) {
        Request lastRequest = _serviceList![_serviceList!.length - 1];
        _lastItemId = lastRequest.reservationId ?? "0";
      }
    }

    _isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future loadServiceRequestListMore() async {
    if (_serviceList != null && _serviceList!.length >= _requestCount) {
      return;
    }

    _isMoreLoading = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};
    params['type'] = "all";
    params['start_no'] = _lastItemId;
    params['row'] = kListLoadCount.toString();

    RequestList? requestServiceList = await Network().reqPartnerRequestList(params);

    if (requestServiceList == null) {
      _isMoreLoading = false;
      if (mounted) {
        setState(() {});
      }
      return;
    }

    List<Request>? serviceList = requestServiceList.result;
    if (serviceList != null) {
      _serviceList?.addAll(serviceList);
    }

    if (_serviceList != null && _serviceList!.isNotEmpty) {
      Request lastRequest = _serviceList![_serviceList!.length - 1];
      _lastItemId = lastRequest.reservationId ?? "0";
    }

    _isMoreLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future loadLocalServiceRequestList() async {
    _isLoading = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};
    params['type'] = "local";
    params['start_no'] = "0";
    params['row'] = kListLoadCount.toString();

    RequestList? requestLocalServiceList = await Network().reqPartnerRequestList(params);

    if (requestLocalServiceList != null) {
      _serviceLocalList = requestLocalServiceList.result;
    }

    if (requestLocalServiceList == null || _serviceLocalList == null || _serviceLocalList!.isEmpty) {
      _isNoLocalItem = true;
      _tabServiceInLocal = "같은 지역 내 요청";
      _serviceLocalList = [];
      _moreLastItemId = "0";
    } else {
      _isNoLocalItem = false;
      _localRequestCount = requestLocalServiceList.count ?? 0;
      _tabServiceInLocal = "같은 지역 내 요청 (${_localRequestCount.toString()}건)";

      if (_serviceLocalList != null && _serviceLocalList!.isNotEmpty) {
        Request lastRequest = _serviceLocalList![_serviceLocalList!.length - 1];
        _moreLastItemId = lastRequest.reservationId ?? "0";
      }
    }

    _isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future loadLocalServiceRequestListMore() async {
    if (_serviceLocalList != null && _serviceLocalList!.length >= _localRequestCount) {
      return;
    }

    _isMoreLocalLoading = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};
    params['type'] = "local";
    params['start_no'] = _moreLastItemId;
    params['row'] = kListLoadCount.toString();

    RequestList? requestServiceList = await Network().reqPartnerRequestList(params);

    if (requestServiceList == null) {
      _isMoreLocalLoading = false;
      if (mounted) {
        setState(() {});
      }
      return;
    }

    List<Request>? serviceList = requestServiceList.result;
    if (serviceList != null) {
      _serviceLocalList?.addAll(serviceList);
    }

    if (_serviceLocalList != null && _serviceLocalList!.isNotEmpty) {
      Request lastRequest = _serviceLocalList![_serviceLocalList!.length - 1];
      _moreLastItemId = lastRequest.reservationId ?? "0";
    }

    _isMoreLocalLoading = false;
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
                titleText: "서비스 요청",
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
                                text: _tabServiceList,
                              ),
                              Tab(
                                text: _tabServiceInLocal,
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
                                      ? buildNoServiceRequest()
                                      : Stack(
                                          children: [
                                            RefreshIndicator(
                                              child: ListView.builder(
                                                controller: _scrollController,
                                                shrinkWrap: true,
                                                padding: const EdgeInsets.symmetric(vertical: 18),
                                                physics: const ClampingScrollPhysics(),
                                                itemCount: _serviceList!.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  return buildServiceItem(_serviceList![index]);
                                                },
                                              ),
                                              onRefresh: loadServiceRequestList,
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
                                  : _isNoLocalItem
                                      ? buildNoServiceRequestInArea()
                                      : Stack(
                                          children: [
                                            RefreshIndicator(
                                              child: ListView.builder(
                                                controller: _localScrollController,
                                                shrinkWrap: true,
                                                padding: const EdgeInsets.symmetric(vertical: 18),
                                                physics: const ClampingScrollPhysics(),
                                                itemCount: _serviceLocalList!.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  return buildServiceItem(_serviceLocalList![index]);
                                                },
                                              ),
                                              onRefresh: loadLocalServiceRequestList,
                                            ),
                                            Offstage(
                                              offstage: !_isMoreLocalLoading,
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

  Widget buildServiceItem(Request service) {
    return GestureDetector(
      onTap: () async {
        await Get.toNamed(RequestDetailPage.routeName, arguments: service.reservationId);

        Map<String, dynamic> params = {};
        params['reservation_id'] = service.reservationId;

        RequestDetail? requestDetail = await Network().reqRequestDetail(params);

        if (requestDetail != null) {
          for (int i = 0; i < _serviceList!.length; i++) {
            if (_serviceList![i].reservationId == service.reservationId) {
              _serviceList![i].applyCount = requestDetail.applyCount;
              _serviceList![i].applied = requestDetail.applied;
              break;
            }
          }

          for (int i = 0; i < _serviceLocalList!.length; i++) {
            if (_serviceLocalList![i].reservationId == service.reservationId) {
              _serviceLocalList![i].applyCount = requestDetail.applyCount;
              _serviceLocalList![i].applied = requestDetail.applied;
              break;
            }
          }

          if (mounted) {
            setState(() {});
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFE4E7ED),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            const SizedBox(height: 2),
            Container(
              height: 24,
              alignment: Alignment.centerLeft,
              child: Text(
                service.reservationTypeTitle ?? "",
                style: const TextStyle(
                  fontSize: 18,
                  height: 1.1,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Container(
              height: 22,
              alignment: Alignment.centerLeft,
              child: Text(
                (service.reservationType != "LC") ? service.serviceDateTime ?? "" : service.learnDay ?? "",
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.1,
                  color: Color(0xFF898D93),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 22,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      service.serviceAddress ?? "",
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.1,
                        color: Color(0xFF898D93),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const Icon(Icons.person, color: Color(0xFF686C73), size: 17),
                const SizedBox(width: 3),
                Container(
                  height: 22,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "지원자",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.1,
                      color: Color(0xFF898D93),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(width: 3),
                Container(
                  height: 22,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    service.applyCount ?? "",
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.1,
                      color: Color(0xFF10A2DC),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  height: 22,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "명",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.1,
                      color: Color(0xFF898D93),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                if (service.applied == "Y") {
                  return;
                }

                Map<String, dynamic> params = {};

                params['reservation_id'] = service.reservationId;
                CommonResponse result = await Network().reqRegApply(params);
                if (result.status == "200") {
                  await Get.toNamed(RequestFinishPage.routeName);

                  service.applied = "Y";
                  int applyCount = int.parse(service.applyCount ?? "0");
                  service.applyCount = (applyCount++).toString();

                  if (mounted) {
                    setState(() {});
                  }
                }
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: (service.applied != "Y") ? const Color(0xFF10A2DC) : const Color(0xFFC9CDD4),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  (service.applied != "Y") ? "지원하기" : "지원완료",
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.1,
                    color: (service.applied != "Y") ? const Color(0xFF10A2DC) : const Color(0xFFC9CDD4),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNoServiceRequestInArea() {
    return Column(
      children: [
        Expanded(child: Container()),
        const NoItemPanel(
          title: "주소가 등록되지 않았거나\n지역 내의 서비스 요청이 없습니다.",
        ),
        const Text(
          "주소등록 : 프로필 > 주소입력 > 저장",
          style: TextStyle(
            fontSize: 15,
            height: 1.1,
            color: Color(0xFF686C73),
            fontWeight: FontWeight.w400,
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }

  Widget buildNoServiceRequest() {
    return Column(
      children: [
        Expanded(child: Container()),
        const NoItemPanel(
          title: "서비스 요청이 없습니다.",
        ),
        Expanded(child: Container()),
      ],
    );
  }
}
