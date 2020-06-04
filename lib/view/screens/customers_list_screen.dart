import 'package:customermanagementapp/data/data_classes/customer_sort_data.dart';
import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/data/enums/list_sort_order.dart';
import 'package:customermanagementapp/data/enums/screen_display_mode.dart';
import 'package:customermanagementapp/data/enums/screen_tag.dart';
import 'package:customermanagementapp/data/list_search_state/customer_sort_state.dart';
import 'package:customermanagementapp/data/pickers/single_item_select_picker.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/buttons/list_sort_order_switch_button.dart';
import 'package:customermanagementapp/view/components/buttons/on_off_switch_button.dart';
import 'package:customermanagementapp/view/components/dialogs/customer_narrow_set_dialog.dart';
import 'package:customermanagementapp/view/components/dialogs/delete_confirm_dialog.dart';
import 'package:customermanagementapp/view/components/drowers/my_drawer.dart';
import 'package:customermanagementapp/view/components/list_items/customer_list_item.dart';
import 'package:customermanagementapp/view/components/search_bar.dart';
import 'package:customermanagementapp/view/components/search_bar_items/name_search_area.dart';
import 'package:customermanagementapp/view/screens/customer_edit_screen.dart';
import 'package:customermanagementapp/viewmodel/customers_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'customers_list_screens/customer_information_pages/customer_information_screen.dart';

class CustomersListScreen extends StatelessWidget {
  CustomersListScreen({this.displayMode}) : _focusNode = FocusNode();

  final ScreenDisplayMode displayMode;
  final FocusNode _focusNode;

  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<CustomersListViewModel>(context, listen: false);

    Future(() {
      return viewModel.getCustomersList(displayMode: displayMode);
    });

    return Consumer<CustomersListViewModel>(
      builder: (context, vm, child) {
        var fab;
        var drawer;

        switch (vm.displayMode) {
          case ScreenDisplayMode.EDITABLE:
            fab = FloatingActionButton(
              child: Icon(Icons.add),
              tooltip: '新規登録',
              onPressed: () => _addCustomer(context),
            );
            drawer = MyDrawer(currentScreen: ScreenTag.SCREEN_CUSTOMER_LIST);
            break;
          case ScreenDisplayMode.SELECTABLE:
            fab = Container();
            drawer = null;
            break;
        }

        return GestureDetector(
          onTap: () {
            if (_focusNode.hasFocus) {
              _focusNode.unfocus();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('顧客リスト'),
            ),
            floatingActionButton: fab,
            drawer: drawer,
            body: Column(
              children: <Widget>[
                SearchBar(
                  numberOfItems: vm.visitHistoriesByCustomers.length,
                  narrowSetButton: OnOffSwitchButton(
                    title: '絞り込み',
                    value: vm.cPref.narrowData.isSetAny() ? 'ON' : 'OFF',
                    isOn: vm.cPref.narrowData.isSetAny(),
                    onTap: () => _showNarrowSettingDialog(context),
                  ),
                  sortSetButton: OnOffSwitchButton(
                    title: '並び替え',
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
                    focusNode: _focusNode,
                  ),
                ),
                Divider(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: vm.visitHistoriesByCustomers.length,
                      itemBuilder: (context, index) {
                        return CustomerListItem(
                          visitHistoriesByCustomer:
                              vm.visitHistoriesByCustomers[index],
                          onTap: (vhbc) => _onListItemTap(context, vhbc),
                          onLongPress: (vhbc) => _deleteVHBC(context, vhbc),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // [コールバック：並べ替え設定ドロワーボタンタップ時]
  _showSortSettingArea(BuildContext context) {
    final viewModel =
        Provider.of<CustomersListViewModel>(context, listen: false);

    singleItemSelectPicker(
      context,
      values: customerSortStateMap.values.toList(),
      selectedValue: viewModel.selectedSortValue,
      onConfirm: (value) => _sortMenuSelected(context, value),
    ).showModal(context);
  }

  // [コールバック：FABタップ]
  _addCustomer(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return CustomerEditScreen(
            customer: null,
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  // [コールバック：リストアイテムタップ]
  _onListItemTap(BuildContext context, VisitHistoriesByCustomer vhbc) async {
    final viewModel =
        Provider.of<CustomersListViewModel>(context, listen: false);

    switch (viewModel.displayMode) {
      case ScreenDisplayMode.EDITABLE:
        Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (context) => CustomerInformationScreen(
                  customerId: vhbc.customer.id,
                ),
              ),
            )
            .then((_) => viewModel.setDisplayMode(ScreenDisplayMode.EDITABLE));
        break;
      case ScreenDisplayMode.SELECTABLE:
        Navigator.of(context).pop(vhbc.customer);
    }
  }

  // [コールバック：リストアイテム長押し]
  _deleteVHBC(BuildContext context, VisitHistoriesByCustomer vhbc) async {
    final viewModel =
        Provider.of<CustomersListViewModel>(context, listen: false);

    showDialog(
      context: context,
      builder: (_) => DeleteConfirmDialog(
        deleteValue: vhbc.customer.name,
      ),
    ).then((flag) async {
      if (flag) {
        await viewModel.deleteVHBC(vhbc);
        Toast.show('削除しました。', context);
      }
    });
  }

  // [コールバック：絞り込みメニューアイテム選択時]
  _showNarrowSettingDialog(BuildContext context) {
    final viewModel =
        Provider.of<CustomersListViewModel>(context, listen: false);

    showDialog(
      context: context,
      builder: (_) {
        return CustomerNarrowSetDialog(
          narrowData: viewModel.cPref.narrowData,
        );
      },
    ).then((narrowData) async {
      await viewModel.getCustomersList(narrowData: narrowData);
    });
  }

//  _narrowMenuSelected(BuildContext context, String value) async {
//    final viewModel =
//        Provider.of<CustomersListViewModel>(context, listen: false);
//
//    // 絞り込みメニュー文字列からCustomerNarrowStateを取得
//    final narrowState = customerNarrowStateMap.getKeyFromValue(value);
//
//    await viewModel.getCustomersList(narrowState: narrowState);
//  }

  // [コールバック：ソートメニューアイテム選択時]
  _sortMenuSelected(BuildContext context, String value) async {
    final viewModel =
        Provider.of<CustomersListViewModel>(context, listen: false);

    // ソートメニュー文字列からCustomerSortStateを取得
    final sortData = CustomerSortData(
      sortState: customerSortStateMap.getKeyFromValue(value),
      order: viewModel.selectedOrder,
    );

    await viewModel.getCustomersList(sortData: sortData);
  }

  // [コールバック：ソート順選択肢タップ時]
  _sortOrderChanged(BuildContext context, ListSortOrder order) async {
    final viewModel =
        Provider.of<CustomersListViewModel>(context, listen: false);

    // ソートメニュー文字列からCustomerSortStateを取得
    final sortData = CustomerSortData(
      sortState:
          customerSortStateMap.getKeyFromValue(viewModel.selectedSortValue),
      order: order,
    );

    await viewModel.getCustomersList(sortData: sortData);
  }

  // [コールバック：キーワード検索時]
  _onKeyWordSearch(BuildContext context, String searchWord) async {
    final viewModel =
        Provider.of<CustomersListViewModel>(context, listen: false);

    await viewModel.getCustomersList(searchWord: searchWord);
  }
}
