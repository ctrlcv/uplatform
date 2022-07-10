import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/services/shared_preference.dart';

class PermissionPage extends StatefulWidget {
  const PermissionPage({Key? key}) : super(key: key);

  static const routeName = '/PermissionPage';

  @override
  _PermissionPageState createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    const TextTitle(
                      titleText: "편리한 샤이니오 사용을 위해",
                      cellHeight: 32,
                      fontSize: 24,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    const TextTitle(
                      titleText: "앱 권한을 허용해 주세요.",
                      cellHeight: 32,
                      fontSize: 24,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 40),
                    buildPermissionItem(
                      "assets/images/icons_permission_camera.png",
                      "카메라/갤러리(선택)",
                      "전문가회원 등록 시 자격증, 사업자 등록증 사진 촬영 및 첨부",
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16,
                        alignment: Alignment.center,
                        child: Container(
                          width: 2,
                          height: 2,
                          decoration: BoxDecoration(
                            color: const Color(0xFF898D93),
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "해당 기능을 이용하실 때 동의를 받으며, 허용하지 않아도 서비스 이용이 가능합니다.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF686C73),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BorderRoundedButton(
                    text: "거부",
                    textColor: Colors.black,
                    buttonColor: Colors.white,
                    onPressed: () async {
                      await SharedPreference().saveCheckedPermission(true);
                      Get.back();
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BorderRoundedButton(
                    text: "확인",
                    buttonColor: kMainColor,
                    onPressed: () async {
                      await SharedPreference().saveCheckedPermission(true);

                      await requestPermission();
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            buildBottomBar
          ],
        ),
      ),
    );
  }

  Future<bool> requestPermission() async {
    if (UniversalPlatform.isIOS) {
      final cameraStatus = await Permission.camera.request();
      final photoStatus = await Permission.photos.request();

      return (cameraStatus.isGranted && photoStatus.isGranted);
    } else {
      Map<Permission, PermissionStatus> status = await [Permission.storage, Permission.camera].request();

      bool permitted = true;

      status.forEach((permission, permissionState) {
        if (!permissionState.isGranted) {
          permitted = false;
        }
      });

      return permitted;
    }
  }

  Widget buildPermissionItem(String imagePath, String title, String body) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            child: Image.asset(
              imagePath,
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.2,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    body,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.2,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF898D93),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
