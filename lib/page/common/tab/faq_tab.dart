import 'package:flutter/material.dart';
import 'package:uplatform/components/container_progress.dart';
import 'package:uplatform/components/no_item_panel.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/notice_model.dart';
import 'package:uplatform/page/common/faq_detail_page.dart';
import 'package:uplatform/services/network.dart';
import 'package:get/get.dart';

class FaqTab extends StatefulWidget {
  const FaqTab({Key? key}) : super(key: key);

  @override
  _FaqTabState createState() => _FaqTabState();
}

class _FaqTabState extends State<FaqTab> {
  final ScrollController _scrollController = ScrollController();

  bool _isLoading = false;
  bool _isNoItem = false;
  bool _isMoreLoading = false;
  String _lastItemId = "";
  int _requestCount = 0;
  String _selectedCategory = "전체";

  List<FAQItem> _faqItemList = [];

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        debugPrint('Slide to the bottom ${_scrollController.position.pixels}');
        loadFaqItemListMore();
      }
    });

    loadFaqItemList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future loadFaqItemList() async {
    _isLoading = true;

    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};

    params['start_no'] = "0";
    params['row'] = kListLoadCount.toString();
    params['type'] = _selectedCategory;

    FAQItemList faqList = await Network().reqFaqList(params);

    if (faqList.status != "200" || faqList.count == 0) {
      _isLoading = false;
      _isNoItem = true;
      _faqItemList = [];

      if (mounted) {
        setState(() {});
      }
      return;
    }

    _isNoItem = false;
    _faqItemList = faqList.result!;
    _requestCount = faqList.count ?? 0;

    if (_faqItemList.isNotEmpty) {
      FAQItem lastFaq = _faqItemList[_faqItemList.length - 1];
      _lastItemId = lastFaq.faqId ?? "0";
    }

    _isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future loadFaqItemListMore() async {
    if (_faqItemList.isNotEmpty && _faqItemList.length >= _requestCount) {
      return;
    }

    _isMoreLoading = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};
    params['start_no'] = _lastItemId;
    params['row'] = kListLoadCount.toString();
    params['type'] = _selectedCategory;

    FAQItemList faqList = await Network().reqFaqList(params);

    if (faqList.status != "200" || faqList.count == 0) {
      _isMoreLoading = false;
      if (mounted) {
        setState(() {});
      }
      return;
    }

    List<FAQItem>? noticeItemList = faqList.result;
    if (noticeItemList != null) {
      _faqItemList.addAll(noticeItemList);
    }

    if (_faqItemList.isNotEmpty) {
      FAQItem lastFaq = _faqItemList[_faqItemList.length - 1];
      _lastItemId = lastFaq.faqId ?? "0";
    }

    _isMoreLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 20),
                buildCategoryItem("전체"),
                const SizedBox(width: 4),
                buildCategoryItem("회원/로그인"),
                const SizedBox(width: 4),
                buildCategoryItem("결제"),
                const SizedBox(width: 4),
                buildCategoryItem("일반회원"),
                const SizedBox(width: 4),
                buildCategoryItem("전문가회원"),
                const SizedBox(width: 4),
                buildCategoryItem("서비스"),
                const SizedBox(width: 20),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: _isLoading
                ? const ContainerProgress()
                : _isNoItem
                    ? buildNoFaqItems()
                    : Stack(
                        children: [
                          RefreshIndicator(
                            child: ListView.builder(
                              controller: _scrollController,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: _faqItemList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return buildFAQItem(
                                  _faqItemList[index],
                                  (index == _faqItemList.length - 1),
                                );
                              },
                            ),
                            onRefresh: loadFaqItemList,
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
        ),
      ],
    );
  }

  Widget buildFAQItem(FAQItem faqItem, bool isLastItem) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(FaqDetailPage.routeName, arguments: faqItem.faqId);
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
              "[${faqItem.type}] ${faqItem.title}",
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            if (!isLastItem) kHorizontalLineNoMargin,
          ],
        ),
      ),
    );
  }

  Widget buildNoFaqItems() {
    return Column(
      children: [
        Expanded(child: Container()),
        const NoItemPanel(
          title: "FAQ 내역이 없습니다.",
        ),
        Expanded(child: Container()),
      ],
    );
  }

  Widget buildCategoryItem(String title) {
    return GestureDetector(
      onTap: () {
        if (_selectedCategory != title) {
          _selectedCategory = title;
          loadFaqItemList();
        }
      },
      child: Container(
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: (_selectedCategory == title) ? const Color(0xFF686C73) : const Color(0xFFF5F6F8),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            color: (_selectedCategory == title) ? Colors.white : const Color(0xFF686C73),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
