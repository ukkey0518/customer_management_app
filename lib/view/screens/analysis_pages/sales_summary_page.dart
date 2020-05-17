import 'package:customermanagementapp/data/data_classes/period.dart';
import 'package:customermanagementapp/data/enums/date_format_mode.dart';
import 'package:customermanagementapp/data/enums/period_select_mode.dart';
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
  PeriodSelectMode _selectMode = PeriodSelectMode.MONTH;
  Period _period = Period(date: DateTime.now());

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
                      PeriodSetDialog(period: _period, mode: _selectMode),
                ).then((pair) {
                  _selectMode = pair['mode'];
                  _setPeriod(pair['period']);
                });
              },
            ),
          ],
        ),
        Text('$_period'),
        Text(
            '${_vhList.map<String>((vh) => vh.date.toFormatString(DateFormatMode.MEDIUM) + '\n').toList()}'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('<-'),
              onPressed: () {
                _period.decrement(_selectMode);
                _getByPeriod();
              },
            ),
            RaisedButton(
              child: Text('->'),
              onPressed: () {
                _period.increment(_selectMode);
                _getByPeriod();
              },
            ),
          ],
        ),
      ],
    );
  }

  _setPeriod(Period period) {
    _period = period;
    _getByPeriod();
  }

  _getByPeriod() {
    setState(() {
      _vhList = _vhList.getByPeriod(_period, _selectMode);
    });
  }
}
