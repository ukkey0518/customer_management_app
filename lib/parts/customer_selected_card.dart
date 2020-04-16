import 'package:customermanagementapp/db/database.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class CustomerSelectedCard extends StatelessWidget {
  CustomerSelectedCard({this.customer, this.onTap, this.onLongPress});

  final Customer customer;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        color: Color(0xeeeeeeee),
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: customer == null ? _emptyPart() : _mainPart(),
          ),
        ),
      ),
    );
  }

  // [ウィジェット：customerに渡された情報を表示]
  Widget _mainPart() {
    var diffDays = customer.birth == null
        ? -1
        : DateTime.now().difference(customer.birth).inDays;
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
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  '${customer.name} 様',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Text('${diffDays < 0 ? '(誕生日未登録)' : '${(diffDays / 365).floor()}歳'}'),
        ],
      ),
    );
  }

  // [ウィジェット：アイコン生成]
  // →性別でアイコンカラーが変わる
  Widget _getGenderIcon() {
    var iconColor =
        customer.isGenderFemale ? Colors.pinkAccent : Colors.blueAccent;
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
