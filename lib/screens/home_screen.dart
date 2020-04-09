import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/screens/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

enum NarrowState { ALL, FEMALE, MALE }
enum SortState { REGISTER_NEW, REGISTER_OLD, NAME }

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Customer> _customersList = List();
  NarrowState _narrowState = NarrowState.ALL;
  SortState _sortState = SortState.REGISTER_OLD;
  TextEditingController _searchNameFieldController = TextEditingController();
  List<String> _narrowDropdownMenuItems = List();
  String _narrowDropdownSelectedValue = '';
  List<String> _sortDropdownMenuItems = List();
  String _sortDropdownSelectedValue = '';

  @override
  void initState() {
    super.initState();
    _reloadCustomersList();
    _narrowDropdownMenuItems = ['すべて', '女性のみ', '男性のみ'];
    _narrowDropdownSelectedValue = _narrowDropdownMenuItems[0];
    _sortDropdownMenuItems = ['登録が古い順', '登録が新しい順', '名前順'];
    _sortDropdownSelectedValue = _sortDropdownMenuItems[0];
  }

  // [リスト更新処理：指定の条件でリストを更新する]
  _reloadCustomersList() async {
    // 絞り込み条件
    switch (_narrowState) {
      case NarrowState.ALL:
        _customersList = await database.allCustomers;
        break;
      case NarrowState.FEMALE:
        _customersList = await database.femaleCustomers;
        break;
      case NarrowState.MALE:
        _customersList = await database.maleCustomers;
        break;
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
      case SortState.REGISTER_OLD:
        _customersList.sort((a, b) => a.id - b.id);
        break;
      case SortState.REGISTER_NEW:
        _customersList.sort((a, b) => b.id - a.id);
        break;
      case SortState.NAME:
        _customersList.sort((a, b) => b.nameReading.compareTo(b.nameReading));
        break;
    }
    setState(() {});
  }

  // [絞り込み状態変更：現在の絞り込みステータスを変更して更新する]
  _setNarrowState(NarrowState narrowState) {
    _narrowState = narrowState;
    _reloadCustomersList();
  }

  // [ソート状態変更：現在のソートステータスを変更して更新する]
  _setSortState(SortState sortState) {
    _sortState = sortState;
    _reloadCustomersList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('顧客管理アプリ'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: '新規登録',
        onPressed: () => _addCustomer(),
      ),
      body: Column(
        children: <Widget>[
          _menuBarPart(),
          Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                itemBuilder: (context, index) => _customersListItemPart(index),
                separatorBuilder: (context, index) => Divider(),
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
              Text('検索結果：${_customersList.length}件'),
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
                  width: 85,
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
                  width: 85,
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
    return ListTile(
      leading: SizedBox(
        height: double.infinity,
        child: Icon(Icons.account_circle),
      ),
      title: Text(
        '${_customersList[index].name}',
        style: TextStyle(fontSize: 20),
      ),
      onTap: () => _editCustomer(_customersList[index]),
      onLongPress: () => _deleteCustomer(_customersList[index]),
    );
  }

  // [コールバック：FABタップ]
  // →新しい顧客情報を登録する
  _addCustomer() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(
          state: EditState.ADD,
        ),
      ),
    );
  }

  // [コールバック：リストアイテムタップ]
  // →選択した顧客情報を編集する
  _editCustomer(Customer customer) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(
          state: EditState.EDIT,
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
    _narrowDropdownSelectedValue = value;
    switch (value) {
      case '女性のみ':
        // 女性のみデータを抽出
        _setNarrowState(NarrowState.FEMALE);
        break;
      case '男性のみ':
        // 男性のみデータを抽出
        _setNarrowState(NarrowState.MALE);
        break;
      default:
        // すべてのCustomerを抽出して更新
        _setNarrowState(NarrowState.ALL);
        break;
    }
  }

  // [コールバック：ソートメニューアイテム選択時]
  // →各項目ごとにソート
  _sortMenuSelected(String value) async {
    _sortDropdownSelectedValue = value;
    switch (value) {
      case '登録が新しい順':
        // 新規登録が新しい順に並び替え
        _setSortState(SortState.REGISTER_NEW);
        break;
      case '名前順':
        // 名前順に並び替え
        _setSortState(SortState.NAME);
        break;
      default:
        // 新規登録が古い順に並び替え
        _setSortState(SortState.REGISTER_OLD);
        break;
    }
  }
}
