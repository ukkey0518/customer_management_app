import 'package:customermanagementapp/data/input_field_style.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/input_widgets/text_input_field.dart';

import 'package:flutter/material.dart';

class MenuEditDialog extends StatelessWidget {
  MenuEditDialog({this.category, this.menu});
  final MenuCategory category;
  final Menu menu;

  @override
  Widget build(BuildContext context) {
    var titleText;
    var nameController = TextEditingController();
    var priceController = TextEditingController();

    var nameErrorText;
    var priceErrorText;

    if (menu == null) {
      titleText = 'メニューの追加';
      nameController.text = '';
      priceController.text = '';
    } else {
      titleText = 'メニューの編集';
      nameController.text = menu.name;
      priceController.text = menu.price.toString();
    }

    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text(titleText),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('カテゴリ：'),
                AbsorbPointer(
                  absorbing: true,
                  child: TextInputField(
                    controller: TextEditingController(text: category.name),
                    style: InputFieldStyle.ROUNDED_RECTANGLE,
                    errorText: null,
                  ),
                ),
                SizedBox(height: 30),
                Text('メニュー名：'),
                TextInputField(
                  controller: nameController,
                  errorText: nameErrorText,
                  style: InputFieldStyle.ROUNDED_RECTANGLE,
                  hintText: 'メニュー名を入力',
                  isClearable: true,
                ),
                SizedBox(height: 30),
                Text('価格：'),
                TextInputField(
                  controller: priceController,
                  errorText: priceErrorText,
                  style: InputFieldStyle.ROUNDED_RECTANGLE,
                  hintText: '価格を入力',
                  isClearable: true,
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
              child: const Text('追加'),
              onPressed: () {
                // 未入力チェック
                nameErrorText = nameController.text.isEmpty ? '必須入力です' : null;
                priceErrorText = priceController.text.isEmpty ? '必須入力です' : null;

                // 数値チェック
                try {
                  int.parse(priceController.text);
                  priceErrorText = priceErrorText;
                } on FormatException catch (_) {
                  priceErrorText = '価格は数字のみ入力可能です';
                }

                setState(() {});

                if (nameErrorText != null || priceErrorText != null) {
                  return;
                }

                var newMenu = Menu(
                  id: menu?.id,
                  menuCategoryJson: category.toJsonString(),
                  name: nameController.text,
                  price: int.parse(priceController.text),
                );

                Navigator.of(context).pop(newMenu);
              },
            ),
          ],
        );
      },
    );
  }
}
