import 'package:customermanagementapp/util/abstract_classes.dart';
import 'package:flutter/material.dart';

class InputField extends InputWidget {
  InputField({
    @required this.controller,
    @required this.inputType,
    @required this.errorText,
    this.hintText = '',
  });

  final TextEditingController controller;
  final TextInputType inputType;
  final String errorText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: TextField(
            controller: controller,
            keyboardType: inputType,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: hintText,
              errorText: errorText,
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
