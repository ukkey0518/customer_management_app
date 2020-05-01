import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../color_picker_dialog.dart';

class MenuCategoryEditDialog extends StatelessWidget {
  MenuCategoryEditDialog({this.category});
  final MenuCategory category;

  @override
  Widget build(BuildContext context) {
    var title;
    Color currentColor;
    var categoryController = TextEditingController();
    var positiveButtonText;

    var errorText;

    if (category == null) {
      title = 'カテゴリの追加';
      currentColor = Colors.white;
      categoryController.text = '';
      positiveButtonText = '追加';
    } else {
      title = 'カテゴリの編集';
      currentColor = Color(category.color);
      categoryController.text = category.name;
      positiveButtonText = '更新';
    }

    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: Text('カテゴリ名：', textAlign: TextAlign.left),
                ),
                TextField(
                  controller: categoryController,
                  decoration: InputDecoration(
                    hintText: 'カテゴリ名を入力',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () =>
                          WidgetsBinding.instance.addPostFrameCallback(
                        (_) => categoryController.clear(),
                      ),
                    ),
                    errorText: errorText,
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text('カテゴリカラー：', textAlign: TextAlign.left),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                      color: currentColor,
                    ),
                    child: FlatButton(
                      child: Text('タップしてカラーを選択'),
                      textColor: useWhiteForeground(currentColor)
                          ? const Color(0xffffffff)
                          : const Color(0xff000000),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (_) {
                          return ColorPickerDialog(currentColor);
                        },
                      ).then(
                        (newColor) {
                          setState(() => currentColor = newColor);
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('キャンセル'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text(positiveButtonText),
              onPressed: () {
                // 未入力チェック
                if (categoryController.text.isEmpty) {
                  setState(() => errorText = 'カテゴリ名が未入力です');
                  return;
                } else {
                  setState(() => errorText = null);
                }
                var newCategory = MenuCategory(
                  id: category?.id,
                  name: categoryController.text,
                  color: currentColor.getColorNumber(),
                );
                Navigator.of(context).pop(newCategory);
              },
            ),
          ],
        );
      },
    );
  }
}
