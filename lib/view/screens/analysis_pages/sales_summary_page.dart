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
  int _year;
  int _month = 0;
  int _day;

  @override
  Widget build(BuildContext context) {
    _vhList = widget.visitHistories;
    _getByPeriod();

    //TODO UI実装
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              '売上集計ページ',
              style: TextStyle(fontSize: 20),
            ),
            Text(
                '${_vhList.map<String>((vh) => vh.date.toFormatString(DateFormatMode.MEDIUM)).toList()}'),
            RaisedButton(
              child: Text('asd'),
              onPressed: () {
                _month++;
                _getByPeriod();
              },
            ),
          ],
        ),
      ),
    );
  }

  _getByPeriod() {
    setState(() {
      _vhList =
          _vhList.getByYear(_year).getByMonth(_month).getByDay(_day).toList();
    });
  }
}
