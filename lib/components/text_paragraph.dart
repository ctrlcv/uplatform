import 'package:flutter/material.dart';

class TextParagraph extends StatelessWidget {
  const TextParagraph({
    Key? key,
    this.paraText = "",
    this.fontSize = 15,
    this.fontWeight = FontWeight.w400,
    this.fontColor = const Color(0xFF686C73),
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
  }) : super(key: key);

  final String paraText;
  final double fontSize;
  final FontWeight fontWeight;
  final Color fontColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      alignment: Alignment.centerLeft,
      child: Text(
        paraText,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: fontSize,
          height: 1.4,
          color: fontColor,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}