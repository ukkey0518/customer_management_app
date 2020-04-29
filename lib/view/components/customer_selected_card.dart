import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/src/inter_converter.dart';
import 'package:customermanagementapp/styles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class CustomerSelectedCard extends StatelessWidget {
  CustomerSelectedCard({this.customer, this.onTap, this.onLongPress});

  final Customer customer;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xeeeeeeee),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: customer == null ? _emptyPart() : _mainPart(),
        ),
      ),
    );
  }

  // [ウィジェット：customerに渡された情報を表示]
  Widget _mainPart() {
    return Container(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: _getGenderIcon(),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${customer.nameReading}',
                  style: Styles.nameReadingStyle,
                ),
                Text(
                  '${customer.name} 様',
                  style: Styles.nameStyle,
                ),
              ],
            ),
          ),
          Text('${InterConverter.getAgeFromBirthDay(customer.birth) ?? '?'}歳'),
        ],
      ),
    );
  }

  // [ウィジェット：アイコン生成]
  // →性別でアイコンカラーが変わる
  Widget _getGenderIcon() {
    var iconColor =
        customer.isGenderFemale ? Styles.femaleIconColor : Styles.maleIconColor;
    return Icon(
      Icons.account_circle,
      color: iconColor,
    );
  }

  // [ウィジェット：customerにnullが渡されたときの本体]
  Widget _emptyPart() {
    return SizedBox(
      width: double.infinity,
      child: DottedBorder(
        borderType: BorderType.RRect,
        color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '+タップして顧客を選択',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
