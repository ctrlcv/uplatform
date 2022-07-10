import 'package:flutter/material.dart';

class DotTextView extends StatelessWidget {
  const DotTextView({
    Key? key, this.textStr = "", this.textSize = 15, this.textColor = Colors.black,
  }) : super(key: key);

  final String textStr;
  final double textSize;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 2,
          height: textSize + (textSize / 2),
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
          child: Text(
            textStr,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: textSize,
              height: 1.5,
              color: textColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}