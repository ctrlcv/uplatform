import 'package:flutter/material.dart';
import 'package:uplatform/page/common/tab/faq_tab.dart';
import 'package:uplatform/page/common/tab/notice_tab.dart';
import 'package:uplatform/page/common/tab/qna_tab.dart';

class HelpCenterTab extends StatefulWidget {
  const HelpCenterTab({Key? key, this.startTab = 0}) : super(key: key);
  final int startTab;

  @override
  _HelpCenterTabState createState() => _HelpCenterTabState();
}

class _HelpCenterTabState extends State<HelpCenterTab> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  final List<String> _helpCenterTabs = ["공지사항", "FAQ", "1:1 문의"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _helpCenterTabs.length);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
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
              const SizedBox(height: 12),
              Container(
                height: 31,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "고객센터",
                  style: TextStyle(
                    fontSize: 26,
                    height: 1.2,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 16),
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
