import 'package:customermanagementapp/data/data_classes/period.dart';
import 'package:customermanagementapp/data/enums/date_format_mode.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:flutter/material.dart';

class SalesSummaryPage extends StatefulWidget {
  SalesSummaryPage({@required this.visitHistories});

  final List<VisitHistory> visitHistories;

  @override
  _SalesSummaryPageState createState() => _SalesSummaryPageState();
}

class _SalesSummaryPageState extends State<SalesSummaryPage> {
  List<VisitHistory> _vhList = List();
  Period _period = Period();

  @override
  Widget build(BuildContext context) {
    _vhList = widget.visitHistories;
    _getByPeriod();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          '売上集計ページ',
          style: TextStyle(fontSize: 20),
        ),
        Text('$_period'),
        Text(
            '${_vhList.map<String>((vh) => vh.date.toFormatString(DateFormatMode.MEDIUM) + '\n').toList()}'),
        RaisedButton(
          child: Text('asd'),
          onPressed: () {
            _getByPeriod();
          },
        ),
      ],
    );
  }

  _getByPeriod() {
    setState(() {
      _vhList = _vhList
          .getByYear(_period.year)
          .getByMonth(_period.month)
          .getByDay(_period.day)
          .toList();
    });
  }
}
