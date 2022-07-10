import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:uplatform/constants/constants.dart';

import 'border_rounded_button.dart';
import 'check_box.dart';

class BottomSheetPanel extends StatefulWidget {
  const BottomSheetPanel({
    Key? key,
    this.items,
    this.isMultiSelect = false,
    this.selectedItem = "",
  }) : super(key: key);

  final List<String>? items;
  final bool isMultiSelect;
  final String selectedItem;

  @override
  _BottomSheetPanelState createState() => _BottomSheetPanelState();
}

class _BottomSheetPanelState extends State<BottomSheetPanel> {
  String _selectedItem = "";

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem.isNotEmpty ? widget.selectedItem : "";
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 32,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                padding: const EdgeInsets.only(top: 12),
                alignment: Alignment.topCenter,
                child: Container(
                  height: 4,
                  width: 40,
                  color: const Color(0xFFE4E7ED),
                ),
              ),
              Container(
                color: Colors.white,
                constraints: const BoxConstraints(minHeight: 100, maxHeight: 620),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: widget.items!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        if (!widget.isMultiSelect) {
                          _selectedItem = widget.items![index];
                          Navigator.of(context).pop(_selectedItem);
                        } else {
                          if (_selectedItem.contains(widget.items![index])) {
                            _selectedItem = _selectedItem.replaceAll(widget.items![index], "").replaceAll("；；", "；");
                          } else {
                            _selectedItem = _selectedItem + "；" + widget.items![index];
                            _selectedItem = _selectedItem.replaceAll("；；", ",");
                          }

                          if (mounted) {
                            setState(() {});
                          }
                        }
                      },
                      child: Container(
                        height: 46,
                        alignment: Alignment.center,
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                color: Colors.transparent,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.items![index],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            if (_selectedItem.contains(widget.items![index]))
                              Container(
                                color: Colors.transparent,
                                alignment: Alignment.center,
                                child: const CheckBox(isSelected: true),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (widget.isMultiSelect)
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BorderRoundedButton(
                    text: "선택 완료",
                    buttonColor: kMainColor,
                    buttonHeight: 50,
                    onPressed: () {
                      Navigator.of(context).pop(_selectedItem);
                    },
                  ),
                ),
              Container(
                height: UniversalPlatform.isIOS ? 48 : 32,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
