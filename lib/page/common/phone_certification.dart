import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iamport_flutter/iamport_certification.dart';
import 'package:iamport_flutter/model/certification_data.dart';
import 'package:uplatform/components/custom_appbar.dart';

class PhoneCertification extends StatefulWidget {
  const PhoneCertification({Key? key}) : super(key: key);

  static const routeName = '/PhoneCertification';

  @override
  _PhoneCertificationState createState() => _PhoneCertificationState();
}

class _PhoneCertificationState extends State<PhoneCertification> {
  static const String userCode = "imp54637818";

  @override
  Widget build(BuildContext context) {
    CertificationData data = Get.arguments as CertificationData;

    return IamportCertification(
      appBar: const CustomAppBar(iconData: Icons.close),
      initialChild: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/title.png',
                width: 200,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(height: 16),
              const Text(
                '잠시만 기다려주세요...',
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
      userCode: userCode,
      data: data,
      callback: (Map<String, String> result) {
        debugPrint("PhoneCertification: callback result $result");
        Get.back(result: result);
      },
    );
  }
}
