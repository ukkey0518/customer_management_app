import 'package:customermanagementapp/data/list_search_state/visit_history_sort_state.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/buttons/on_off_switch_button.dart';
import 'package:customermanagementapp/view/components/dialogs/visit_history_narrow_set_dialog.dart';
import 'package:customermanagementapp/view/components/list_items/visit_history_list_item.dart';
import 'package:customermanagementapp/view/components/my_drawer.dart';
import 'package:customermanagementapp/view/components/search_bar.dart';
import 'package:customermanagementapp/view/components/search_bar_items/name_search_area.dart';
import 'package:customermanagementapp/viewmodel/visit_history_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'visit_history_edit_screen.dart';

class VisitHistoryListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<VisitHistoryListViewModel>(context, listen: false);

    Future(() {
      viewModel.getVisitHistories();
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
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
        body: Consumer<VisitHistoryListViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              children: <Widget>[
                SearchBar(
                  numberOfItems: viewModel.visitHistories.length,
                  narrowMenu: OnOffSwitchButton(
                    text: '絞り込み',
                    isSetAnyNarrowData: viewModel.vhPref.narrowData.isSetAny(),
                    onPressed: () => _showNarrowSetDialog(context),
                  ),
                  sortMenu: OnOffSwitchButton(
                    text: '並べ替え',
                    isSetAnyNarrowData: viewModel.vhPref.narrowData.isSetAny(),
                    onPressed: () => _showNarrowSetDialog(context),
                  ),
//                sortMenu: SortDropDownMenu(
//                  items: visitHistorySortStateMap.values.toList(),
//                  selectedValue: viewModel.selectedSortValue,
//                  onSelected: (value) => _sortMenuSelected(context, value),
//                ),
                  searchMenu: SearchMenu(
                    controller: viewModel.searchNameController,
                    onChanged: (name) => _onKeyWordSearch(context, name),
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
      ),
    );
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

  // [コールバック：ソートメニュー選択肢タップ時]
  _sortMenuSelected(BuildContext context, String value) async {
    final viewModel =
        Provider.of<VisitHistoryListViewModel>(context, listen: false);

    // 選択中のメニューアイテム文字列と一致するEntryを取得
    final sortState = visitHistorySortStateMap.getKeyFromValue(value);

    await viewModel.getVisitHistories(sortState: sortState);
  }

  // [コールバック：キーワード検索時]
  _onKeyWordSearch(BuildContext context, String name) async {
    final viewModel =
        Provider.of<VisitHistoryListViewModel>(context, listen: false);

    await viewModel.getVisitHistories(searchCustomerName: name);
  }

  // [コールバック：リストアイテムタップ時]
  // →売上データを登録する画面へ遷移する
  _editVisitHistory(BuildContext context, VisitHistory visitHistory) {
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
          narrowData: viewModel.vhPref.narrowData,
        );
      },
    ).then((narrowData) async {
      await viewModel.getVisitHistories(narrowData: narrowData);
    });
  }
}
