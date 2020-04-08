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
  Customer _selectedCustomer;

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

  // リストアイテムが選択されたときの処理
  _customersListItemSelected(int index) {
    setState(() {
      _selectedCustomer = _customersList[index];
    });
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
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white12,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 16, left: 16),
                        child: Column(
                          children: <Widget>[
                            _displaySelectedItemNamePart(),
                            Divider(),
                            _displaySelectedItemGenderPart(),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: RaisedButton(
                          child: const Text('編集'),
                          onPressed: _selectedCustomer != null
                              ? () => _startEditScreen(
                                    EditState.EDIT,
                                    customer: _selectedCustomer,
                                  )
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
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
                    onTap: () => _customersListItemSelected(index),
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

  // 選択中アイテムの名前を表示する部分
  Widget _displaySelectedItemNamePart() {
    var name;
    var nameReading;
    if (_selectedCustomer == null) {
      name = '';
      nameReading = '';
    } else {
      name = _selectedCustomer.name;
      nameReading = _selectedCustomer.nameReading;
    }
    return Expanded(
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 3,
              child: const Text(
                'お名前',
                style: TextStyle(fontSize: 16),
              )),
          Expanded(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  nameReading,
                  style: TextStyle(color: Colors.white70),
                ),
                Text(
                  name,
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 選択中アイテムの性別を表示する部分
  Widget _displaySelectedItemGenderPart() {
    var gender = _selectedCustomer == null ? '' : _selectedCustomer.gender;
    return Expanded(
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 3,
              child: const Text(
                '性別',
                style: TextStyle(fontSize: 16),
              )),
          Expanded(
              flex: 7,
              child: Text(
                gender,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              )),
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
    setState(() {
      _selectedCustomer = null;
    });
  }

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
