import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:flutter/material.dart';

class SelectedMenuHeader extends StatelessWidget {
  SelectedMenuHeader({
    @required this.selectedMenus,
  });

  final List<Menu> selectedMenus;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          '選択中：${selectedMenus.length}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          selectedMenus.isEmpty
              ? '0'
              : '合計：${selectedMenus.reduce(
                    (a, b) => Menu(
                        id: null,
                        name: null,
                        price: a.price + b.price,
                        menuCategoryJson: null),
                  ).price.toPriceString()}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
