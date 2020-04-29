import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/src/inter_converter.dart';
import 'package:customermanagementapp/styles.dart';
import 'package:flutter/material.dart';

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
    // カテゴリカラーリスト(重複を排除したもの)
    var categoryColors = menus
        .map<Color>((menu) {
          var category =
              InterConverter.jsonToMenuCategory(menu.menuCategoryJson);
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
              onTap: onTap,
              onLongPress: onLongPress,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        _datePart(date),
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
  Widget _datePart(DateTime dateTime) {
    var dateStr = InterConverter.dateObjToStr(dateTime);
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          )),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Text(
        dateStr,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
            '${InterConverter.getAgeFromBirthDay(customer.birth) ?? '?'} 歳',
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
    var priceStr = InterConverter.intToPriceString(sumPrice);

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
