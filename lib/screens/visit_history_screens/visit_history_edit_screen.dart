import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/parts/customer_selected_card.dart';
import 'package:customermanagementapp/screens/visit_history_screens/select_screens/menu_select_screen.dart';
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
  List<Employee> _employees = List();
  Employee _selectedEmployee;
  List<Menu> _menus = List();

  @override
  void initState() {
    super.initState();
    _initEmployees();
    _date = DateTime.parse(DateFormat('yyyyMMdd').format(DateTime.now()));
  }

  // [初期化：担当選択ドロップダウン用フィールド初期化]
  _initEmployees() async {
    _employees = await database.allEmployees;
    _selectedEmployee = _employees.isEmpty ? null : _employees[0];
    setState(() {});
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: const Text('お客様情報', style: TextStyle(fontSize: 20)),
              ),
              _divider(),
              _customerInputPart(),
              _divider(),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: const Text('詳細情報', style: TextStyle(fontSize: 20)),
              ),
              _divider(),
              _dateInputPart(),
              _divider(indent: 8),
              _employeeInputPart(),
              _divider(),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: const Text('提供メニュー', style: TextStyle(fontSize: 20)),
              ),
              _divider(),
              _menuInputPart(),
              _divider(),
            ],
          ),
        ),
      ),
    );
  }

  // [ウィジェット：区切り線スタイル]
  Widget _divider({double indent = 0.0}) {
    return Divider(
      height: 8,
      indent: indent,
      endIndent: indent,
    );
  }

  // [ウィジェットビルダー：各入力欄のフォーマッタ]
  Widget _inputPartBuilder({Icon icon, String title, Widget content}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: icon,
                ),
                Text(title, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            flex: 8,
            child: content,
          ),
        ],
      ),
    );
  }

  // [ウィジェット：顧客選択欄]
  Widget _customerInputPart() {
    return _inputPartBuilder(
      icon: Icon(Icons.account_circle),
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
      icon: Icon(Icons.calendar_today),
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

  // [ウィジェット：担当入力欄]
  Widget _employeeInputPart() {
    return _inputPartBuilder(
      icon: Icon(Icons.supervisor_account),
      title: '担当',
      content: DropdownButton<Employee>(
        isDense: true,
        isExpanded: true,
        value: _selectedEmployee,
        onChanged: (selectedEmployee) {
          setState(() {
            _selectedEmployee = selectedEmployee;
          });
        },
        selectedItemBuilder: (context) {
          return _employees.map<Widget>((employee) {
            return Text(employee.name);
          }).toList();
        },
        items: _employees.map<DropdownMenuItem<Employee>>((employee) {
          return DropdownMenuItem(
            value: employee,
            child: Text(employee.name),
          );
        }).toList(),
      ),
    );
  }

  // [ウィジェット：メニュー選択部分]
  Widget _menuInputPart() {
    return RaisedButton(
      child: Text('選択'),
      onPressed: () {
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => MenuSelectScreen(),
            fullscreenDialog: true,
          ),
        )
            .then(
          (menuList) {
            setState(() => _menus = menuList ?? _menus);
            print(_menus);
          },
        );
      },
    );
  }
}
