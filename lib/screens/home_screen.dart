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

  // 初期化[リスト更新]
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
        backgroundColor: Colors.orangeAccent,
        tooltip: '新規登録',
        onPressed: () => _startEditScreen(EditState.ADD),
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
                    onTap: () => _startEditScreen(
                      EditState.EDIT,
                      customer: _customersList[index],
                    ),
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

  // EditScreenへ遷移する処理(登録or編集で分岐)
  _startEditScreen(EditState state, {Customer customer}) {
    var editScreen;
    if (state == EditState.ADD) {
      editScreen = EditScreen(state: EditState.ADD);
    } else {
      editScreen = EditScreen(state: EditState.EDIT, customer: customer);
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => editScreen,
      ),
    );
  }

  // 長押しでデータを削除する処理
  _onListItemLongPress(Customer customer) async {
    await database.deleteCustomer(customer);
    _getCustomersList();
    Toast.show('削除しました。', context);
  }

  // ポップアップメニュー選択時の処理
  _onPopupMenuSelected(entry) async {
    switch (entry) {
      case '女性':
        _customersList = await database.femaleCustomers;
        break;
      case '男性':
        _customersList = await database.maleCustomers;
        break;
      default:
        _getCustomersList();
        break;
    }
    setState(() {});
  }
}
