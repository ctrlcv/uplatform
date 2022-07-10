import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/dot_text_view.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/dialogs/cancel_apply_dialog.dart';
import 'package:uplatform/models/common_model.dart';
import 'package:uplatform/services/network.dart';

import '../../dialogs/notice_dialog.dart';

class RequestFinishPage extends StatefulWidget {
  const RequestFinishPage({Key? key}) : super(key: key);

  static const routeName = '/RequestFinishPage';

  @override
  _RequestFinishPageState createState() => _RequestFinishPageState();
}

class _RequestFinishPageState extends State<RequestFinishPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(iconData: Icons.close),
        body: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/icons_applause_large.png",
                      width: 60,
                      height: 60,
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      "지원이 완료되었어요!",
                      style: TextStyle(
                        fontSize: 24,
                        height: 1.2,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "관리자가 검토 후 확정 안내드릴 예정입니다.",
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.2,
                        color: Color(0xFF898D93),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 100),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: const Text(
                "유의사항",
                style: TextStyle(
                  fontSize: 15,
                  height: 1.2,
                  color: Color(0xFF686C73),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: DotTextView(
                textStr: "다른 전문가가 우선 매칭 했을 시 별도 안내 없이 자동 무효 처리되며 [완료]로 표기됩니다.",
                textSize: 13,
                textColor: Color(0xFF898D93),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BorderRoundedButton(
                text: "지원 취소",
                textColor: Colors.black,
                buttonColor: Colors.white,
                onPressed: () async {
                  String resultStr = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const CancelApplyDialog();
                    },
                    barrierDismissible: false,
                  );

                  debugPrint("resultStr $resultStr");

                  if (resultStr.isEmpty) {
                    return;
                  }
                  Map<String, dynamic> params = {};

                  params['apply_id'] = Get.arguments;
                  params['comment'] = resultStr;

                  CommonResponse result = await Network().reqCancelApply(params);

                  if (result.status == "200") {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const NoticeDialog(
                          title: "지원 취소 완료",
                          subTitle: "",
                          contents: "지원이 취소되었습니다.",
                        );
                      },
                      barrierDismissible: false,
                    );
                    Get.back();
                  } else {
                    Get.back();
                    Get.snackbar('지원취소실패', "지원이 취소에 실패하였습니다.",
                        snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                  }
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
