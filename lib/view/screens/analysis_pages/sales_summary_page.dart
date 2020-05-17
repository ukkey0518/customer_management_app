import 'package:customermanagementapp/data/enums/date_format_mode.dart';
import 'package:customermanagementapp/data/enums/periodMode.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/dialogs/period_set_dialog.dart';
import 'package:flutter/material.dart';

class SalesSummaryPage extends StatefulWidget {
  SalesSummaryPage({@required this.visitHistories});

  final List<VisitHistory> visitHistories;

  @override
  _SalesSummaryPageState createState() => _SalesSummaryPageState();
}

class _SalesSummaryPageState extends State<SalesSummaryPage> {
  List<VisitHistory> _vhList = List();
  PeriodMode _selectMode = PeriodMode.MONTH;
  DateTime _date = DateTime.now();

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
        Column(
          children: <Widget>[
            Text('$_selectMode'),
            RaisedButton(
              child: Text('modeChange'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) =>
                      PeriodSetDialog(date: _date, mode: _selectMode),
                ).then((pair) {
                  _selectMode = pair['mode'];
                  _date = pair['date'];
                  _getByPeriod();
                });
              },
            ),
          ],
        ),
        Text('$_date'),
        Text(
            '${_vhList.map<String>((vh) => vh.date.toFormatString(DateFormatMode.MEDIUM) + '\n').toList()}'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('<-'),
              onPressed: () {
                _date = _date.decrement(_selectMode);
                _getByPeriod();
              },
            ),
            RaisedButton(
              child: Text('->'),
              onPressed: () {
                _date = _date.increment(_selectMode);
                _getByPeriod();
              },
            ),
          ],
        ),
      ],
    );
  }

  _getByPeriod() {
    setState(() {
      _vhList = _vhList.getByPeriod(_date, _selectMode);
    });
  }
}
