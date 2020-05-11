import 'package:customermanagementapp/data/drop_down_menu_items.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/dialogs/visit_history_narrow_set_dialog.dart';
import 'package:customermanagementapp/view/components/list_items/visit_history_list_item.dart';
import 'package:customermanagementapp/view/components/my_drawer.dart';
import 'package:customermanagementapp/view/components/narrow_switch_button.dart';
import 'package:customermanagementapp/view/components/search_bar.dart';
import 'package:customermanagementapp/viewmodel/visit_history_list_view_modeel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'visit_history_edit_screen.dart';

//class VisitHistoryListScreen extends StatefulWidget {
//  final VisitHistoryListScreenPreferences pref;
//
//  VisitHistoryListScreen({this.pref});
//
//  @override
//  _VisitHistoryScreenState createState() => _VisitHistoryScreenState();
//}
//
//class _VisitHistoryScreenState extends State<VisitHistoryListScreen> {
//  List<VisitHistory> _visitHistoriesList = List();
//  VisitHistoryNarrowData _narrowData = VisitHistoryNarrowData();
//  VisitHistorySortState _sortState = VisitHistorySortState.REGISTER_OLD;
//  String _sortDropdownSelectedValue = '';
//
//  final visitHistoryDao = VisitHistoryDao(database);
//
//  @override
//  void initState() {
//    super.initState();
//    _sortDropdownSelectedValue = visitHistorySortStateMap[_sortState];
//    // 環境設定がある場合はそれを反映
//    if (widget.pref != null) {
//      _narrowData = widget.pref.narrowData;
//      _sortState = widget.pref.sortState;
//    }
//    _reloadVisitHistoryList();
//  }
//
//  // [リスト更新処理：指定の条件でリストを更新する]
//  _reloadVisitHistoryList() async {
//    // 絞り込み状態表示
//    // TODO
//
//    // 並べ替え状態表示
//    _sortDropdownSelectedValue = visitHistorySortStateMap[_sortState];
//
//    // 条件を反映させた来店履歴リストをDBから取得
//    _visitHistoriesList = await visitHistoryDao.getVisitHistories(
//        narrowData: _narrowData, sortState: _sortState);
//
//    setState(() {});
//  }
//
//  // [コールバック：FABタップ]
//  // →売上データを登録する画面へ遷移する
//  _addVisitHistory() {
//    Navigator.pushReplacement(
//      context,
//      MaterialPageRoute(
//        builder: (context) => VisitHistoryEditScreen(
//          VisitHistoryListScreenPreferences(
//            narrowData: _narrowData,
//            sortState: _sortState,
//          ),
//        ),
//      ),
//    );
//  }
//
//  // [コールバック：ソートメニュー選択肢タップ時]
//  _sortMenuSelected(String value) async {
//    // 選択中のメニューアイテム文字列と一致するEntryを取得
//    final sortState = visitHistorySortStateMap.entries
//        .singleWhere((entry) => entry.value == value);
//
//    // EntryのNarrowStatusをフィールドへ代入
//    _sortState = sortState.key;
//
//    // リストを更新
//    _reloadVisitHistoryList();
//  }
//
//  // [コールバック：リストアイテムタップ時]
//  // →売上データを登録する画面へ遷移する
//  _editVisitHistory(VisitHistory visitHistory) {
//    Navigator.pushReplacement(
//      context,
//      MaterialPageRoute(
//        builder: (context) => VisitHistoryEditScreen(
//          VisitHistoryListScreenPreferences(
//            narrowData: _narrowData,
//            sortState: _sortState,
//          ),
//          visitHistory: visitHistory,
//        ),
//      ),
//    );
//  }
//
//  // [コールバック：リストアイテム長押し時]
//  // ・リスト＆DBからデータを削除
//  _deleteVisitHistory(VisitHistory visitHistory) async {
//    await visitHistoryDao.deleteVisitHistory(visitHistory);
//    Toast.show('削除しました。', context);
//    _reloadVisitHistoryList();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: const Text('来店履歴リスト'),
//      ),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.add),
//        tooltip: '来店追加',
//        onPressed: () => _addVisitHistory(),
//      ),
//      drawer: MyDrawer(),
//      body: Column(
//        children: <Widget>[
//          SearchBar(
//            numberOfItems: _visitHistoriesList.length,
//            narrowMenu: NarrowSwitchButton(
//              isSetAnyNarrowData: _narrowData.isSetAny(),
//              onPressed: () => _showNarrowSetDialog(context, _narrowData),
//            ),
//            sortMenu: _sortMenuPart(),
//          ),
//          Divider(),
//          _listPart(),
//        ],
//      ),
//    );
//  }
//
//  // [ウィジェット：ソートメニュー部分]
//  Widget _sortMenuPart() {
//    var entries = visitHistorySortStateMap.entries.toList();
//    return Padding(
//      padding: const EdgeInsets.symmetric(horizontal: 16.0),
//      child: SizedBox(
//        width: double.infinity,
//        child: DropdownButton(
//          value: _sortDropdownSelectedValue,
//          icon: Icon(Icons.arrow_drop_down),
//          onChanged: (newValue) => _sortMenuSelected(newValue),
//          style: TextStyle(fontSize: 14, color: Colors.black),
//          items: entries.map<DropdownMenuItem<String>>(
//            (value) {
//              return DropdownMenuItem<String>(
//                value: value.value,
//                child: SizedBox(
//                  width: 80,
//                  child: Text(
//                    value.value,
//                    textAlign: TextAlign.center,
//                  ),
//                ),
//              );
//            },
//          ).toList(),
//        ),
//      ),
//    );
//  }
//
//  // [ウィジェット：リスト表示部分]
//  _listPart() {
//    return Expanded(
//      child: ListView.separated(
//        itemBuilder: (context, index) {
//          var item = _visitHistoriesList[index];
//          return VisitHistoryListItem(
//            visitHistory: item,
//            onTap: () => _editVisitHistory(item),
//            onLongPress: () => _deleteVisitHistory(item),
//          );
//        },
//        separatorBuilder: (context, index) => Divider(),
//        itemCount: _visitHistoriesList.length,
//      ),
//    );
//  }
//
//  _showNarrowSetDialog(
//      BuildContext context, VisitHistoryNarrowData narrowData) {
//    showDialog(
//      context: context,
//      builder: (_) {
//        return VisitHistoryNarrowSetDialog(
//          narrowData: _narrowData,
//        );
//      },
//    ).then((narrowData) {
//      _narrowData = narrowData;
//      _reloadVisitHistoryList();
//    });
//  }
//}

class VisitHistoryListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<VisitHistoryListViewModel>(context, listen: false);

    Future(() {
      viewModel.getVisitHistories();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('来店履歴リスト'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: '来店追加',
        onPressed: () => _addVisitHistory(context),
      ),
      drawer: MyDrawer(),
      body: Consumer<VisitHistoryListViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: <Widget>[
              SearchBar(
                numberOfItems: viewModel.visitHistories.length,
                narrowMenu: NarrowSwitchButton(
                  isSetAnyNarrowData: viewModel.narrowData.isSetAny(),
                  onPressed: () => _showNarrowSetDialog(context),
                ),
                sortMenu: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      value: viewModel.selectedSortValue,
                      icon: Icon(Icons.arrow_drop_down),
                      onChanged: (newValue) =>
                          _sortMenuSelected(context, newValue),
                      style: TextStyle(fontSize: 14, color: Colors.black),
                      items: visitHistorySortStateMap.entries
                          .toList()
                          .map<DropdownMenuItem<String>>(
                        (value) {
                          return DropdownMenuItem<String>(
                            value: value.value,
                            child: SizedBox(
                              width: 80,
                              child: Text(
                                value.value,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ),
              Divider(),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    var item = viewModel.visitHistories[index];
                    return VisitHistoryListItem(
                      visitHistory: item,
                      onTap: () => _editVisitHistory(context, item),
                      onLongPress: () => _deleteVisitHistory(context, item),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: viewModel.visitHistories.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // [コールバック：FABタップ]
  // →売上データを登録する画面へ遷移する
  _addVisitHistory(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => VisitHistoryEditScreen(),
      ),
    );
  }

  // [コールバック：ソートメニュー選択肢タップ時]
  _sortMenuSelected(BuildContext context, String value) async {
    final viewModel =
        Provider.of<VisitHistoryListViewModel>(context, listen: false);

    // 選択中のメニューアイテム文字列と一致するEntryを取得
    final sortState = visitHistorySortStateMap.getKeyFromValue(value);

    await viewModel.getVisitHistories(sortState: sortState);
  }

  // [コールバック：リストアイテムタップ時]
  // →売上データを登録する画面へ遷移する
  _editVisitHistory(BuildContext context, VisitHistory visitHistory) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            VisitHistoryEditScreen(visitHistory: visitHistory),
      ),
    );
  }

  // [コールバック：リストアイテム長押し時]
  // ・リスト＆DBからデータを削除
  _deleteVisitHistory(BuildContext context, VisitHistory visitHistory) async {
    final viewModel =
        Provider.of<VisitHistoryListViewModel>(context, listen: false);

    await viewModel.deleteVisitHistory(visitHistory);

    Toast.show('削除しました。', context);
  }

  _showNarrowSetDialog(BuildContext context) {
    final viewModel =
        Provider.of<VisitHistoryListViewModel>(context, listen: false);

    showDialog(
      context: context,
      builder: (_) {
        return VisitHistoryNarrowSetDialog(
          narrowData: viewModel.narrowData,
        );
      },
    ).then((narrowData) async {
      await viewModel.getVisitHistories(narrowData: narrowData);
    });
  }
}
