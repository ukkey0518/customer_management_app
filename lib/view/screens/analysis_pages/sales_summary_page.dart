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
  PeriodMode _periodMode = PeriodMode.MONTH;
  DateTime _date = DateTime.now();
  bool _initFlag = true;

  @override
  void initState() {
    _vhList = widget.visitHistories;
    _date = widget.visitHistories?.getLastVisitHistory()?.date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _vhList = widget.visitHistories;
    if (_initFlag) {
      _date = widget.visitHistories?.getLastVisitHistory()?.date;
      if (_date != null) {
        _initFlag = false;
      }
    }
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
            Text('$_periodMode'),
            RaisedButton(
              child: Text('modeChange'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => PeriodSetDialog(
                    mode: _periodMode,
                    date: _date,
                    minDate: widget.visitHistories.getFirstVisitHistory().date,
                    maxDate: widget.visitHistories.getLastVisitHistory().date,
                  ),
                ).then((pair) {
                  _periodMode = pair['mode'];
                  _date = pair['date'];
                  _getByPeriod();
                });
              },
            ),
          ],
        ),
        Text('${_date?.toPeriodString(_periodMode)}'),
        Text(
            '${_vhList.map<String>((vh) => vh.date.toFormatString(DateFormatMode.MEDIUM) + '\n').toList()}'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('<-'),
              onPressed: () {
                _date = _date.decrement(_periodMode);
                _getByPeriod();
              },
            ),
            RaisedButton(
              child: Text('->'),
              onPressed: () {
                _date = _date.increment(_periodMode);
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
      _vhList = _vhList.getByPeriod(_date, _periodMode);
    });
  }
}
