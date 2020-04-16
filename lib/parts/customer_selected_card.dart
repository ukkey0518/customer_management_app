import 'package:customermanagementapp/db/database.dart';
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
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: _basicInformationPart(),
          ),
        ),
      ),
    );
  }

  // [ウィジェット：基本情報表示部分]
  Widget _basicInformationPart() {
    var diffDays = customer.birth == null
        ? -1
        : DateTime.now().difference(customer.birth).inDays;
    return Row(
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
}
