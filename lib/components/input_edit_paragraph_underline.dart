import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

import 'input_title.dart';

class InputEditParagraphUnderline extends StatelessWidget {
  const InputEditParagraphUnderline({
    Key? key,
    this.editingController,
    this.focusNode,
    this.title = "",
    this.hintText = "",
    this.onChanged,
    this.validator,
    this.onSubmitted,
    this.isRequired = false,
    this.maxLength,
    this.isReadOnly = false,
    this.isObscureText = false,
    this.padding,
    this.inputType,
  }) : super(key: key);

  final TextEditingController? editingController;
  final FocusNode? focusNode;
  final String title;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onSubmitted;
  final bool isRequired;
  final bool isObscureText;
  final int? maxLength;
  final bool isReadOnly;
  final EdgeInsetsGeometry? padding;
  final TextInputType? inputType;

  final UnderlineInputBorder _inputBorder = const UnderlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFE4E7ED), width: 1.0),
  );

  @override
  Widget build(BuildContext context) {
    double screenWidth = (UniversalPlatform.isWeb) ? 800 : MediaQuery.of(context).size.width;

    return Container(
      alignment: Alignment.topLeft,
      padding: padding,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: InputTitle(
              title: title,
              isRequired: isRequired,
            ),
          ),
          Container(
            width: screenWidth,
            alignment: Alignment.centerLeft,
            child: TextFormField(
              controller: editingController,
              focusNode: focusNode,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 4, bottom: 7),
                isDense: true,
                border: _inputBorder,
                disabledBorder: _inputBorder,
                enabledBorder: _inputBorder,
                errorBorder: _inputBorder,
                focusedBorder: _inputBorder,
                focusedErrorBorder: _inputBorder,
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Color(0xFFCDD0D3),
                  fontSize: 18.0,
                  height: 1.4,
                  fontWeight: FontWeight.w400,
                ),
              ),
              maxLength: maxLength,
              minLines: 1,
              maxLines: 6,
              obscureText: isObscureText,
              onChanged: onChanged,
              validator: validator,
              onFieldSubmitted: onSubmitted,
              readOnly: isReadOnly,
              keyboardType: inputType,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: isReadOnly ? const Color(0xFF898D93) : Colors.black,
                fontSize: 18,
                height: 1.4,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
