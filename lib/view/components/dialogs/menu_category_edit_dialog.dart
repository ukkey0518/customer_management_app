import 'package:customermanagementapp/data/input_field_style.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions.dart';
import 'package:customermanagementapp/view/components/color_select_button.dart';
import 'package:customermanagementapp/view/components/dialogs/dialog_title_text.dart';
import 'package:customermanagementapp/view/components/input_form_widgets/input_field.dart';
import 'package:flutter/material.dart';

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
          title: DialogTitleText(title),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('カテゴリ名：', textAlign: TextAlign.left),
                InputField(
                  controller: categoryController,
                  errorText: errorText,
                  hintText: 'カテゴリ名を入力',
                  style: InputFieldStyle.UNDER_LINE,
                  isClearable: true,
                ),
                SizedBox(height: 24),
                Text('カテゴリカラー：', textAlign: TextAlign.left),
                ColorSelectButton(
                  color: currentColor,
                  onColorConfirm: (color) {
                    setState(() {
                      currentColor = color;
                    });
                  },
                ),
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
