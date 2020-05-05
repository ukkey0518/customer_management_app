import 'package:customermanagementapp/db/dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/list_status.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/view/components/button_to_switch.dart';
import 'package:customermanagementapp/view/components/contents_column_with_title.dart';
import 'package:customermanagementapp/view/components/current_mode_display_banner.dart';
import 'package:customermanagementapp/view/components/cusotmer_selected_card/customer_not_selectd_card.dart';
import 'package:customermanagementapp/view/components/cusotmer_selected_card/customer_selected_card.dart';
import 'package:customermanagementapp/view/components/dialogs/unsaved_confirm_dialog.dart';
import 'package:customermanagementapp/view/components/input_widgets/date_select_form.dart';
import 'package:customermanagementapp/view/components/input_widgets/employee_select_button.dart';
import 'package:customermanagementapp/view/components/input_widgets/menu_select_form.dart';
import 'package:customermanagementapp/view/components/my_divider.dart';
import 'package:customermanagementapp/view/components/row_with_icon.dart';
import 'package:customermanagementapp/view/screens/visit_history_screens/select_screens/menu_select_screen.dart';
import 'package:customermanagementapp/util/extensions.dart';
import 'package:customermanagementapp/util/my_custom_route.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'visit_history_list_screen.dart';

class VisitHistoryEditScreen extends StatefulWidget {
  VisitHistoryEditScreen(this.pref, {this.visitHistory});

  final VisitHistoryListScreenPreferences pref;
  final VisitHistory visitHistory;

  @override
  _VisitHistoryEditScreenState createState() => _VisitHistoryEditScreenState();
}

class _VisitHistoryEditScreenState extends State<VisitHistoryEditScreen> {
  DateTime _date;
  Customer _selectedCustomer;
  List<Employee> _employees = List();
  Employee _selectedEmployee;
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
      _date = DateTime.now();
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
    setState(() {});
  }

  // [更新：編集モードと閲覧モードを切り替える]
  _setAbsorbing(bool flag) {
    setState(() {
      _screenAbsorbing = flag;
    });
  }

  // [コールバック：メニュー欄タップ時]
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
    print(_date);
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
            ButtonToSwitch(
              switchFlag: _screenAbsorbing,
              trueButton: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => _setAbsorbing(false),
              ),
              falseButton: IconButton(
                icon: Icon(Icons.save),
                onPressed: () => _saveSingleVisitHistory(),
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CurrentModeDisplayBanner(
                modeText: _screenAbsorbing ? '閲覧モード' : '編集モード',
                color: _screenAbsorbing
                    ? Theme.of(context).primaryColorLight
                    : Colors.amber,
              ),
              ContentsColumnWithTitle(
                title: 'お客様情報',
                children: <Widget>[
                  RowWithIcon(
                    icon: Icon(Icons.account_circle),
                    title: '顧客',
                    content: _selectedCustomer != null
                        ? CustomerSelectedCard(
                            customer: _selectedCustomer,
                            onSelected: (customer) {
                              setState(() => _selectedCustomer =
                                  customer ?? _selectedCustomer);
                            },
                          )
                        : CustomerNotSelectedCard(
                            onSelected: (customer) {
                              setState(() => _selectedCustomer =
                                  customer ?? _selectedCustomer);
                            },
                          ),
                  ),
                ],
              ),
              MyDivider(),
              SizedBox(height: 30),
              ContentsColumnWithTitle(
                title: '詳細情報',
                children: <Widget>[
                  RowWithIcon(
                    icon: Icon(Icons.calendar_today),
                    title: '日付',
                    content: DateSelectForm(
                      selectedDate: _date,
                      onConfirm: (date) => setState(() => _date = date),
                      isDisabled: _screenAbsorbing,
                    ),
                  ),
                  RowWithIcon(
                    icon: Icon(Icons.supervisor_account),
                    title: '担当',
                    content: EmployeeSelectButton(
                      selectedEmployee: _selectedEmployee,
                      employees: _employees,
                      onChanged: (selectedEmployee) {
                        setState(() {
                          _selectedEmployee = selectedEmployee;
                        });
                      },
                      isDisabled: _screenAbsorbing,
                    ),
                  ),
                ],
              ),
              MyDivider(),
              SizedBox(height: 30),
              ContentsColumnWithTitle(
                title: '提供メニュー',
                children: <Widget>[Container()],
              ),
              Expanded(
                child: MenuSelectForm(
                  screenAbsorbing: _screenAbsorbing,
                  onTap: () => _startMenuSelectScreen(),
                  menus: _menus,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
