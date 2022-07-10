import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferNotiDialog extends StatefulWidget {
  const TransferNotiDialog({Key? key, this.arguments = "", this.type = "email"}) : super(key: key);

  final String type;
  final String arguments;

  @override
  _TransferNotiDialogState createState() => _TransferNotiDialogState();
}

class _TransferNotiDialogState extends State<TransferNotiDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 320,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(color: Colors.black, offset: Offset(0, 0.5), blurRadius: 0.5),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 26),
            Container(
              height: 30,
              alignment: Alignment.center,
              child: const Text(
                "서비스 이용안내",
                style: TextStyle(
                  fontSize: 22,
                  height: 1.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
              alignment: Alignment.center,
              child: Text(
                "이미 일반회원 또는 전문가 회원으로 가입된" + (widget.type == 'email' ? "이메일" : "휴대폰 번호") + " 입니다.\n다시 확인해 주세요.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back(result: "YES");
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFC113),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "확인",
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
