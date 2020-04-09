import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/screens/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Customer> _customersList = List();

  @override
  void initState() {
    super.initState();
    _getCustomersList();
  }

  // リスト初期化
  _getCustomersList() async {
    _customersList = await database.allCustomers;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('顧客管理アプリ'),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.sort),
            onSelected: (entry) => _onPopupMenuSelected(entry),
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
                    onLongPress: () => _onListItemLongPress(
                      _customersList[index],
                    ),
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

  // [FABタップコールバック]
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

  // [リストタップコールバック]
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

  // [リスト長押しコールバック]
  // →長押ししたアイテムを削除する
  _onListItemLongPress(Customer customer) async {
    // DBから指定のCustomerを削除
    await database.deleteCustomer(customer);
    // すべてのCustomerを抽出して更新
    _getCustomersList();
    // トースト表示
    Toast.show('削除しました。', context);
  }

  // [ポップアップメニュー選択時の処理]
  // →各項目ごとに絞り込み
  _onPopupMenuSelected(String entry) async {
    switch (entry) {
      case '女性':
        // 女性のみデータを抽出
        _customersList = await database.femaleCustomers;
        break;
      case '男性':
        // 男性のみデータを抽出
        _customersList = await database.maleCustomers;
        break;
      default:
        // すべてのCustomerを抽出して更新
        _getCustomersList();
        break;
    }
    // リスト更新
    setState(() {});
  }
}
