import 'package:flutter/material.dart';
import 'package:uplatform/constants/constants.dart';

class CheckBox extends StatelessWidget {
  const CheckBox({
    Key? key,
    this.isSelected = false,
  }) : super(key: key);

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        color: isSelected ? kMainColor : Colors.white,
        border: Border.all(
          color: isSelected ? kMainColor : const Color(0xFFE4E7ED),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      alignment: Alignment.center,
      child: isSelected ? const Icon(Icons.check, size: 15, color: Colors.black) : Container(),
    );
  }
}
