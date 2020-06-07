import 'package:customermanagementapp/data/enums/date_format_mode.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/convert_from_string.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/util/styles.dart';
import 'package:customermanagementapp/view/components/custom_cards/list_view_card.dart';
import 'package:flutter/material.dart';

class VisitHistoryListCard extends ListViewCard<VisitHistory> {
  VisitHistoryListCard({
    @required VisitHistory visitHistory,
    @required ValueChanged onTap,
    @required ValueChanged onLongPress,
  }) : super(item: visitHistory, onTap: onTap, onLongPress: onLongPress);

  @override
  Widget build(BuildContext context) {
    // 日付
    var date = item.date;
    // 顧客データ
    var customer = item.customerJson.toCustomer();
    // 担当スタッフデータ
    var employee = item.employeeJson.toEmployee();
    // 提供メニューリスト
    var menus = item.menuListJson.toMenuList();
    // カテゴリカラーリスト(重複を排除したもの)
    var categoryColors = menus
        .map<Color>((menu) {
          var category = menu.menuCategoryJson.toMenuCategory();
          return Color(category.color);
        })
        .toSet()
        .toList();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
                spreadRadius: -5,
                offset: Offset(5, 5),
              ),
            ],
          ),
          child: Card(
            child: InkWell(
              onTap: () => onTap(null),
              onLongPress: () => onLongPress(null),
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        _datePart(context, date),
                        _employeePart(employee),
                      ],
                    ),
                    SizedBox(height: 16),
                    _customerPart(customer),
                    Divider(),
                    _menuPart(categoryColors, menus),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // [ウィジェット：日付欄]
  Widget _datePart(BuildContext context, DateTime dateTime) {
    var dateStr = dateTime.toFormatStr(DateFormatMode.FULL);
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          )),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Text(
        dateStr,
        style: TextStyle(
          color: Theme.of(context).primaryColorDark,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // [ウィジェット：担当者表示欄]
  Widget _employeePart(Employee employee) {
    return Expanded(
      child: Text(
        '担当: ${employee.name}',
        textAlign: TextAlign.end,
      ),
    );
  }

  // [ウィジェット：顧客名表示欄]
  Widget _customerPart(Customer customer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.account_circle,
              color: customer.isGenderFemale
                  ? Styles.femaleIconColor
                  : Styles.maleIconColor,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                customer.nameReading,
                style: Styles.nameReadingStyle,
              ),
              Text(
                '${customer.name} 様',
                style: Styles.nameStyle,
              ),
            ],
          ),
          Expanded(
              child: Text(
            '${customer.birth.toAge() ?? '?'} 歳',
            textAlign: TextAlign.end,
          )),
        ],
      ),
    );
  }

  // [ウィジェット：カテゴリアイコン表示パート]
  Widget _menuPart(List<Color> categoryColors, List<Menu> menus) {
    var icons = categoryColors
        .map<Icon>((color) => Icon(Icons.category, color: color))
        .toList();
    var sumPrice = menus.map((menu) => menu.price).reduce((a, b) => a + b);
    var priceStr = sumPrice.toPriceString();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Wrap(
              direction: Axis.horizontal,
              children: icons,
            ),
          ),
          Expanded(
              flex: 6,
              child: Text(
                priceStr,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.end,
              )),
        ],
      ),
    );
  }
}
