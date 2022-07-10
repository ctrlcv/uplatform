import 'package:flutter/material.dart';
import 'package:uplatform/constants/constants.dart';

class GoodsItem extends StatelessWidget {
  const GoodsItem({
    Key? key,
    this.isSelected = false,
    this.title = "",
    this.contents = "",
    this.value = "",
    required this.onChanged,
    this.selectColor = kSelectColor,
  }) : super(key: key);

  final bool isSelected;
  final String title;
  final String contents;
  final String value;
  final Color selectColor;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged!(!isSelected);
      },
      child: Container(
        height: 68,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? selectColor : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: isSelected ? selectColor : const Color(0xFFE4E7ED),
            width: 1,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 22,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        color: isSelected ? Colors.white : const Color(0xFF686C73),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 15,
                      color: isSelected ? Colors.white : const Color(0xFF686C73),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 18,
              alignment: Alignment.centerLeft,
              child: Text(
                contents,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : const Color(0xFF898D93),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
