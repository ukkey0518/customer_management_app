import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/list_status.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/components/customer_list_card.dart';
import 'package:customermanagementapp/components/my_drawer.dart';
import 'package:customermanagementapp/screens/customers_list_screens/customer_edit_screen.dart';
import 'package:customermanagementapp/src/my_custom_route.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'customer_information_pages/customer_information_screen.dart';

class CustomersListScreen extends StatefulWidget {
  final ListScreenPreferences pref;

  CustomersListScreen({this.pref});

  @override
  _CustomersListScreenState createState() => _CustomersListScreenState();
}

class _CustomersListScreenState extends State<CustomersListScreen> {
  List<Customer> _customersList = List();
  TextEditingController _searchNameFieldController = TextEditingController();
  ListNarrowState _narrowState = ListNarrowState.ALL;
  ListSortState _sortState = ListSortState.REGISTER_OLD;
  List<String> _narrowDropdownMenuItems = List();
  List<String> _sortDropdownMenuItems = List();
  String _narrowDropdownSelectedValue = '';
  String _sortDropdownSelectedValue = '';

  @override
  void initState() {
    super.initState();
    _narrowDropdownMenuItems = ['すべて', '女性のみ', '男性のみ'];
    _sortDropdownMenuItems = ['登録順(古)', '登録順(新)', '名前順', '名前逆順'];
    _narrowDropdownSelectedValue = _narrowDropdownMenuItems[0];
    _sortDropdownSelectedValue = _sortDropdownMenuItems[0];
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
    // 絞り込み条件
    switch (_narrowState) {
      case ListNarrowState.ALL:
        _narrowDropdownSelectedValue = _narrowDropdownMenuItems[0];
        _customersList = await database.allCustomers;
        break;
      case ListNarrowState.FEMALE:
        _narrowDropdownSelectedValue = _narrowDropdownMenuItems[1];
        _customersList = await database.femaleCustomers;
        break;
      case ListNarrowState.MALE:
        _narrowDropdownSelectedValue = _narrowDropdownMenuItems[2];
        _customersList = await database.maleCustomers;
        break;
      default:
        _narrowDropdownSelectedValue = _narrowDropdownMenuItems[0];
        _customersList = await database.allCustomers;
    }
    // 検索条件
    if (_searchNameFieldController.text.isNotEmpty) {
      _customersList.removeWhere((customer) {
        return !(customer.name.contains(_searchNameFieldController.text) ||
            customer.nameReading.contains(_searchNameFieldController.text));
      });
    }
    // 並べ替え条件
    switch (_sortState) {
      case ListSortState.REGISTER_OLD:
        _sortDropdownSelectedValue = _sortDropdownMenuItems[0];
        _customersList.sort((a, b) => a.id - b.id);
        break;
      case ListSortState.REGISTER_NEW:
        _sortDropdownSelectedValue = _sortDropdownMenuItems[1];
        _customersList.sort((a, b) => b.id - a.id);
        break;
      case ListSortState.NAME_FORWARD:
        _sortDropdownSelectedValue = _sortDropdownMenuItems[2];
        _customersList.sort((a, b) => a.nameReading.compareTo(b.nameReading));
        break;
      case ListSortState.NAME_REVERSE:
        _sortDropdownSelectedValue = _sortDropdownMenuItems[3];
        _customersList.sort((a, b) => b.nameReading.compareTo(a.nameReading));
        break;
      default:
        _sortDropdownSelectedValue = _sortDropdownMenuItems[0];
        _customersList.sort((a, b) => a.id - b.id);
    }
    setState(() {});
  }

  // [絞り込み状態変更：現在の絞り込みステータスを変更して更新する]
  _setNarrowState(ListNarrowState narrowState) {
    _narrowState = narrowState;
    _reloadCustomersList();
  }

  // [ソート状態変更：現在のソートステータスを変更して更新する]
  _setSortState(ListSortState sortState) {
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
          _menuBarPart(),
          Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemBuilder: (context, index) => _customersListItemPart(index),
                itemCount: _customersList.length,
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
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: '検索結果：'),
                    TextSpan(
                      text: '${_customersList.length}',
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
          TextField(
            keyboardType: TextInputType.text,
            controller: _searchNameFieldController,
            decoration: InputDecoration(
              hintText: '名前で検索',
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => _searchNameFieldController.clear(),
              ),
            ),
            onEditingComplete: () => _reloadCustomersList(),
          ),
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
  Widget _customersListItemPart(int index) {
    var customer = _customersList[index];
    return CustomerListCard(
      customer: customer,
      onTap: () => _showCustomer(customer),
      onLongPress: () => _deleteCustomer(customer),
    );
  }

  // [コールバック：FABタップ]
  // →新しい顧客情報を登録する
  _addCustomer() {
    Navigator.pushReplacement(
      context,
      MyCustomRoute(
        builder: (context) => CustomerEditScreen(
          ListScreenPreferences(
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
          ListScreenPreferences(
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
    await database.deleteCustomer(customer);
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
        _setNarrowState(ListNarrowState.FEMALE);
        break;
      case '男性のみ':
        // 男性のみデータを抽出
        _setNarrowState(ListNarrowState.MALE);
        break;
      default:
        // すべてのCustomerを抽出して更新
        _setNarrowState(ListNarrowState.ALL);
        break;
    }
  }

  // [コールバック：ソートメニューアイテム選択時]
  // →各項目ごとにソート
  _sortMenuSelected(String value) async {
    switch (value) {
      case '登録順(新)':
        // 新規登録が新しい順に並び替え
        _setSortState(ListSortState.REGISTER_NEW);
        break;
      case '登録順(古)':
        // 新規登録が新しい順に並び替え
        _setSortState(ListSortState.REGISTER_OLD);
        break;
      case '名前順':
        // 名前順に並び替え
        _setSortState(ListSortState.NAME_FORWARD);
        break;
      case '名前逆順':
        // 名前逆順に並び替え
        _setSortState(ListSortState.NAME_REVERSE);
        break;
    }
  }
}
