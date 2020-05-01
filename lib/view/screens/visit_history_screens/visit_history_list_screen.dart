import 'package:customermanagementapp/db/dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/list_status.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/view/components/my_drawer.dart';
import 'package:customermanagementapp/view/components/list_items/visit_history_list_item.dart';
import 'package:customermanagementapp/util/my_custom_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

import 'visit_history_edit_screen.dart';

class VisitHistoryListScreen extends StatefulWidget {
  final VisitHistoryListScreenPreferences pref;

  VisitHistoryListScreen({this.pref});

  @override
  _VisitHistoryScreenState createState() => _VisitHistoryScreenState();
}

class _VisitHistoryScreenState extends State<VisitHistoryListScreen> {
  List<VisitHistory> _visitHistoriesList = List();
  VisitHistoryNarrowState _narrowState = VisitHistoryNarrowState.ALL;
  VisitHistorySortState _sortState = VisitHistorySortState.REGISTER_OLD;
  List<String> _narrowDropdownMenuItems = List();
  List<String> _sortDropdownMenuItems = List();
  String _narrowDropdownSelectedValue = '';
  String _sortDropdownSelectedValue = '';

  final dao = MyDao(database);

  @override
  void initState() {
    super.initState();
    _narrowDropdownMenuItems = ['すべて', '今日'];
    _sortDropdownMenuItems = ['登録順(古)', '登録順(新)'];
    _narrowDropdownSelectedValue = _narrowDropdownMenuItems[0];
    _sortDropdownSelectedValue = _sortDropdownMenuItems[0];
    // 環境設定がある場合はそれを反映
    if (widget.pref != null) {
      _narrowState = widget.pref.narrowState;
      _sortState = widget.pref.sortState;
    }
    _reloadVisitHistoryList();
  }

  // [リスト更新処理：指定の条件でリストを更新する]
  _reloadVisitHistoryList() async {
    // 絞り込み条件
    switch (_narrowState) {
      case VisitHistoryNarrowState.ALL:
        _narrowDropdownSelectedValue = _narrowDropdownMenuItems[0];
        _visitHistoriesList = await dao.allVisitHistories;
        break;
      case VisitHistoryNarrowState.TODAY:
        _narrowDropdownSelectedValue = _narrowDropdownMenuItems[1];
        _visitHistoriesList = await dao.getVisitHistoriesByDay(
            DateTime.parse(DateFormat('yyyyMMdd').format(DateTime.now())));
        break;
      default:
        _narrowDropdownSelectedValue = _narrowDropdownMenuItems[0];
        _visitHistoriesList = await dao.allVisitHistories;
    }

    // 並べ替え条件
    switch (_sortState) {
      case VisitHistorySortState.REGISTER_OLD:
        _sortDropdownSelectedValue = _sortDropdownMenuItems[0];
        _visitHistoriesList.sort((a, b) => a.id - b.id);
        break;
      case VisitHistorySortState.REGISTER_NEW:
        _sortDropdownSelectedValue = _sortDropdownMenuItems[1];
        _visitHistoriesList.sort((a, b) => b.id - a.id);
        break;
      default:
        _sortDropdownSelectedValue = _sortDropdownMenuItems[0];
        _visitHistoriesList.sort((a, b) => a.id - b.id);
    }
    setState(() {});
  }

  // [絞り込み状態変更：現在の絞り込みステータスを変更して更新する]
  _setNarrowState(VisitHistoryNarrowState narrowState) {
    _narrowState = narrowState;
    _reloadVisitHistoryList();
  }

  // [ソート状態変更：現在のソートステータスを変更して更新する]
  _setSortState(VisitHistorySortState sortState) {
    _sortState = sortState;
    _reloadVisitHistoryList();
  }

  // [コールバック：FABタップ]
  // →売上データを登録する画面へ遷移する
  _addVisitHistory() {
    Navigator.pushReplacement(
      context,
      MyCustomRoute(
        builder: (context) => VisitHistoryEditScreen(
          VisitHistoryListScreenPreferences(
            narrowState: _narrowState,
            sortState: _sortState,
          ),
        ),
      ),
    );
  }

  // [コールバック：絞り込みメニューアイテム選択時]
  // →各項目ごとに絞り込み
  _narrowMenuSelected(String value) async {
    switch (value) {
      case '今日':
        // 今日の売上データを抽出
        _setNarrowState(VisitHistoryNarrowState.TODAY);
        break;
      default:
        // すべての売上データを抽出して更新
        _setNarrowState(VisitHistoryNarrowState.ALL);
        break;
    }
  }

  // [コールバック：ソートメニュー選択肢タップ時]
  // →各項目ごとにソート
  _sortMenuSelected(String value) async {
    switch (value) {
      case '登録順(新)':
        // 新規登録が新しい順に並び替え
        _setSortState(VisitHistorySortState.REGISTER_NEW);
        break;
      case '登録順(古)':
        // 新規登録が新しい順に並び替え
        _setSortState(VisitHistorySortState.REGISTER_OLD);
        break;
    }
  }

  // [コールバック：リストアイテムタップ時]
  // →売上データを登録する画面へ遷移する
  _editVisitHistory(VisitHistory visitHistory) {
    Navigator.pushReplacement(
      context,
      MyCustomRoute(
        builder: (context) => VisitHistoryEditScreen(
          VisitHistoryListScreenPreferences(
            narrowState: _narrowState,
            sortState: _sortState,
          ),
          visitHistory: visitHistory,
        ),
      ),
    );
  }

  // [コールバック：リストアイテム長押し時]
  // ・リスト＆DBからデータを削除
  _deleteVisitHistory(VisitHistory visitHistory) async {
    await dao.deleteVisitHistory(visitHistory);
    Toast.show('削除しました。', context);
    _reloadVisitHistoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('来店履歴リスト'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: '来店追加',
        onPressed: () => _addVisitHistory(),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: <Widget>[
          _menuBarPart(),
          Divider(),
          _listPart(),
        ],
      ),
    );
  }

  // [ウィジェット：上部メニュー部分]
  Widget _menuBarPart() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: <Widget>[
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '検索結果：'),
                TextSpan(
                  text: '${_visitHistoriesList.length}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                  ),
                ),
                TextSpan(text: '件'),
              ],
            ),
          ),
          Expanded(child: _narrowMenuPart()),
          Expanded(child: _sortMenuPart()),
        ],
      ),
    );
  }

  // [ウィジェット：絞り込みメニュー部分]
  Widget _narrowMenuPart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: DropdownButton(
          value: _narrowDropdownSelectedValue,
          icon: Icon(Icons.arrow_drop_down),
          onChanged: (newValue) => _narrowMenuSelected(newValue),
          style: TextStyle(fontSize: 14, color: Colors.black),
          items: _narrowDropdownMenuItems.map<DropdownMenuItem<String>>(
            (value) {
              return DropdownMenuItem<String>(
                value: value,
                child: SizedBox(
                  width: 80,
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }

  // [ウィジェット：ソートメニュー部分]
  Widget _sortMenuPart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: DropdownButton(
          value: _sortDropdownSelectedValue,
          icon: Icon(Icons.arrow_drop_down),
          onChanged: (newValue) => _sortMenuSelected(newValue),
          style: TextStyle(fontSize: 14, color: Colors.black),
          items: _sortDropdownMenuItems.map<DropdownMenuItem<String>>(
            (value) {
              return DropdownMenuItem<String>(
                value: value,
                child: SizedBox(
                  width: 80,
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }

  // [ウィジェット：リスト表示部分]
  _listPart() {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          var item = _visitHistoriesList[index];
          return VisitHistoryListItem(
            visitHistory: item,
            onTap: () => _editVisitHistory(item),
            onLongPress: () => _deleteVisitHistory(item),
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: _visitHistoriesList.length,
      ),
    );
  }
}
