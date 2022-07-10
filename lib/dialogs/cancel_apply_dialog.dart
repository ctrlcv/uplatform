import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CancelApplyDialog extends StatefulWidget {
  const CancelApplyDialog({Key? key}) : super(key: key);

  @override
  _CancelApplyDialogState createState() => _CancelApplyDialogState();
}

class _CancelApplyDialogState extends State<CancelApplyDialog> {
  String _cancelReason = "";

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
                "지원 취소",
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
              padding: const EdgeInsets.symmetric(vertical: 2),
              alignment: Alignment.center,
              child: const Text(
                "지원을 취소하시겠습니까?",
                style: TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Container(
              height: 40,
              width: 280,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xFFE4E7ED),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              child: SizedBox(
                width: 280,
                child: DropdownButton<String>(
                  value: (_cancelReason.isNotEmpty) ? _cancelReason : null,
                  underline: Container(),
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF898D93)),
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  hint: const Text(
                    "취소사유 선택",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.0,
                      color: Color(0xFF686C73),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  elevation: 0,
                  dropdownColor: const Color(0xFFE4E7ED),
                  autofocus: false,
                  items: [
                    "서비스 불만",
                    "서비스 금액 상이",
                    "개인 사유",
                    "기타",
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    if (value != null) {
                      _cancelReason = value;
                    }

                    if (mounted) {
                      setState(() {});
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.back(result: "");
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6F8),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "취소",
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.0,
                              color: Color(0xFF686C73),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (_cancelReason.isEmpty) {
                            Get.snackbar('취소사유', "취소사유를 선택하세요",
                                snackPosition: SnackPosition.BOTTOM, duration: const Duration(milliseconds: 1500));
                            return;
                          }

                          Get.back(result: _cancelReason);
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
                )),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
