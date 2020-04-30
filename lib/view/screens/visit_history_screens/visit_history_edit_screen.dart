import 'package:customermanagementapp/db/dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/list_status.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/view/components/customer_selected_card.dart';
import 'package:customermanagementapp/view/components/dialogs/unsaved_confirm_dialog.dart';
import 'package:customermanagementapp/view/screens/visit_history_screens/select_screens/menu_select_screen.dart';
import 'package:customermanagementapp/util/extensions.dart';
import 'package:customermanagementapp/util/my_custom_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

import 'select_screens/customer_select_screen.dart';
import 'visit_history_list_screen.dart';

class VisitHistoryEditScreen extends StatefulWidget {
  VisitHistoryEditScreen(this.pref, {this.visitHistory});

  final VisitHistoryListScreenPreferences pref;
  final VisitHistory visitHistory;

  @override
  _VisitHistoryEditScreenState createState() => _VisitHistoryEditScreenState();
}

class _VisitHistoryEditScreenState extends State<VisitHistoryEditScreen> {
  final DateFormat _dateFormatter = DateFormat('yyyy/M/d');
  DateTime _date;
  Customer _selectedCustomer;
  List<Employee> _employees = List();
  Employee _selectedEmployee;
  List<MenuCategory> _categories = List();
  List<Menu> _menus = List();

  bool _screenAbsorbing = true;

  final dao = MyDao(database);

  @override
  void initState() {
    super.initState();
    _initScreenState();
  }

  // [初期化：担当選択ドロップダウン用フィールド初期化]
  _initScreenState() async {
    if (widget.visitHistory == null) {
      _date = DateTime.parse(DateFormat('yyyyMMdd').format(DateTime.now()));
      _selectedCustomer = null;
      _selectedEmployee = null;
      _menus = List();
      _screenAbsorbing = false;
    } else {
      _date = widget.visitHistory.date;
      _selectedCustomer = widget.visitHistory.customerJson.toCustomer();
      _selectedEmployee = widget.visitHistory.employeeJson.toEmployee();
      _menus = widget.visitHistory.menuListJson.toMenuList();
    }
    _employees = await dao.allEmployees;
    _categories = await dao.allMenuCategories;
    setState(() {});
  }

  // [更新：編集モードと閲覧モードを切り替える]
  _setAbsorbing(bool flag) {
    setState(() {
      _screenAbsorbing = flag;
    });
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

  // [ウィジェット：メニュー表示欄タップ時]
  _startMenuSelectScreen() {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => MenuSelectScreen(selectedMenus: _menus),
        fullscreenDialog: true,
      ),
    )
        .then(
      (menuList) {
        setState(() => _menus = menuList ?? _menus);
      },
    );
  }

  // [コールバック：保存ボタン押下時]
  _saveSingleVisitHistory() async {
    // 未入力チェック：顧客選択欄
    if (_selectedCustomer == null) {
      Toast.show('顧客が選択されていません。', context);
      return;
    }
    // 未入力チェック：担当選択欄
    if (_selectedEmployee == null) {
      Toast.show('担当が選択されていません。', context);
      return;
    }
    // 未入力チェック：メニュー欄
    if (_menus == null || _menus.isEmpty) {
      Toast.show('メニューが選択されていません。', context);
      return;
    }
    // 新しい来店履歴データ作成
    var visitHistory = VisitHistory(
      id: widget.visitHistory?.id,
      date: _date,
      customerJson: _selectedCustomer.toJsonString(),
      employeeJson: _selectedEmployee.toJsonString(),
      menuListJson: _menus.toJsonString(),
    );
    // DB挿入
    await dao.addVisitHistory(visitHistory);
    // 完了メッセージ表示
    Toast.show('保存しました。', context);
    // 閲覧モードにする
    _setAbsorbing(true);
  }

  // [コールバック：画面終了時の処理]
  Future<bool> _finishEditScreen(BuildContext context) async {
    if (_screenAbsorbing) {
      Navigator.pushReplacement(
        context,
        MyCustomRoute(
          builder: (context) => VisitHistoryListScreen(pref: widget.pref),
        ),
      );
      return Future.value(false);
    }
    await showDialog(context: context, builder: (_) => UnsavedConfirmDialog())
        .then((flag) {
      if (flag) {
        Navigator.pushReplacement(
          context,
          MyCustomRoute(
            builder: (context) => VisitHistoryListScreen(pref: widget.pref),
          ),
        );
      }
    });
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _finishEditScreen(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('来店情報'),
          // 戻るボタン
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => _finishEditScreen(context),
          ),
          actions: <Widget>[
            _actionButtonPart(),
          ],
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _showModePart(),
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
              Expanded(
                child: _menuInputPart(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // [ウィジェット：閲覧、編集アイコンテキスト部分]
  Widget _showModePart() {
    var text;
    var color;
    if (_screenAbsorbing) {
      text = '閲覧モード';
      color = Theme.of(context).primaryColorLight;
    } else {
      text = '編集モード';
      color = Colors.amber;
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: color,
        ),
        child: Text(text),
      ),
    );
  }

  // [ウィジェット：アクションボタン]
  Widget _actionButtonPart() {
    if (_screenAbsorbing) {
      return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () => _setAbsorbing(false),
      );
    } else {
      return IconButton(
        icon: Icon(Icons.save),
        onPressed: () => _saveSingleVisitHistory(),
      );
    }
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
        onTap: _screenAbsorbing
            ? null
            : () {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (context) => CustomerSelectScreen(),
                        fullscreenDialog: true,
                      ),
                    )
                    .then(
                      (newCustomer) => setState(
                        () => _selectedCustomer =
                            newCustomer ?? _selectedCustomer,
                      ),
                    );
              },
        onLongPress: null,
      ),
    );
  }

  // [ウィジェット：日付入力欄]
  Widget _dateInputPart() {
    var content;
    if (_screenAbsorbing) {
      content = Text(
        '${_dateFormatter.format(_date)}',
        style: TextStyle(fontSize: 16),
      );
    } else {
      content = InkWell(
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
      );
    }
    return _inputPartBuilder(
      icon: Icon(Icons.calendar_today),
      title: '日付',
      content: content,
    );
  }

  // [ウィジェット：担当入力欄]
  Widget _employeeInputPart() {
    var content;
    if (_screenAbsorbing) {
      content = Text(
        _selectedEmployee?.name ?? '',
        style: TextStyle(fontSize: 16),
      );
    } else {
      content = DropdownButton<Employee>(
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
      );
    }
    return _inputPartBuilder(
        icon: Icon(Icons.supervisor_account), title: '担当', content: content);
  }

  // [ウィジェット：メニュー選択部分]
  Widget _menuInputPart() {
    return InkWell(
      onTap: _screenAbsorbing ? null : () => _startMenuSelectScreen(),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('合計：', style: TextStyle(fontSize: 16)),
                Text(
                  _menus.isEmpty
                      ? '0'
                      : '${_menus.reduce(
                            (a, b) => Menu(
                                id: null,
                                name: null,
                                price: a.price + b.price,
                                menuCategoryJson: null),
                          ).price.toPriceString()}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          _divider(indent: 8),
          Expanded(
            child: Scrollbar(
              child: ListView.builder(
                itemCount: _menus.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.import_contacts,
                          color: _categories.isEmpty
                              ? null
                              : Color(_categories
                                  .where((category) =>
                                      category.id ==
                                      _menus[index]
                                          .menuCategoryJson
                                          .toMenuCategory()
                                          .id)
                                  .single
                                  .color),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            _menus[index].name,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Text(
                          '${_menus[index].price.toPriceString()}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
