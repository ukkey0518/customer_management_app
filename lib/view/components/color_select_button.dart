import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'dialogs/color_picker_dialog.dart';

class ColorSelectButton extends StatelessWidget {
  ColorSelectButton({
    @required this.color,
    @required this.onColorConfirm,
  });

  final Color color;
  final ValueChanged<Color> onColorConfirm;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        child: FlatButton(
          child: Text('タップしてカラーを選択'),
          textColor: useWhiteForeground(color)
              ? const Color(0xffffffff)
              : const Color(0xff000000),
          onPressed: () => showDialog(
            context: context,
            builder: (_) {
              return ColorPickerDialog(color);
            },
          ).then((color) => onColorConfirm(color)),
        ),
      ),
    );
  }
}
