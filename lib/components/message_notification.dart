import 'dart:async';

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class MessageNotification extends StatefulWidget {
  const MessageNotification({Key? key, required this.message, required this.onPress}) : super(key: key);

  final String message;
  final GestureTapCallback onPress;

  @override
  _MessageNotificationState createState() => _MessageNotificationState();
}

class _MessageNotificationState extends State<MessageNotification> {
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() async {
    var duration = const Duration(milliseconds: 5000);
    return Timer(duration, finishTimer);
  }

  void finishTimer() {
    OverlaySupportEntry.of(context)!.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    double width = 420;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
      child: SafeArea(
        child: Container(
          color: const Color(0xFFF1F2F4),
          padding: const EdgeInsets.symmetric(vertical: 2),
          width: width,
          child: GestureDetector(
            onTap: widget.onPress,
            child: ListTile(
              leading: SizedBox.fromSize(
                size: const Size(40, 40),
                child: const Icon(
                  Icons.notifications_none_outlined,
                ),
              ),
              title: const Text(
                "알림",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(widget.message),
            ),
          ),
        ),
      ),
    );
  }
}
