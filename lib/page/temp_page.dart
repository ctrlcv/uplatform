import 'package:flutter/material.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/text_title.dart';

class BookingEducationPage extends StatefulWidget {
  const BookingEducationPage({Key? key}) : super(key: key);

  static const routeName = '/BookingEducationPage';

  @override
  _BookingEducationPageState createState() => _BookingEducationPageState();
}

class _BookingEducationPageState extends State<BookingEducationPage> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'BookingEducationPage');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(iconData: Icons.arrow_back),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 16),
                const TextTitle(
                  titleText: "음식점 위생정리 예약",
                  cellHeight: 32,
                  fontSize: 24,
                  fontColor: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 40),
                Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
