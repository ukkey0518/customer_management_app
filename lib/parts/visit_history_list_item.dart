import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/src/inter_converter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VisitHistoryListItem extends StatelessWidget {
  VisitHistoryListItem(
      {@required this.visitHistory,
      @required this.onTap,
      @required this.onLongPress});

  final VisitHistory visitHistory;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    // 日付
    var date = visitHistory.date;
    // 顧客データ
    var customer = InterConverter.jsonToCustomer(visitHistory.customerJson);
    // 担当スタッフデータ
    var employee = InterConverter.jsonToEmployee(visitHistory.employeeJson);
    // 提供メニューリスト
    var menus = InterConverter.jsonToMenuList(visitHistory.menuListJson);
    // 提供メニュー＆カテゴリカラーMap
    var menuAndColors;
    menus.forEach((menu) {
      var category = InterConverter.jsonToMenuCategory(menu.menuCategoryJson);
      menuAndColors[menu] = Color(category.color);
    });

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
//                _datePart(date),
                Divider(),
//                _customerPart(customer),
                Divider(),
                Row(
                  children: <Widget>[
//                    _categoriesPart(menuAndColors),
//                    _pricePart(),
                  ],
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // [ウィジェット：日付欄]
  Widget _datePart(DateTime dateTime) {
//    var dateStr = DateFormat('yyyy/M/d(E)').format(dateTime);
//    return Text(dateStr);
  }

  // [ウィジェット：顧客名表示欄]
  Widget _customerPart(Customer customer) {
//    return Column(
//      children: <Widget>[
//        Text(customer.nameReading),
//        Text(customer.name),
//      ],
//    );
  }

  // [ウィジェット：カテゴリアイコン表示パート]
  Widget _categoriesPart(Map<Menu, Color> menuAndColors) {
//    var icons = categoryColors
//        .map<Icon>((color) => Icon(Icons.category, color: color))
//        .toList();
//    return Wrap(
//      direction: Axis.horizontal,
//      children: icons,
//    );
  }

  // [ウィジェット：価格表示部分]
//  Widget _pricePart(List<Menu> menus) {
//    var sumPrice = menus.map((menu) => menu.price).reduce((a, b) => a + b);
//    var priceStr = InterConverter.intToPriceString(sumPrice);
//    return Text(priceStr);
//  }
}
