import 'package:customermanagementapp/data/drop_down_menu_items.dart';
import 'package:customermanagementapp/db/dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/list_status.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/view/components/customers_list_view.dart';
import 'package:customermanagementapp/view/components/my_drawer.dart';
import 'package:customermanagementapp/view/components/search_bar.dart';
import 'package:customermanagementapp/view/screens/customers_list_screens/customer_edit_screen.dart';
import 'package:customermanagementapp/util/my_custom_route.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'customer_information_pages/customer_information_screen.dart';

class CustomersListScreen extends StatefulWidget {
  final CustomerListScreenPreferences pref;

  CustomersListScreen({this.pref});

  @override
  _CustomersListScreenState createState() => _CustomersListScreenState();
}

class _CustomersListScreenState extends State<CustomersListScreen> {
  List<Customer> _customersList = List();
  TextEditingController _searchNameFieldController = TextEditingController();
  CustomerNarrowState _narrowState = CustomerNarrowState.ALL;
  CustomerSortState _sortState = CustomerSortState.REGISTER_OLD;
  String _narrowDropdownSelectedValue = '';
  String _sortDropdownSelectedValue = '';

  final dao = MyDao(database);

  @override
  void initState() {
    print(customerNarrowMenuItems);
    super.initState();
    _narrowDropdownSelectedValue = customerNarrowMenuItems[0];
    _sortDropdownSelectedValue = customerSortMenuItems[0];
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
    switch (_narrowState) {
      case CustomerNarrowState.ALL:
        _narrowDropdownSelectedValue = customerNarrowMenuItems[0];
        break;
      case CustomerNarrowState.FEMALE:
        _narrowDropdownSelectedValue = customerNarrowMenuItems[1];
        break;
      case CustomerNarrowState.MALE:
        _narrowDropdownSelectedValue = customerNarrowMenuItems[2];
        break;
      default:
        _narrowDropdownSelectedValue = customerNarrowMenuItems[0];
    }
    // 並べ替えメニュー選択中項目を設定
    switch (_sortState) {
      case CustomerSortState.REGISTER_OLD:
        _sortDropdownSelectedValue = customerSortMenuItems[0];
        break;
      case CustomerSortState.REGISTER_NEW:
        _sortDropdownSelectedValue = customerSortMenuItems[1];
        break;
      case CustomerSortState.NAME_FORWARD:
        _sortDropdownSelectedValue = customerSortMenuItems[2];
        break;
      case CustomerSortState.NAME_REVERSE:
        _sortDropdownSelectedValue = customerSortMenuItems[3];
        break;
      default:
        _sortDropdownSelectedValue = customerSortMenuItems[0];
    }

    // DB取得処理
    _customersList = await dao.getCustomers(
        narrowState: _narrowState, sortState: _sortState);

    // 検索条件
    if (_searchNameFieldController.text.isNotEmpty) {
      _customersList.removeWhere((customer) {
        return !(customer.name.contains(_searchNameFieldController.text) ||
            customer.nameReading.contains(_searchNameFieldController.text));
      });
    }
    setState(() {});
  }

  // [絞り込み状態変更：現在の絞り込みステータスを変更して更新する]
  _setNarrowState(CustomerNarrowState narrowState) {
    _narrowState = narrowState;
    _reloadCustomersList();
  }

  // [ソート状態変更：現在のソートステータスを変更して更新する]
  _setSortState(CustomerSortState sortState) {
    _sortState = sortState;
    _reloadCustomersList();
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
        onPressed: () => _addCustomer(),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: <Widget>[
          SearchBar(
            numberOfCustomers: _customersList.length,
            narrowMenu: NarrowDropDownMenu(
              items: customerNarrowMenuItems,
              selectedValue: _narrowDropdownSelectedValue,
              onSelected: (value) => _narrowMenuSelected(value),
            ),
            sortMenu: SortDropDownMenu(
              items: customerSortMenuItems,
              selectedValue: _sortDropdownSelectedValue,
              onSelected: (value) => _sortMenuSelected(value),
            ),
            searchMenu: SearchMenu(
              searchNameController: _searchNameFieldController,
              onChanged: (_) => _reloadCustomersList(),
            ),
          ),
          Divider(),
          CustomersListView(
            customers: _customersList,
            onItemTap: (customer) => _showCustomer(customer),
            onItemLongPress: (customer) => _deleteCustomer(customer),
          ),
        ],
      ),
    );
  }

  // [コールバック：FABタップ]
  // →新しい顧客情報を登録する
  _addCustomer() {
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
  _showCustomer(Customer customer) {
    Navigator.pushReplacement(
      context,
      MyCustomRoute(
        builder: (context) => CustomerInformationScreen(
          CustomerListScreenPreferences(
            narrowState: _narrowState,
            sortState: _sortState,
            searchWord: _searchNameFieldController.text,
          ),
          customer: customer,
        ),
      ),
    );
  }

  // [コールバック：リストアイテム長押し]
  // →長押ししたアイテムを削除する
  _deleteCustomer(Customer customer) async {
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
    switch (value) {
      case '女性のみ':
        // 女性のみデータを抽出
        _setNarrowState(CustomerNarrowState.FEMALE);
        break;
      case '男性のみ':
        // 男性のみデータを抽出
        _setNarrowState(CustomerNarrowState.MALE);
        break;
      default:
        // すべてのCustomerを抽出して更新
        _setNarrowState(CustomerNarrowState.ALL);
        break;
    }
  }

  // [コールバック：ソートメニューアイテム選択時]
  // →各項目ごとにソート
  _sortMenuSelected(String value) async {
    switch (value) {
      case '登録順(新)':
        // 新規登録が新しい順に並び替え
        _setSortState(CustomerSortState.REGISTER_NEW);
        break;
      case '登録順(古)':
        // 新規登録が新しい順に並び替え
        _setSortState(CustomerSortState.REGISTER_OLD);
        break;
      case '名前順':
        // 名前順に並び替え
        _setSortState(CustomerSortState.NAME_FORWARD);
        break;
      case '名前逆順':
        // 名前逆順に並び替え
        _setSortState(CustomerSortState.NAME_REVERSE);
        break;
    }
  }
}
