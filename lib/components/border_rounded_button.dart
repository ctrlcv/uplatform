import 'package:flutter/material.dart';
import 'package:uplatform/constants/constants.dart';

class BorderRoundedButton extends StatelessWidget {
  const BorderRoundedButton({
    Key? key,
    this.text = "확인",
    this.active = true,
    this.textColor = Colors.black,
    this.borderColor = Colors.transparent,
    this.buttonColor = kMainColor,
    this.deActiveTextColor = const Color(0xFF808080),
    this.deActiveColor = const Color(0xFFFFE089),
    required this.onPressed,
    this.buttonHeight = 52,
    this.fontSize = 17,
    this.deActiveLineColor = Colors.white,
  }) : super(key: key);

  final String text;
  final bool active;
  final Color textColor;
  final Color borderColor;
  final Color buttonColor;
  final Color deActiveTextColor;
  final Color deActiveColor;
  final Color deActiveLineColor;
  final double buttonHeight;
  final double fontSize;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: active ? buttonColor : deActiveColor,
      highlightColor: active ? null : deActiveColor,
      elevation: 0,
      focusElevation: active ? 0.5 : 0,
      hoverElevation: active ? 0.5 : 0,
      highlightElevation: active ? 0.5 : 0,
      enableFeedback: active,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          width: 1,
          color: active
              ? (borderColor != Colors.transparent)
                  ? borderColor
                  : (buttonColor == kMainColor)
                      ? kMainColor
                      : const Color(0xFFE4E7ED)
              : (deActiveLineColor == Colors.white)
                  ? deActiveColor
                  : deActiveLineColor,
        ),
      ),
      onPressed: () {
        if (!active) {
          return;
        }

        onPressed();
      },
      child: Container(
        height: buttonHeight,
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: active ? textColor : deActiveTextColor,
            height: 1.1,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
