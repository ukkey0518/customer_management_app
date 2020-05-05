import 'package:customermanagementapp/data/input_field_style.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions.dart';
import 'package:customermanagementapp/view/components/color_select_button.dart';
import 'package:customermanagementapp/view/components/dialogs/dialog_title_text.dart';
import 'package:customermanagementapp/view/components/input_widgets/text_input_field.dart';
import 'package:flutter/material.dart';

class MenuCategoryEditDialog extends StatelessWidget {
  const MenuCategoryEditDialog({this.category});
  final MenuCategory category;

  @override
  Widget build(BuildContext context) {
    var title;
    Color currentColor;
    var controller = TextEditingController();
    var positiveButtonText;

    var errorText;

    if (category == null) {
      title = 'カテゴリの追加';
      currentColor = Colors.white;
      controller.text = '';
      positiveButtonText = '追加';
    } else {
      title = 'カテゴリの編集';
      currentColor = Color(category.color);
      controller.text = category.name;
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
                const Text('カテゴリ名：', textAlign: TextAlign.left),
                TextInputField(
                  controller: controller,
                  errorText: errorText,
                  hintText: 'カテゴリ名を入力',
                  style: InputFieldStyle.UNDER_LINE,
                  isClearable: true,
                ),
                const SizedBox(height: 24),
                const Text('カテゴリカラー：', textAlign: TextAlign.left),
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
              child: const Text('キャンセル'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text(positiveButtonText),
              onPressed: () {
                // 未入力チェック
                errorText = controller.text.isEmpty ? 'カテゴリ名が未入力です' : null;
                setState(() {});
                if (errorText != null) return;

                var newCategory = MenuCategory(
                  id: category?.id,
                  name: controller.text,
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
