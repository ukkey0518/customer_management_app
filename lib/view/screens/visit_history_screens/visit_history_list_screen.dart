import 'package:customermanagementapp/data/data_classes/visit_history_sort_data.dart';
import 'package:customermanagementapp/data/enums/list_sort_order.dart';
import 'package:customermanagementapp/data/enums/screen_tag.dart';
import 'package:customermanagementapp/data/list_search_state/visit_history_sort_state.dart';
import 'package:customermanagementapp/data/pickers/single_item_select_picker.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/buttons/list_sort_order_switch_button.dart';
import 'package:customermanagementapp/view/components/buttons/on_off_switch_button.dart';
import 'package:customermanagementapp/view/components/dialogs/visit_history_narrow_set_dialog.dart';
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
  void dispose() {
    _nameSearchTextFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<VisitHistoryListViewModel>(context, listen: false);

    Future(() {
      viewModel.getVisitHistories();
    });

    return GestureDetector(
      onTap: () {
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
        drawer: MyDrawer(currentScreen: ScreenTag.SCREEN_VISIT_HISTORY_LIST),
        endDrawerEnableOpenDragGesture: false,
        body: Consumer<VisitHistoryListViewModel>(
          builder: (context, vm, child) {
            return Column(
              children: <Widget>[
                SearchBar(
                  numberOfItems: vm.visitHistories.length,
                  narrowSetButton: OnOffSwitchButton(
                    title: '絞り込み',
                    value: vm.vhPref.narrowData.isSetAny() ? 'ON' : 'OFF',
                    isOn: vm.vhPref.narrowData.isSetAny(),
                    onTap: () => _showNarrowSettingDialog(context),
                  ),
                  sortSetButton: OnOffSwitchButton(
                    title: '並べ替え',
                    value: vm.selectedSortValue,
                    isOn: false,
                    onTap: () => _showSortSettingArea(context),
                  ),
                  orderSwitchButton: ListSortOrderSwitchButton(
                    selectedOrder: vm.selectedOrder,
                    onUpButtonTap: () => _sortOrderChanged(
                        context, ListSortOrder.ASCENDING_ORDER),
                    onDownButtonTap: () =>
                        _sortOrderChanged(context, ListSortOrder.REVERSE_ORDER),
                  ),
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
  _showNarrowSettingDialog(BuildContext context) {
    final viewModel =
        Provider.of<VisitHistoryListViewModel>(context, listen: false);

    showDialog(
      context: context,
      builder: (_) {
        return VisitHistoryNarrowSetDialog(
          narrowData: viewModel.vhPref.narrowData,
          allEmployees: viewModel.allEmployees,
          allMenuCategories: viewModel.allMenuCategories,
        );
      },
    ).then((narrowData) async {
      await viewModel.getVisitHistories(narrowData: narrowData);
    });
  }

  // [コールバック：並べ替え設定ドロワーボタンタップ時]
  _showSortSettingArea(BuildContext context) {
    final viewModel =
        Provider.of<VisitHistoryListViewModel>(context, listen: false);

    singleItemSelectPicker(
      context,
      values: visitHistorySortStateMap.values.toList(),
      selectedValue: viewModel.selectedSortValue,
      onConfirm: (value) => _sortMenuSelected(context, value),
    ).showModal(context);
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
    final viewModel =
        Provider.of<VisitHistoryListViewModel>(context, listen: false);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return VisitHistoryEditScreen();
        },
      ),
    ).then((_) async {
      return await viewModel.getVisitHistories();
    });
  }

  // [コールバック：リストアイテムタップ時]
  // →売上データを登録する画面へ遷移する
  _editVisitHistory(BuildContext context, VisitHistory visitHistory) {
    final viewModel =
        Provider.of<VisitHistoryListViewModel>(context, listen: false);

    _nameSearchTextFieldFocusNode.unfocus();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return VisitHistoryEditScreen(visitHistory: visitHistory);
        },
      ),
    ).then((_) async {
      return await viewModel.getVisitHistories();
    });
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
  _sortMenuSelected(BuildContext context, String value) async {
    final viewModel =
        Provider.of<VisitHistoryListViewModel>(context, listen: false);

    final sortData = VisitHistorySortData(
      sortState: visitHistorySortStateMap.getKeyFromValue(value),
      order: viewModel.selectedOrder,
    );

    await viewModel.getVisitHistories(sortData: sortData);
  }

  // [コールバック：ソート順選択肢タップ時]
  _sortOrderChanged(BuildContext context, ListSortOrder order) async {
    final viewModel =
        Provider.of<VisitHistoryListViewModel>(context, listen: false);

    final sortData = VisitHistorySortData(
      sortState:
          visitHistorySortStateMap.getKeyFromValue(viewModel.selectedSortValue),
      order: order,
    );

    await viewModel.getVisitHistories(sortData: sortData);
  }
}
