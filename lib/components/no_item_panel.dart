import 'package:flutter/material.dart';

class NoItemPanel extends StatelessWidget {
  const NoItemPanel({
    Key? key,
    required this.title,
    this.addText,
    this.buttonText,
    this.onPressed,
  }) : super(key: key);

  final String title;
  final String? addText;
  final String? buttonText;
  final GestureTapCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Image.asset(
            "assets/images/icons_face_dizzy.png",
            width: 40,
            height: 40,
          ),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                height: 1.2,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (addText != null && addText!.isNotEmpty) const SizedBox(height: 8),
          if (addText != null && addText!.isNotEmpty)
            Container(
              alignment: Alignment.center,
              child: Text(
                addText!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: Color(0xFF898D93),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          const SizedBox(height: 20),
          if (buttonText != null && buttonText!.isNotEmpty)
            GestureDetector(
              onTap: () {
                if (onPressed != null) {
                  onPressed!();
                }
              },
              child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xFFC9CDD4),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  buttonText!,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.1,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
