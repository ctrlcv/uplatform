import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Utils {
  String printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  void showWorkingSnackBar() {
    Get.snackbar('작업중', '작업중입니다.',
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1),
        animationDuration: const Duration(milliseconds: 200));
  }

  String getDisplayDateTime(String? date, String time) {
    if (date == null || date.isEmpty || date == "null") {
      return "";
    }

    DateTime dateTime;

    try {
      dateTime = DateFormat("yyyy-MM-dd").parse(date);
    } catch (e) {
      return "";
    }

    String dayOfWeek = DateFormat('EEEE').format(dateTime);
    List<String> times = (time.contains("~")) ? time.split("~") : time.split("-");

    switch (dayOfWeek.toUpperCase()) {
      case "SUNDAY":
        return date.replaceAll("-", ".") + "(일)" + " " + times[0].trim();

      case "MONDAY":
        return date.replaceAll("-", ".") + "(월)" + " " + times[0].trim();

      case "TUESDAY":
        return date.replaceAll("-", ".") + "(화)" + " " + times[0].trim();

      case "WEDNESDAY":
        return date.replaceAll("-", ".") + "(수)" + " " + times[0].trim();

      case "THURSDAY":
        return date.replaceAll("-", ".") + "(목)" + " " + times[0].trim();

      case "FRIDAY":
        return date.replaceAll("-", ".") + "(금)" + " " + times[0].trim();

      case "SATURDAY":
        return date.replaceAll("-", ".") + "(토)" + " " + times[0].trim();

      default:
        return date.replaceAll("-", ".") + " " + times[0].trim();
    }
  }

  String getDisplayDateTime2(String? dateTimeStr) {
    if (dateTimeStr == null) {
      return "";
    }

    // debugPrint("[1] $dateTimeStr");

    if (dateTimeStr.contains("T")) {
      dateTimeStr = formatUTCToKoreaTime(DateFormat("yyyy-MM-ddTHH:mm:ss").parse(dateTimeStr));
    }

    // debugPrint("[2] $dateTimeStr");

    List<String> dateTimes = dateTimeStr.split(" ");
    String date = dateTimes[0];

    DateTime dateTime = DateFormat("yyyy-MM-dd").parse(date);
    String dayOfWeek = DateFormat('EEEE').format(dateTime);
    List<String> times = dateTimes[1].split(":");

    int hour = int.parse(times[0]);
    String timeStr = (hour < 12)
        ? "오전 $hour시 ${times[1]}분"
        : (hour == 12)
            ? "오후 12시 ${times[1]}분"
            : "오후 ${hour - 12}시 ${times[1]}분";

    switch (dayOfWeek.toUpperCase()) {
      case "SUNDAY":
        return date.replaceAll("-", ".") + "(일)" + " " + timeStr;

      case "MONDAY":
        return date.replaceAll("-", ".") + "(월)" + " " + timeStr;

      case "TUESDAY":
        return date.replaceAll("-", ".") + "(화)" + " " + timeStr;

      case "WEDNESDAY":
        return date.replaceAll("-", ".") + "(수)" + " " + timeStr;

      case "THURSDAY":
        return date.replaceAll("-", ".") + "(목)" + " " + timeStr;

      case "FRIDAY":
        return date.replaceAll("-", ".") + "(금)" + " " + timeStr;

      case "SATURDAY":
        return date.replaceAll("-", ".") + "(토)" + " " + timeStr;

      default:
        return date.replaceAll("-", ".") + " " + timeStr;
    }
  }

  String formatUTCToKoreaTime(DateTime date) {
    DateTime resultDateTime = date.add(const Duration(hours: 9));
    return DateFormat("yyyy-MM-dd HH:mm:ss").format(resultDateTime);
  }

  String numberWithComma(int param) {
    return NumberFormat('###,###,###,###').format(param).replaceAll(' ', '');
  }

  String isCancelEnabled(String serviceDate) {
    if (serviceDate.isEmpty) {
      return "IMPOSSIBLE";
    }

    DateTime serviceDay;

    try {
      serviceDay = DateTime.parse(serviceDate);
    } catch (e) {
      return "IMPOSSIBLE";
    }

    DateTime toDay = DateTime.parse(DateTime.now().toString().substring(0,10));

    debugPrint("isCancelEnabled() serviceDay $serviceDay");
    debugPrint("isCancelEnabled() toDay $toDay");

    Duration duration = serviceDay.difference(toDay);

    debugPrint("isCancelEnabled() difference ${duration.inDays}");

    if (duration.inDays > 2) {
      return "POSSIBLE";
    }

    if (duration.inDays <= 0) {
      return "IMPOSSIBLE";
    }

    return "HALF";
  }
}
