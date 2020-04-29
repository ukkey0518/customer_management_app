import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/inter_converter.dart';
import 'package:customermanagementapp/styles.dart';
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
                style: Styles.nameReadingStyle,
              ),
              Text(
                '${customer.name} 様',
                style: Styles.nameStyle,
              ),
            ],
          ),
        ),
        Text('${InterConverter.getAgeFromBirthDay(customer.birth) ?? '?'} 歳'),
      ],
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
