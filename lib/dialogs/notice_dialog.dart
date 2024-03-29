import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoticeDialog extends StatefulWidget {
  const NoticeDialog({Key? key, this.title = "", this.subTitle = "", this.contents = ""}) : super(key: key);

  final String title;
  final String subTitle;
  final String contents;

  @override
  _NoticeDialogState createState() => _NoticeDialogState();
}

class _NoticeDialogState extends State<NoticeDialog> {
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
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 22,
                  height: 1.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (widget.subTitle.isNotEmpty)
              const SizedBox(height: 4),
            if (widget.subTitle.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                alignment: Alignment.center,
                child: Text(
                  widget.subTitle,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
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
                widget.contents,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
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
                )),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
