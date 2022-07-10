import 'package:flutter/material.dart';
import 'package:uplatform/constants/constants.dart';

class ContainerProgress extends StatelessWidget {
  const ContainerProgress({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    if (width != null && height != null) {
      return Column(
        children: [
          Expanded(child: Container()),
          SizedBox(
            width: width,
            height: height,
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kMainColor),
              ),
            ),
          ),
          Expanded(child: Container()),
        ],
      );
    }

    return Column(
      children: [
        Expanded(child: Container()),
        const SizedBox(
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kMainColor),
            ),
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }
}