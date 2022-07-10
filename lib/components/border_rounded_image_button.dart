import 'package:flutter/material.dart';

class BorderRoundedImageButton extends StatelessWidget {
  const BorderRoundedImageButton({
    Key? key,
    this.imagePath = "",
    this.buttonText = "",
    required this.onPressed,
  }) : super(key: key);

  final String imagePath;
  final String buttonText;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 48,
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
        child: Row(
          children: [
            if (imagePath.isNotEmpty)
              Image.asset(
                imagePath,
                width: 24,
                height: 24,
              ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 1),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.1,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
