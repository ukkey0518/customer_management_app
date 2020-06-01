import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/buttons/on_off_switch_button.dart';
import 'package:customermanagementapp/view/components/drowers/my_drawer.dart';
import 'package:customermanagementapp/view/components/list_items/visit_history_list_item.dart';
import 'package:customermanagementapp/view/components/search_bar.dart';
import 'package:customermanagementapp/view/components/search_bar_items/name_search_area.dart';
import 'package:customermanagementapp/viewmodel/visit_history_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'visit_history_edit_screen.dart';

class VisitHistoryListScreen extends StatefulWidget {
  @override
  _VisitHistoryListScreenState createState() => _VisitHistoryListScreenState();
}

class _VisitHistoryListScreenState extends State<VisitHistoryListScreen> {
  FocusNode _nameSearchTextFieldFocusNode;

  @override
  void initState() {
    _nameSearchTextFieldFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<VisitHistoryListViewModel>(context, listen: false);

    if (viewModel.visitHistories.isEmpty) {
      Future(() {
        viewModel.getVisitHistories();
      });
    }

    return GestureDetector(
      onTap: () {
        print('tap');
        if (_nameSearchTextFieldFocusNode.hasFocus) {
          _nameSearchTextFieldFocusNode.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('来店履歴リスト'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          tooltip: '来店追加',
          onPressed: () => _addVisitHistory(context),
        ),
        drawer: MyDrawer(),
        endDrawerEnableOpenDragGesture: false,
        body: Consumer<VisitHistoryListViewModel>(
          builder: (context, vm, child) {
            return Column(
              children: <Widget>[
                SearchBar(
                  numberOfItems: vm.visitHistories.length,
                  narrowMenu: OnOffSwitchButton(
                    title: '絞り込み',
                    value: vm.vhPref.narrowData.isSetAny() ? 'ON' : 'OFF',
                    isSetAnyNarrowData: vm.vhPref.narrowData.isSetAny(),
                    onTap: () => _showNarrowSettingArea(context),
                  ),
                  sortMenu: OnOffSwitchButton(
                    title: '並べ替え',
                    value: vm.selectedSortValue,
                    isSetAnyNarrowData: vm.vhPref.narrowData.isSetAny(),
                    onTap: () => _showSortSettingArea(context),
                  ),
//                sortMenu: SortDropDownMenu(
//                  items: visitHistorySortStateMap.values.toList(),
//                  selectedValue: viewModel.selectedSortValue,
//                  onSelected: (value) => _sortMenuSelected(context, value),
//                ),
                  searchMenu: SearchMenu(
                    controller: vm.searchNameController,
                    onChanged: (name) => _onKeyWordSearch(context, name),
                    focusNode: _nameSearchTextFieldFocusNode,
                  ),
                ),
                Divider(),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      var item = vm.visitHistories[index];
                      return VisitHistoryListItem(
                        visitHistory: item,
                        onTap: () => _editVisitHistory(context, item),
                        onLongPress: () => _deleteVisitHistory(context, item),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: vm.visitHistories.length,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // [コールバック：絞り込み設定ドロワーボタンタップ時]
  _showNarrowSettingArea(BuildContext context) {
    print('narrow set btn tap.');
    //TODO
  }

  // [コールバック：並べ替え設定ドロワーボタンタップ時]
  _showSortSettingArea(BuildContext context) {
    print('sort set btn tap.');
    //TODO
  }

  // [コールバック：キーワード検索時]
  _onKeyWordSearch(BuildContext context, String name) async {
    final viewModel =
        Provider.of<VisitHistoryListViewModel>(context, listen: false);

    await viewModel.getVisitHistories(searchCustomerName: name);
  }

  // [コールバック：FABタップ]
  // →売上データを登録する画面へ遷移する
  _addVisitHistory(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VisitHistoryEditScreen(),
      ),
    );
  }

  // [コールバック：リストアイテムタップ時]
  // →売上データを登録する画面へ遷移する
  _editVisitHistory(BuildContext context, VisitHistory visitHistory) {
    _nameSearchTextFieldFocusNode.unfocus();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            VisitHistoryEditScreen(visitHistory: visitHistory),
      ),
    );
  }

  // [コールバック：リストアイテム長押し時]
  // ・リスト＆DBからデータを削除
  _deleteVisitHistory(BuildContext context, VisitHistory visitHistory) async {
    _nameSearchTextFieldFocusNode.unfocus();
    final viewModel =
        Provider.of<VisitHistoryListViewModel>(context, listen: false);

    await viewModel.deleteVisitHistory(visitHistory);

    Toast.show('削除しました。', context);
  }

// [コールバック：ソートメニュー選択肢タップ時]
//  _sortMenuSelected(BuildContext context, String value) async {
//    final viewModel =
//        Provider.of<VisitHistoryListViewModel>(context, listen: false);
//
//    // 選択中のメニューアイテム文字列と一致するEntryを取得
//    final sortState = visitHistorySortStateMap.getKeyFromValue(value);
//
//    await viewModel.getVisitHistories(sortState: sortState);
//  }

//  _showNarrowSetDialog(BuildContext context) {
//    final viewModel =
//        Provider.of<VisitHistoryListViewModel>(context, listen: false);
//
//    showDialog(
//      context: context,
//      builder: (_) {
//        return VisitHistoryNarrowSetDialog(
//          narrowData: viewModel.vhPref.narrowData,
//        );
//      },
//    ).then((narrowData) async {
//      await viewModel.getVisitHistories(narrowData: narrowData);
//    });
//  }
}
