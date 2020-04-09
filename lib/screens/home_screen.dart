import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/screens/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

enum NarrowState { ALL, FEMALE, MALE }

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Customer> _customersList = List();
  NarrowState _narrowState = NarrowState.ALL;

  @override
  void initState() {
    super.initState();
    _reloadCustomersList();
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
    setState(() {});
  }

  // [絞り込み状態変更：現在の絞り込みステータスを変更して更新する]
  _setNarrowState(NarrowState narrowState) {
    _narrowState = narrowState;
    _reloadCustomersList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('顧客管理アプリ'),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.sort),
            onSelected: (entry) => _narrowMenuSelected(entry),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: "女性",
                child: Text('女性のみ'),
              ),
              const PopupMenuItem<String>(
                value: "男性",
                child: Text('男性のみ'),
              ),
              const PopupMenuItem<String>(
                value: "全員",
                child: Text('すべて'),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: '新規登録',
        onPressed: () => _addCustomer(),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
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
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemCount: _customersList.length,
              ),
            ),
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

  // [コールバック：絞り込みポップアップメニュー選択時]
  // →各項目ごとに絞り込み
  _narrowMenuSelected(String entry) async {
    switch (entry) {
      case '女性':
        // 女性のみデータを抽出
        _setNarrowState(NarrowState.FEMALE);
        break;
      case '男性':
        // 男性のみデータを抽出
        _setNarrowState(NarrowState.MALE);
        break;
      default:
        // すべてのCustomerを抽出して更新
        _setNarrowState(NarrowState.ALL);
        break;
    }
  }
}
