import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/src/inter_converter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VisitHistoryListItem extends StatelessWidget {
  VisitHistoryListItem(
      {@required this.date,
      @required this.customer,
      @required this.employee,
      @required this.categoryColors,
      @required this.menus,
      @required this.onTap,
      @required this.onLongPress});

  final DateTime date;
  final Customer customer;
  final Employee employee;
  final List<Color> categoryColors;
  final List<Menu> menus;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;

  @override
  Widget build(BuildContext context) {
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
                _datePart(date),
                Divider(),
                _customerPart(customer),
                Divider(),
                Row(
                  children: <Widget>[
                    _categoriesPart(),
                    _pricePart(menus),
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
    var dateStr = DateFormat('yyyy/M/d(E)').format(dateTime);
    return Text(dateStr);
  }

  // [ウィジェット：顧客名表示欄]
  Widget _customerPart(Customer customer) {
    return Column(
      children: <Widget>[
        Text(customer.nameReading),
        Text(customer.name),
      ],
    );
  }

  // [ウィジェット：カテゴリアイコン表示パート]
  Widget _categoriesPart() {
    var icons = categoryColors
        .map<Icon>((color) => Icon(Icons.category, color: color))
        .toList();
    return Wrap(
      direction: Axis.horizontal,
      children: icons,
    );
  }

  // [ウィジェット：価格表示部分]
  Widget _pricePart(List<Menu> menus) {
    var sumPrice = menus.map((menu) => menu.price).reduce((a, b) => a + b);
    var priceStr = InterConverter.intToPriceString(sumPrice);
    return Text(priceStr);
  }
}
