import 'package:flutter/material.dart';
import 'package:uplatform/components/container_progress.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/no_item_panel.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/models/common_model.dart';
import 'package:uplatform/services/login_service.dart';
import 'package:uplatform/services/network.dart';
import 'package:uplatform/services/shared_preference.dart';
import 'package:uplatform/utils/utils.dart';

class AlarmListPage extends StatefulWidget {
  const AlarmListPage({Key? key}) : super(key: key);

  static const routeName = '/AlarmListPage';

  @override
  _AlarmListPageState createState() => _AlarmListPageState();
}

class _AlarmListPageState extends State<AlarmListPage> {
  bool _isLoading = false;
  bool _isNoItem = false;
  List<AlarmItem> _alarmItemList = [];

  @override
  void initState() {
    super.initState();

    loadAlarmList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future loadAlarmList() async {
    _isLoading = true;
    if (mounted) {
      setState(() {});
    }

    AlarmItemList? alarmList = await Network().reqAlarmList();

    if (alarmList == null || alarmList.status != "200" || alarmList.count == 0) {
      _isLoading = false;
      _isNoItem = true;
      _alarmItemList = [];

      if (mounted) {
        setState(() {});
      }
      return;
    }

    _alarmItemList = alarmList.result ?? [];
    if (_alarmItemList.isNotEmpty) {
      _alarmItemList.sort((itemA, itemB) {
        if (int.parse(itemA.alarmId ?? "-1") > int.parse(itemB.alarmId ?? "-1")) {
          return -1;
        } else if (int.parse(itemA.alarmId ?? "-1") < int.parse(itemB.alarmId ?? "-1")) {
          return 1;
        } else {
          return 0;
        }
      });

      await SharedPreference().saveLastReadAlarmId(_alarmItemList[0].alarmId ?? "-1");
      await LoginService().calcUnReadAlarmCount();
    }

    _isNoItem = false;
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
        body: Column(
          children: [
            const SizedBox(height: 16),
            const TextTitle(
              titleText: "알림",
              cellHeight: 32,
              fontSize: 24,
              fontColor: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 40),
            Expanded(
              child: _isLoading
                  ? const ContainerProgress()
                  : _isNoItem
                      ? buildNoAlarmItems()
                      : RefreshIndicator(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: _alarmItemList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return buildAlarmItem(_alarmItemList[index]);
                          },
                        ),
                        onRefresh: loadAlarmList,
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAlarmItem(AlarmItem alarm) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            getIconData(alarm.content ?? ""),
            size: 20,
            color: const Color(0xFF686C73),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alarm.content ?? "",
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.2,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  Utils().getDisplayDateTime2(alarm.sendDate ?? ""),
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.2,
                    color: Color(0xFF898D93),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData getIconData(String content) {
    if (content.contains("1:1 문의")) {
      return Icons.article_outlined;
    }

    if (content.contains("으로 전환되었습니다")) {
      return Icons.sync;
    }

    return Icons.task_alt_outlined;
  }

  Widget buildNoAlarmItems() {
    return Column(
      children: [
        Expanded(child: Container()),
        const NoItemPanel(
          title: "알림 내역이 없습니다.",
        ),
        Expanded(child: Container()),
      ],
    );
  }
}
