import 'package:flutter/material.dart';
import 'package:uplatform/components/no_item_panel.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/models/notice_model.dart';
import 'package:uplatform/page/common/tab/faq_tab.dart';
import 'package:uplatform/page/common/tab/notice_tab.dart';
import 'package:uplatform/page/common/tab/qna_tab.dart';

class ExpertHelpCenterTab extends StatefulWidget {
  const ExpertHelpCenterTab({Key? key, this.startTab = 0}) : super(key: key);

  final int startTab;

  @override
  _ExpertHelpCenterTabState createState() => _ExpertHelpCenterTabState();
}

class _ExpertHelpCenterTabState extends State<ExpertHelpCenterTab> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  final List<String> _helpCenterTabs = ["공지사항", "FAQ", "1:1 문의"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _helpCenterTabs.length);

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      _tabController!.animateTo(widget.startTab, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
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
                titleText: "고객센터",
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
                              Tab(text: _helpCenterTabs[0]),
                              Tab(text: _helpCenterTabs[1]),
                              Tab(text: _helpCenterTabs[2]),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: DefaultTabController(
                        length: _helpCenterTabs.length,
                        child: TabBarView(
                          controller: _tabController,
                          children: const [
                            NoticeTab(),
                            FaqTab(),
                            QnaTab(),
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
}
