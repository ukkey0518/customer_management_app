import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerDialog extends StatelessWidget {
  ColorPickerDialog(this.currentColor);

  final Color currentColor;

  @override
  Widget build(BuildContext context) {
    var changedColor = currentColor;
    return AlertDialog(
      title: const Text('カラーを選択してください'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: currentColor,
          onColorChanged: (color) => changedColor = color,
          colorPickerWidth: 300,
          pickerAreaHeightPercent: 0.7,
          enableAlpha: true,
          displayThumbColor: true,
          showLabel: true,
          paletteType: PaletteType.hsv,
          pickerAreaBorderRadius: const BorderRadius.only(
            topLeft: const Radius.circular(2.0),
            topRight: const Radius.circular(2.0),
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text('キャンセル'),
          onPressed: () => Navigator.of(context).pop(currentColor),
        ),
        FlatButton(
          child: const Text('決定'),
          onPressed: () => Navigator.of(context).pop(changedColor),
        ),
      ],
    );
  }
}

// [変換関数：Colorから色番号をintで抽出するメソッド]
int getColorNumber(Color color) {
  var colorStr = color.toString();
  var numStr = colorStr.substring(6, colorStr.length - 1);
  return int.parse(numStr);
}
