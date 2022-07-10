import 'package:flutter/material.dart';
import 'package:uplatform/constants/constants.dart';

class ExtraServiceItem extends StatelessWidget {
  const ExtraServiceItem({
    Key? key,
    this.isSelected = false,
    this.title = "",
    this.value = "",
    required this.onChanged,
  }) : super(key: key);

  final bool isSelected;
  final String title;
  final String value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged!(!isSelected);
      },
      child: Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? kSelectColor : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: isSelected ? kSelectColor : const Color(0xFFE4E7ED),
            width: 1,
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.2,
                  color: isSelected ? Colors.white : const Color(0xFF686C73),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 15,
                height: 1.2,
                color: isSelected ? Colors.white : const Color(0xFF686C73),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
