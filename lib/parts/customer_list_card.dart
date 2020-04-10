import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';

class CustomerListCard extends StatelessWidget {
  CustomerListCard({this.customer, this.onTap, this.onLongPress});

  final Customer customer;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              _basicInformationPart(),
              Divider(),
              _visitInformationPart(),
            ],
          ),
        ),
      ),
    );
  }

  // [ウィジェット：基本情報表示部分]
  Widget _basicInformationPart() {
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
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
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

  // [ウィジェット：来店情報表示部分]
  Widget _visitInformationPart() {
    return Table(
      children: <TableRow>[
        TableRow(
          children: <Column>[
            Column(
              children: <Widget>[
                Text('来店回数'),
                Text('aaa'),
              ],
            ),
            Column(
              children: <Widget>[
                Text('最終来店日'),
                Text('aaa'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
