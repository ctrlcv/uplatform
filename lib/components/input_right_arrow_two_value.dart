import 'package:flutter/material.dart';

class InputRightArrowTwoValue extends StatelessWidget {
  const InputRightArrowTwoValue({
    Key? key,
    this.title = "",
    this.isRequired = false,
    this.value = "",
    this.value2nd = "",
    this.onPressed,
    this.hintText = "",
  }) : super(key: key);

  final String title;
  final bool isRequired;
  final String value;
  final String value2nd;
  final String hintText;
  final GestureTapCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 24,
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                height: 1.25,
                color: Color(0xFF686C73),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          if (isRequired)
            Container(
              width: 4,
              height: 4,
              margin: const EdgeInsets.only(left: 2, bottom: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF10000),
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          const SizedBox(width: 15),
          Expanded(
            child: GestureDetector(
              onTap: onPressed,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      (value.isNotEmpty) ? value : hintText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        color: (value.isNotEmpty) ? Colors.black : const Color(0xFFCDD0D3),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (value2nd.isNotEmpty)
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        value2nd,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          color: (value.isNotEmpty) ? Colors.black : const Color(0xFFCDD0D3),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onPressed,
            child: const Icon(
              Icons.navigate_next_sharp,
              color: Color(0xFF898D93),
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
