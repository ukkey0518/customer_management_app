import 'package:customermanagementapp/db/database.dart';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class MenuEditDialog extends StatelessWidget {
  MenuEditDialog({this.category, this.menu});
  final MenuCategory category;
  final Menu menu;

  @override
  Widget build(BuildContext context) {
    var titleText;
    var nameController = TextEditingController();
    var priceController = TextEditingController();

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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: TextField(
                    controller: TextEditingController(text: category.name),
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.category,
                        color: Color(category.color),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text('メニュー名：'),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: TextField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'メニュー名を入力',
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () =>
                            WidgetsBinding.instance.addPostFrameCallback(
                          (_) => nameController.clear(),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text('価格：'),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '価格を入力',
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () =>
                            WidgetsBinding.instance.addPostFrameCallback(
                          (_) => priceController.clear(),
                        ),
                      ),
                    ),
                  ),
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
                if (nameController.text.isEmpty ||
                    priceController.text.isEmpty) {
                  Toast.show('未入力項目があります', context);
                  return;
                }

                // 数値チェック
                try {
                  int.parse(priceController.text);
                } on FormatException catch (e) {
                  Toast.show('価格は数字のみ入力可能です。', context);
                  print(e);
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
