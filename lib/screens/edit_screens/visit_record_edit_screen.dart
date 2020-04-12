import 'dart:math';

import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/parts/customer_list_card.dart';
import 'package:customermanagementapp/parts/visit_record_list_card.dart';
import 'package:customermanagementapp/screens/customers_list_screens/customers_list_screen.dart';
import 'package:customermanagementapp/screens/visit_record_list_screens/customer_select_screen.dart';
import 'package:customermanagementapp/screens/visit_record_list_screens/visit_record_information_screen.dart';
import 'package:customermanagementapp/screens/visit_record_list_screens/visit_record_list_screen.dart';
import 'package:customermanagementapp/src/my_custom_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

enum VisitRecordEditState { ADD, EDIT }

class VisitRecordEditScreen extends StatefulWidget {
  final VisitRecordListScreenPreferences pref;
  final VisitRecordEditState state;
  final SalesItem salesItem;

  VisitRecordEditScreen(this.pref, {@required this.state, this.salesItem});
  @override
  _VisitRecordEditScreenState createState() => _VisitRecordEditScreenState();
}

class _VisitRecordEditScreenState extends State<VisitRecordEditScreen> {
  DateTime _date;
  DateFormat _dateFormatter;
  Customer _customer;
  String _titleStr;
  SalesItem _editedSalesItem;

  @override
  void initState() {
    super.initState();
    if (widget.state == VisitRecordEditState.ADD) {
      _titleStr = '売上データの新規登録';
    } else {
      _titleStr = '売上データの編集';
    }
    _dateFormatter = DateFormat('yyyy/M/d');
    _date = DateTime.parse(DateFormat('yyyyMMdd').format(DateTime.now()));
    _initCustomer();
  }

  // [更新：CustomerをDBから取得]
  _initCustomer() async {
    _customer = await database.getCustomersById(widget.salesItem.customerId);
    setState(() {});
  }

  // [更新：日付入力後に更新する処理]
  _setDate(DateTime date) {
    setState(() {
      _date = date;
    });
  }

  // [更新：日付入力後に更新する処理]
  _setCustomer(Customer customer) {
    setState(() {
      _customer = customer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _finishEditScreen(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(_titleStr),
          // 戻るボタン
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => _finishEditScreen(context),
          ),
          actions: <Widget>[
            // 保存ボタン
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveVisitRecord,
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              const Text('売上データ作成', style: TextStyle(fontSize: 20)),
              SizedBox(height: 16),
              _customerInputPart(),
              SizedBox(height: 16),
              _dateInputPart(),
              SizedBox(height: 16),
//              _stuffInputPart(),
              SizedBox(height: 16),
//              _menuInputPart(),
              SizedBox(height: 16),
//              _discountInputPart(),
              SizedBox(height: 30),
//              _priceInputPart(),
            ],
          ),
        ),
      ),
    );
  }

  // [ウィジェット：顧客選択欄]
  Widget _customerInputPart() {
    var widget;
    var leftButton;
    var rightButton;
    if (_customer == null) {
      widget = Container(
        height: 153,
        child: Text('未選択'),
      );
      leftButton = RaisedButton(
        child: Text('初回来店'),
        onPressed: null,
      );
      rightButton = RaisedButton(
        child: Text('2回目以降'),
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => CustomerSelectScreen(),
                  fullscreenDialog: true,
                ),
              )
              .then(
                (customer) => _setCustomer(customer),
              );
        },
      );
    } else {
      widget = Container(
        padding: EdgeInsets.only(top: 8),
        child: CustomerListCard(
          customer: _customer,
          onTap: null,
          onLongPress: null,
        ),
      );
      leftButton = RaisedButton(
        child: Text('変更'),
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => CustomerSelectScreen(),
                  fullscreenDialog: true,
                ),
              )
              .then(
                (customer) => _setCustomer(customer),
              );
        },
      );
      rightButton = RaisedButton(
        child: Text('取り除く'),
        onPressed: () => _setCustomer(null),
      );
    }
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          widget,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              leftButton,
              rightButton,
            ],
          ),
        ],
      ),
    );
  }

  // [ウィジェットビルダー：各入力欄のフォーマッタ]
  Widget _inputPartBuilder({String title, Widget content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(title, style: TextStyle(fontSize: 20)),
          ),
          Expanded(
            flex: 7,
            child: content,
          ),
        ],
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

  // [コールバック：日付欄タップ時]
  _showDateSelectPicker() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1970, 1, 1),
      maxTime: DateTime.now(),
      onConfirm: (date) => _setDate(date),
      currentTime: _date,
      locale: LocaleType.jp,
    );
    setState(() {});
  }

  // [コールバック：保存ボタンタップ時]
  _saveVisitRecord() async {
    // 新しいCustomerオブジェクト生成
    var salesItem = SalesItem(
      id: null,
      date: _date,
      customerId: _customer.id,
      menuId: 1,
      stuffId: 1,
      discountId: 1,
      price: 1000,
    );
    print(salesItem);
    // DBに新規登録
    await database.addSalesItem(salesItem);
    Toast.show('登録されました', context);

    // 画面を終了
    _finishEditScreen(context);
  }

  // [コールバック：画面終了時]
  Future<bool> _finishEditScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MyCustomRoute(
          builder: (context) => VisitRecordListScreen(pref: widget.pref)),
    );
    return Future.value(false);
  }
}
