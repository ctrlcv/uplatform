import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

const Color kMainColor = Color(0xFFFFC113);
const Color kSelectColor = Color(0xFF686C73);
const Color kBlueColor = Color(0xFF10A2DC);

const bool kDebugMode = true;

const int kListLoadCount = 10;

Widget buildBottomBar = SizedBox(height: UniversalPlatform.isIOS ? 32 : 0);

Widget kHorizontalLine = Container(
  height: 1,
  margin: const EdgeInsets.symmetric(horizontal: 20),
  color: const Color(0xFFF5F6F8),
);

Widget kHorizontalLineNoMargin = Container(
  height: 1,
  color: const Color(0xFFF5F6F8),
);
