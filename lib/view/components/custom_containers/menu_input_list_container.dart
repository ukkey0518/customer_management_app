import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/convert_from_menu_list.dart';
import 'package:customermanagementapp/util/extensions/convert_from_string.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/dividers/my_divider.dart';
import 'package:flutter/material.dart';

class MenuInputListContainer extends StatelessWidget {
  MenuInputListContainer({
    this.screenAbsorbing,
    this.onTap,
    this.menus,
  });

  final bool screenAbsorbing;
  final VoidCallback onTap;
  final List<Menu> menus;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: screenAbsorbing ? null : onTap,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('合計：', style: TextStyle(fontSize: 16)),
                  Text(
                    menus.toSumPrice().toPriceString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            MyDivider(indent: 8),
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: menus.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.import_contacts,
                            color: Color(
                              menus[index]
                                  .menuCategoryJson
                                  .toMenuCategory()
                                  .color,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              menus[index].name,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Text(
                            menus[index].price.toPriceString(),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
