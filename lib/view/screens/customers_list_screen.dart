import 'package:customermanagementapp/data/drop_down_menu_items.dart';
import 'package:customermanagementapp/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/db/dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/data/list_status.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/view/components/list_items/customer_list_item.dart';
import 'package:customermanagementapp/view/components/my_drawer.dart';
import 'package:customermanagementapp/view/components/search_bar.dart';
import 'package:customermanagementapp/view/screens/customer_edit_screen.dart';
import 'package:customermanagementapp/util/my_custom_route.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'customers_list_screens/customer_information_pages/customer_information_screen.dart';

class CustomersListScreen extends StatefulWidget {
  final CustomerListScreenPreferences pref;

  CustomersListScreen({this.pref});

  @override
  _CustomersListScreenState createState() => _CustomersListScreenState();
}

class _CustomersListScreenState extends State<CustomersListScreen> {
  List<Customer> _customersList = List();
  List<VisitHistoriesByCustomer> _visitHistoriesByCustomers;
  TextEditingController _searchNameFieldController = TextEditingController();
  CustomerNarrowState _narrowState = CustomerNarrowState.ALL;
  CustomerSortState _sortState = CustomerSortState.REGISTER_OLD;
  String _narrowDropdownSelectedValue = '';
  String _sortDropdownSelectedValue = '';

  final dao = MyDao(database);

  @override
  void initState() {
    super.initState();
    _narrowDropdownSelectedValue = customerNarrowStateMap[_narrowState];
    _sortDropdownSelectedValue = customerSortStateMap[_sortState];
    // 環境設定がある場合はそれを反映
    if (widget.pref != null) {
      _narrowState = widget.pref.narrowState;
      _sortState = widget.pref.sortState;
      _searchNameFieldController.text = widget.pref.searchWord;
    }
    _reloadCustomersList();
  }

  // [リスト更新処理：指定の条件でリストを更新する]
  _reloadCustomersList() async {
    // 絞り込みメニュー選択中項目を設定
    _narrowDropdownSelectedValue = customerNarrowStateMap[_narrowState];

    // 並べ替えメニュー選択中項目を設定
    _sortDropdownSelectedValue = customerSortStateMap[_sortState];

    // DB取得処理
    _customersList = await dao.getCustomers(
        narrowState: _narrowState, sortState: _sortState);

    // 顧客別来店履歴リスト取得
    _visitHistoriesByCustomers = await dao.getAllVisitHistoriesByCustomers();

    // 検索条件
    if (_searchNameFieldController.text.isNotEmpty) {
      _customersList.removeWhere((customer) {
        return !(customer.name.contains(_searchNameFieldController.text) ||
            customer.nameReading.contains(_searchNameFieldController.text));
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: <Widget>[
          SearchBar(
            numberOfItems: _customersList.length,
            narrowMenu: NarrowDropDownMenu(
              items: customerNarrowStateMap.values.toList(),
              selectedValue: _narrowDropdownSelectedValue,
              onSelected: (value) => _narrowMenuSelected(value),
            ),
            sortMenu: SortDropDownMenu(
              items: customerSortStateMap.values.toList(),
              selectedValue: _sortDropdownSelectedValue,
              onSelected: (value) => _sortMenuSelected(value),
            ),
            searchMenu: SearchMenu(
              searchNameController: _searchNameFieldController,
              onChanged: (_) => _reloadCustomersList(),
            ),
          ),
          Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: _customersList.length,
                itemBuilder: (context, index) {
                  final visitHistoriesByCustomer =
                      _visitHistoriesByCustomers.singleWhere(
                    (historiesByCustomer) {
                      return historiesByCustomer.customer ==
                          _customersList[index];
                    },
                  );
                  return CustomerListItem(
                    visitHistoriesByCustomer: visitHistoriesByCustomer,
                    onTap: (customer) => _showCustomer(
                        context, visitHistoriesByCustomer.customer),
                    onLongPress: (customer) => _deleteCustomer(
                        context, visitHistoriesByCustomer.customer),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // [コールバック：FABタップ]
  // →新しい顧客情報を登録する
  _addCustomer(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MyCustomRoute(
        builder: (context) => CustomerEditScreen(
          CustomerListScreenPreferences(
            narrowState: _narrowState,
            sortState: _sortState,
            searchWord: _searchNameFieldController.text,
          ),
        ),
      ),
    );
  }

  // [コールバック：リストアイテムタップ]
  // →選択した顧客情報の詳細ページへ遷移する
  _showCustomer(BuildContext context, Customer customer) async {
    final visitHistoriesByCustomer =
        await dao.getVisitHistoriesByCustomer(customer);
    Navigator.pushReplacement(
      context,
      MyCustomRoute(
        builder: (context) => CustomerInformationScreen(
          CustomerListScreenPreferences(
            narrowState: _narrowState,
            sortState: _sortState,
            searchWord: _searchNameFieldController.text,
          ),
          historiesByCustomer: visitHistoriesByCustomer,
        ),
      ),
    );
  }

  // [コールバック：リストアイテム長押し]
  // →長押ししたアイテムを削除する
  _deleteCustomer(BuildContext context, Customer customer) async {
    // DBから指定のCustomerを削除
    await dao.deleteCustomer(customer);
    // 現在の条件でリストを更新
    _reloadCustomersList();
    // トースト表示
    Toast.show('削除しました。', context);
  }

  // [コールバック：絞り込みメニューアイテム選択時]
  // →各項目ごとに絞り込み
  _narrowMenuSelected(String value) async {
    // 選択中のメニューアイテム文字列と一致するEntryを取得
    final narrowState = customerNarrowStateMap.entries
        .singleWhere((entry) => entry.value == value);
    // EntryのNarrowStatusをフィールドへ代入
    _narrowState = narrowState.key;
    // リストを更新
    _reloadCustomersList();
  }

  // [コールバック：ソートメニューアイテム選択時]
  // →各項目ごとにソート
  _sortMenuSelected(String value) async {
    // 選択中のメニューアイテム文字列と一致するEntryを取得
    final sortState = customerSortStateMap.entries
        .singleWhere((entry) => entry.value == value);
    // EntryのNarrowStatusをフィールドへ代入
    _sortState = sortState.key;
    // リストを更新
    _reloadCustomersList();
  }
}
