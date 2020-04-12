import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/parts/my_drawer.dart';
import 'package:customermanagementapp/parts/visit_record_list_card.dart';
import 'package:customermanagementapp/screens/edit_screens/visit_record_edit_screen.dart';
import 'package:customermanagementapp/src/my_custom_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

import 'visit_record_information_screen.dart';

enum VisitRecordListNarrowState { ALL, TODAY }
enum VisitRecordListSortState { REGISTER_NEW, REGISTER_OLD }

class VisitRecordListScreen extends StatefulWidget {
  final VisitRecordListScreenPreferences pref;

  VisitRecordListScreen({this.pref});

  @override
  _VisitRecordScreenState createState() => _VisitRecordScreenState();
}

class _VisitRecordScreenState extends State<VisitRecordListScreen> {
  List<SoldItem> _soldItemsList = List();
  VisitRecordListNarrowState _narrowState = VisitRecordListNarrowState.ALL;
  VisitRecordListSortState _sortState = VisitRecordListSortState.REGISTER_OLD;
  List<String> _narrowDropdownMenuItems = List();
  List<String> _sortDropdownMenuItems = List();
  String _narrowDropdownSelectedValue = '';
  String _sortDropdownSelectedValue = '';

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
    _reloadVisitRecordList();
  }

  // [リスト更新処理：指定の条件でリストを更新する]
  _reloadVisitRecordList() async {
    // 絞り込み条件
    switch (_narrowState) {
      case VisitRecordListNarrowState.ALL:
        _narrowDropdownSelectedValue = _narrowDropdownMenuItems[0];
        _soldItemsList = await database.allSoldItems;
        break;
      case VisitRecordListNarrowState.TODAY:
        _narrowDropdownSelectedValue = _narrowDropdownMenuItems[1];
        _soldItemsList = await database.getSoldItemsByDay(
            DateTime.parse(DateFormat('yyyyMMdd').format(DateTime.now())));
        break;
    }

    // 並べ替え条件
    switch (_sortState) {
      case VisitRecordListSortState.REGISTER_OLD:
        _sortDropdownSelectedValue = _sortDropdownMenuItems[0];
        _soldItemsList.sort((a, b) => a.id - b.id);
        break;
      case VisitRecordListSortState.REGISTER_NEW:
        _sortDropdownSelectedValue = _sortDropdownMenuItems[1];
        _soldItemsList.sort((a, b) => b.id - a.id);
        break;
    }
    setState(() {});
  }

  // [絞り込み状態変更：現在の絞り込みステータスを変更して更新する]
  _setNarrowState(VisitRecordListNarrowState narrowState) {
    _narrowState = narrowState;
    _reloadVisitRecordList();
  }

  // [ソート状態変更：現在のソートステータスを変更して更新する]
  _setSortState(VisitRecordListSortState sortState) {
    _sortState = sortState;
    _reloadVisitRecordList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('来店記録一覧'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: '来店追加',
        onPressed: () => _addVisitRecord(),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: <Widget>[
          _menuBarPart(),
          Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemBuilder: (context, index) =>
                    _visitRecordListItemPart(index),
                itemCount: _soldItemsList.length,
              ),
            ),
          ),
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
                  text: '${_soldItemsList.length}',
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

  // [ウィジェット：各リストアイテム]
  Widget _visitRecordListItemPart(int index) {
    var soldItem = _soldItemsList[index];
    return VisitRecordListCard(
      soldItem: soldItem,
//      onTap: () => _showVisitRecord(soldItem),
      onTap: null,
      onLongPress: () => _deleteVisitRecord(soldItem),
    );
  }

  // [コールバック：FABタップ]
  // →新しい顧客情報を登録する
  _addVisitRecord() {
    Navigator.pushReplacement(
      context,
      MyCustomRoute(
        builder: (context) => VisitRecordEditScreen(
          VisitRecordListScreenPreferences(
            narrowState: _narrowState,
            sortState: _sortState,
          ),
          state: VisitRecordEditState.ADD,
        ),
      ),
    );
  }

  // [コールバック：リストアイテムタップ]
  // →選択した顧客情報の詳細ページへ遷移する
  _showVisitRecord(SoldItem soldItem) {
    Navigator.pushReplacement(
      context,
      MyCustomRoute(
        builder: (context) => VisitRecordInformationScreen(
          VisitRecordListScreenPreferences(
            narrowState: _narrowState,
            sortState: _sortState,
          ),
          soldItem: soldItem,
        ),
      ),
    );
  }

  // [コールバック：リストアイテム長押し]
  // →長押ししたアイテムを削除する
  _deleteVisitRecord(SoldItem soldItem) async {
    // DBから指定のCustomerを削除
    await database.deleteSoldItem(soldItem);
    // 現在の条件でリストを更新
    _reloadVisitRecordList();
    // トースト表示
    Toast.show('削除しました。', context);
  }

  // [コールバック：絞り込みメニューアイテム選択時]
  // →各項目ごとに絞り込み
  _narrowMenuSelected(String value) async {
    switch (value) {
      case '今日':
        // 今日の売上データを抽出
        _setNarrowState(VisitRecordListNarrowState.TODAY);
        break;
      default:
        // すべての売上データを抽出して更新
        _setNarrowState(VisitRecordListNarrowState.ALL);
        break;
    }
  }

  // [コールバック：ソートメニューアイテム選択時]
  // →各項目ごとにソート
  _sortMenuSelected(String value) async {
    switch (value) {
      case '登録順(新)':
        // 新規登録が新しい順に並び替え
        _setSortState(VisitRecordListSortState.REGISTER_NEW);
        break;
      case '登録順(古)':
        // 新規登録が新しい順に並び替え
        _setSortState(VisitRecordListSortState.REGISTER_OLD);
        break;
    }
  }
}

// HomeScreenの環境設定を保持するクラス
class VisitRecordListScreenPreferences {
  VisitRecordListNarrowState narrowState;
  VisitRecordListSortState sortState;

  VisitRecordListScreenPreferences({this.narrowState, this.sortState});
}
