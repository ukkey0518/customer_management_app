import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/parts/customer_selected_card.dart';
import 'package:customermanagementapp/src/my_custom_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import 'select_screens/customer_select_screen.dart';
import 'visit_history_list_screen.dart';

class VisitHistoryEditScreen extends StatefulWidget {
  final VisitHistoryListScreenPreferences pref;

  VisitHistoryEditScreen(this.pref);

  @override
  _VisitHistoryEditScreenState createState() => _VisitHistoryEditScreenState();
}

class _VisitHistoryEditScreenState extends State<VisitHistoryEditScreen> {
  final DateFormat _dateFormatter = DateFormat('yyyy/M/d');
  DateTime _date;
  Customer _selectedCustomer;

  @override
  void initState() {
    super.initState();
    _date = DateTime.parse(DateFormat('yyyyMMdd').format(DateTime.now()));
  }

  // [コールバック：日付欄タップ時]
  _showDateSelectPicker() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1970, 1, 1),
      maxTime: DateTime.now(),
      onConfirm: (date) => setState(() => _date = date),
      currentTime: _date,
      locale: LocaleType.jp,
    );
    setState(() {});
  }

  // [コールバック：画面終了時]
  Future<bool> _finishEditScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MyCustomRoute(
          builder: (context) => VisitHistoryListScreen(pref: widget.pref)),
    );
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _finishEditScreen(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('来店情報の登録'),
          // 戻るボタン
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => _finishEditScreen(context),
          ),
          actions: <Widget>[
            // 保存ボタン
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {}, //TODO 保存処理
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              const Text('売上データ作成', style: TextStyle(fontSize: 20)),
              Divider(height: 8),
              _customerInputPart(),
              Divider(height: 8),
              _dateInputPart(),
              Divider(height: 8),
//              _employeeInputPart(),
              Divider(height: 8),
//              _menuInputPart(),
              Divider(height: 8),
//              _discountInputPart(),
              SizedBox(height: 30),
//              _priceInputPart(),
            ],
          ),
        ),
      ),
    );
  }

  // [ウィジェットビルダー：各入力欄のフォーマッタ]
  Widget _inputPartBuilder({String title, Widget content}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(title, style: TextStyle(fontSize: 16)),
              ),
              Expanded(
                flex: 8,
                child: content,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // [ウィジェット：顧客選択欄]
  Widget _customerInputPart() {
    return _inputPartBuilder(
      title: '顧客',
      content: CustomerSelectedCard(
        customer: _selectedCustomer,
        onTap: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => CustomerSelectScreen(),
                  fullscreenDialog: true,
                ),
              )
              .then(
                (newCustomer) => setState(
                  () => _selectedCustomer = newCustomer ?? _selectedCustomer,
                ),
              );
        },
        onLongPress: null,
      ),
    );
  }

  // [ウィジェット：日付入力欄]
  Widget _dateInputPart() {
    return _inputPartBuilder(
      title: '日付',
      content: InkWell(
        onTap: _showDateSelectPicker,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                '${_dateFormatter.format(_date)}',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
