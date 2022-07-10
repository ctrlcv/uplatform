import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universal_platform/universal_platform.dart';

import 'bottom_sheet_panel.dart';

class InputBottomSheet extends StatefulWidget {
  const InputBottomSheet({
    Key? key,
    this.title = "",
    this.hintText = "선택하세요.",
    this.isRequired = false,
    this.padding,
    this.onChanged,
    required this.items,
    this.selectedItem = "",
    this.isMultiSelect = false,
  }) : super(key: key);

  final String title;
  final String hintText;
  final bool isRequired;
  final EdgeInsetsGeometry? padding;
  final ValueChanged<String>? onChanged;
  final List<String> items;
  final String selectedItem;
  final bool isMultiSelect;

  @override
  State<InputBottomSheet> createState() => _InputBottomSheetState();
}

class _InputBottomSheetState extends State<InputBottomSheet> {
  String _selectedItem = "";

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem.isNotEmpty ? widget.selectedItem : "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 18,
          alignment: Alignment.centerLeft,
          padding: widget.padding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  const SizedBox(height: 1),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1.0,
                          color: Color(0xFF686C73),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (widget.isRequired)
                Column(
                  children: [
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF10000),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    const SizedBox(height: 14),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            FocusScopeNode currentFocus = FocusScope.of(context);
            currentFocus.unfocus();

            var result = await showMaterialModalBottomSheet(
              expand: false,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => BottomSheetPanel(
                items: widget.items,
                isMultiSelect: widget.isMultiSelect,
                selectedItem: widget.selectedItem,
              ),
            );

            if (result != null) {
              _selectedItem = result;
              if (_selectedItem.isNotEmpty) {
                widget.onChanged!(_selectedItem);
              }
            }
          },
          child: Container(
            height: 24,
            color: Colors.transparent,
            alignment: Alignment.center,
            padding: widget.padding,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      (widget.isMultiSelect)
                          ? widget.hintText
                          : widget.selectedItem.isNotEmpty
                              ? widget.selectedItem
                              : widget.hintText,
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.2,
                        color: widget.selectedItem.isNotEmpty ? Colors.black : const Color(0xFF686C73),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF898D93),
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 1,
          width: double.infinity,
          margin: widget.padding,
          color: const Color(0xFFE4E7ED),
        ),
        buildMultiSelectedItem(),
      ],
    );
  }

  Widget buildMultiSelectedItem() {
    if (!widget.isMultiSelect || _selectedItem.isEmpty) {
      return Container();
    }

    List<String> selectedItems = _selectedItem.split("；");
    List<Widget> selectedWrapItems = [];

    for (int i = 0; i < selectedItems.length; i++) {
      if (selectedItems[i].isEmpty) {
        continue;
      }

      selectedWrapItems.add(buildWrapItem(selectedItems[i]));
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Wrap(
            spacing: 4,
            children: selectedWrapItems,
          ),
        ],
      ),
    );
  }

  Widget buildWrapItem(String item) {
    double screenWidth = (UniversalPlatform.isWeb) ? 800 : MediaQuery.of(context).size.width;

    return Container(
      height: 34,
      constraints: BoxConstraints(maxWidth: screenWidth - 30),
      decoration: BoxDecoration(
        color: const Color(0xFFF4FAFF),
        border: Border.all(
          color: const Color(0xFFEEF5FB),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.only(left: 16, right: 10),
      margin: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: screenWidth - 100),
            child: Text(
              item,
              maxLines: 1,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              _selectedItem = _selectedItem.replaceAll(item, "").replaceAll("；；", "；");
              widget.onChanged!(_selectedItem);

              if (mounted) {
                setState(() {});
              }
            },
            child: const Icon(
              Icons.close,
              color: Color(0xFF898D93),
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
