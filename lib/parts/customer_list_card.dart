import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerListCard extends StatelessWidget {
  CustomerListCard({this.customer, this.onTap, this.onLongPress});

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
            child: Column(
              children: <Widget>[
                _basicInformationPart(),
                Divider(),
                _visitInformationPart(),
              ],
            ),
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

  // [ウィジェット：来店情報表示部分]
  Widget _visitInformationPart() {
    return Table(
      children: <TableRow>[
        TableRow(
          children: <Column>[
            _tableItem(
              titleText: '来店回数',
              contentText: '1', //TODO リストアイテム：来店回数
            ),
            _tableItem(
              titleText: '最終来店日',
              contentText:
                  '${DateFormat('yyyy/M/d').format(DateTime.now())}', //TODO リストアイテム：最終来店日
            ),
            _tableItem(
              titleText: '担当',
              contentText: 'うーっき', //TODO リストアイテム：担当
            ),
          ],
        ),
      ],
    );
  }

  // [ウィジェット：来店情報テーブルリストアイテムのビルダー]
  Widget _tableItem({@required String titleText, @required contentText}) {
    var titleStyle = TextStyle(fontSize: 12);
    var contentStyle = TextStyle(fontSize: 14);
    return Column(
      children: <Widget>[
        Text(titleText, style: titleStyle),
        SizedBox(height: 4),
        Text(
          contentText,
          style: contentStyle,
        ),
      ],
    );
  }
}
