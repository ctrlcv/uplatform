import 'package:flutter/material.dart';
import 'package:uplatform/constants/constants.dart';

class BorderRoundedCheckButton extends StatelessWidget {
  const BorderRoundedCheckButton({
    Key? key,
    this.text = "",
    this.buttonHeight = 48,
    required this.onPressed,
    this.isSelected = false,
    this.selectColor = kBlueColor,
  }) : super(key: key);

  final String text;
  final double buttonHeight;
  final bool isSelected;
  final Color selectColor;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: buttonHeight,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isSelected ? selectColor : const Color(0xFFE4E7ED),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Icon(
                Icons.check,
                size: 18,
                color: isSelected ? selectColor : const Color(0xFF898D93),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(
                    color: isSelected ? selectColor : Colors.black,
                    fontSize: 15,
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
