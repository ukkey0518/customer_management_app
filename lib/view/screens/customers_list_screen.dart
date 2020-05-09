import 'package:customermanagementapp/data/data_classes/screen_preferences.dart';
import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/data/drop_down_menu_items.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/list_items/customer_list_item.dart';
import 'package:customermanagementapp/view/components/my_drawer.dart';
import 'package:customermanagementapp/view/components/search_bar.dart';
import 'package:customermanagementapp/view/screens/customer_edit_screen.dart';
import 'package:customermanagementapp/viewmodel/customers_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'customers_list_screens/customer_information_pages/customer_information_screen.dart';

class CustomersListScreen extends StatelessWidget {
  CustomersListScreen({this.pref});

  final CustomerListScreenPreferences pref;

  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<CustomersListViewModel>(context, listen: false);

    if (!viewModel.isLoading && viewModel.visitHistoriesByCustomers.isEmpty) {
      Future(() => viewModel.getCustomersList());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('顧客リスト'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: '新規登録',
        onPressed: () => _addCustomer(context),
      ),
      drawer: MyDrawer(),
      body: Consumer<CustomersListViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: <Widget>[
              SearchBar(
                numberOfItems: viewModel.visitHistoriesByCustomers.length,
                narrowMenu: NarrowDropDownMenu(
                  items: customerNarrowStateMap.values.toList(),
                  selectedValue: viewModel.narrowSelectedValue,
                  onSelected: (value) => _narrowMenuSelected(context, value),
                ),
                sortMenu: SortDropDownMenu(
                  items: customerSortStateMap.values.toList(),
                  selectedValue: viewModel.sortSelectedValue,
                  onSelected: (value) => _sortMenuSelected(context, value),
                ),
                searchMenu: SearchMenu(
                  controller: viewModel.searchController,
                  onChanged: (searchName) =>
                      _onKeyWordSearch(context, searchName),
                ),
              ),
              Divider(),
              Expanded(
                child: viewModel.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.grey,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: viewModel.visitHistoriesByCustomers.length,
                          itemBuilder: (context, index) {
                            return CustomerListItem(
                              visitHistoriesByCustomer:
                                  viewModel.visitHistoriesByCustomers[index],
                              onTap: (vhbc) => _showInformation(context, vhbc),
                              onLongPress: (vhbc) => _deleteVHBC(context, vhbc),
                            );
                          },
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  // [コールバック：FABタップ]
  _addCustomer(BuildContext context) {
    final viewModel =
        Provider.of<CustomersListViewModel>(context, listen: false);

    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => CustomerEditScreen(
              viewModel.pref,
              viewModel.visitHistoriesByCustomers.toCustomers(),
              customer: null,
            ),
          ),
        )
        .then(([pref, customer]) {});
  }

  // [コールバック：リストアイテムタップ]
  _showInformation(BuildContext context, VisitHistoriesByCustomer vhbc) async {
    final viewModel =
        Provider.of<CustomersListViewModel>(context, listen: false);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CustomerInformationScreen(
          viewModel.pref,
          historiesByCustomer: vhbc,
        ),
      ),
    );
  }

  // [コールバック：リストアイテム長押し]
  _deleteVHBC(BuildContext context, VisitHistoriesByCustomer vhbc) async {
    final viewModel =
        Provider.of<CustomersListViewModel>(context, listen: false);

    await viewModel.deleteVHBC(vhbc);

    Toast.show('削除しました。', context);
  }

  // [コールバック：絞り込みメニューアイテム選択時]
  _narrowMenuSelected(BuildContext context, String value) async {
    final viewModel =
        Provider.of<CustomersListViewModel>(context, listen: false);

    // 絞り込みメニュー文字列からCustomerNarrowStateを取得
    final narrowState = customerNarrowStateMap.getKeyFromValue(value);

    await viewModel.getCustomersList(narrowState: narrowState);
  }

  // [コールバック：ソートメニューアイテム選択時]
  _sortMenuSelected(BuildContext context, String value) async {
    final viewModel =
        Provider.of<CustomersListViewModel>(context, listen: false);

    // ソートメニュー文字列からCustomerSortStateを取得
    final sortState = customerSortStateMap.getKeyFromValue(value);

    await viewModel.getCustomersList(sortState: sortState);
  }

  // [コールバック：キーワード検索時]
  _onKeyWordSearch(BuildContext context, String searchWord) async {
    final viewModel =
        Provider.of<CustomersListViewModel>(context, listen: false);

    await viewModel.getCustomersList(searchWord: searchWord);
  }
}
