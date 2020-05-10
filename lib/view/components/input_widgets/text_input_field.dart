import 'package:customermanagementapp/data/input_field_style.dart';
import 'package:customermanagementapp/view/components/polymorphism/input_widget.dart';
import 'package:flutter/material.dart';

class TextInputField extends InputWidget {
  TextInputField(
      {@required this.controller,
      @required this.errorText,
      this.inputType = TextInputType.text,
      this.hintText = '',
      this.isClearable = false,
      this.style = InputFieldStyle.UNDER_LINE,
      this.prefixIcon});

  final TextEditingController controller;
  final TextInputType inputType;
  final String errorText;
  final String hintText;
  final bool isClearable;
  final InputFieldStyle style;
  final Icon prefixIcon;

  @override
  Widget build(BuildContext context) {
    var suffixIcon;
    var inputBorder;
    var errorBorder;

    if (isClearable) {
      suffixIcon = IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => controller.clear(),
          );
        },
      );
    }

    switch (style) {
      case InputFieldStyle.UNDER_LINE:
        inputBorder = UnderlineInputBorder();
        errorBorder = UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        );
        break;
      case InputFieldStyle.ROUNDED_RECTANGLE:
        inputBorder = OutlineInputBorder();
        errorBorder = OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        );
        break;
    }

    return TextField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        prefixIcon: prefixIcon,
        border: inputBorder,
        hintText: hintText,
        errorText: errorText,
        errorBorder: errorBorder,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
