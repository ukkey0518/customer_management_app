import 'package:customermanagementapp/data/enums/date_format_mode.dart';
import 'package:customermanagementapp/data/enums/periodMode.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/dialogs/period_set_dialog.dart';
import 'package:customermanagementapp/view/components/indicators/period_mode_indicator.dart';
import 'package:customermanagementapp/view/components/my_divider.dart';
import 'package:customermanagementapp/view/components/period_select_tile.dart';
import 'package:customermanagementapp/view/components/sales_summary_page_widgets/ssp_summary_part.dart';
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
  DateTime _minDate;
  DateTime _maxDate;
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
      _maxDate = widget.visitHistories?.getLastVisitHistory()?.date;
      _minDate = widget.visitHistories?.getFirstVisitHistory()?.date;
      if (_date != null && _maxDate != null && _minDate != null) {
        _initFlag = false;
      }
    }
    _getByPeriod();

    var backText;
    var forwardText;
    switch (_periodMode) {
      case PeriodMode.YEAR:
        backText = '前年';
        forwardText = '翌年';
        break;
      case PeriodMode.MONTH:
        backText = '前月';
        forwardText = '翌月';
        break;
      case PeriodMode.DAY:
        backText = '前日';
        forwardText = '翌日';
        break;
    }

    print(
      '\n ${_vhList.map<String>((vh) {
        final customer = vh.customerJson.toCustomer().name;
        final dateStr = vh.date.toFormatString(DateFormatMode.MEDIUM);
        final sinceLastVisit = widget.visitHistories.getSinceLastVisit(vh);
        final numOfVisit = widget.visitHistories.getNumOfVisit(vh);
        return 'c: $customer, date: $dateStr, slv: $sinceLastVisit, nov: $numOfVisit \n';
      }).toList()}',
    );

    print(widget.visitHistories.getBDOfVisitorsDataMap(_vhList));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          PeriodModeIndicator(mode: _periodMode),
          SizedBox(height: 8),
          PeriodSelectTile(
            date: _date,
            mode: _periodMode,
            maxDate: _maxDate,
            minDate: _minDate,
            onBackTap: (mode) => _onBackTap(mode),
            onForwardTap: (mode) => _onForwardTap(mode),
            onDateAreaTap: () => _onDateAreaTap(),
            forwardText: forwardText,
            backText: backText,
          ),
          MyDivider(height: 16),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //TODO 売上金額集計
                //TODO 来店人数集計(新規orワンリピorリピ)
                SSPTotalPart(dataMap: _vhList.getTotalDataMap()),
                //TODO 男女人数
                //TODO 新規内訳
                //TODO ワンリピ内訳
                //TODO リピート内訳
                //TODO カテゴリ別集計
              ],
            ),
          ),
        ],
      ),
    );
  }

  _onForwardTap(PeriodMode mode) {
    final date = _date.increment(mode);
    if (date.isAfter(_maxDate)) {
      _date = _maxDate;
    } else {
      _date = date;
    }
    _getByPeriod();
  }

  _onBackTap(PeriodMode mode) {
    final date = _date.decrement(mode);
    if (date.isBefore(_minDate)) {
      _date = _minDate;
    } else {
      _date = date;
    }
    _getByPeriod();
  }

  _onDateAreaTap() {
    showDialog(
      context: context,
      builder: (_) => PeriodSetDialog(
        mode: _periodMode,
        date: _date,
        minDate: _minDate,
        maxDate: _maxDate,
      ),
    ).then((pair) {
      _periodMode = pair['mode'];
      _date = pair['date'];
      _getByPeriod();
    });
  }

  _getByPeriod() {
    setState(() {
      _vhList = _vhList.getByPeriod(_date, _periodMode);
    });
  }
}
