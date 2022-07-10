import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.iconData = Icons.close,
    this.onClosePressed,
  }) : super(key: key);

  final IconData iconData;
  final GestureTapCallback? onClosePressed;

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      leading: IconButton(
        padding: const EdgeInsets.only(left: 16, top: 0, bottom: 0),
        icon: Icon(
          iconData,
          color: Colors.black,
        ),
        iconSize: 22,
        onPressed: () {
          if (onClosePressed != null) {
            onClosePressed!();
            return;
          }
          Get.back();
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48.0);
}
