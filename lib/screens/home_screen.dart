import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/screens/edit_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Customer> _customersList = List();
  Customer _selectedCustomer =
      Customer(id: null, name: '', nameReading: '', gender: '');

  @override
  void initState() {
    super.initState();
    _getCustomersList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('顧客管理アプリ'),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.sort),
            onSelected: (entry) => print(entry),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: "1",
                child: Text('選択1'),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.orangeAccent,
        tooltip: '新規登録',
        onPressed: _startEditScreen,
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
                    title: Text('${_customersList[index].name}'),
                    subtitle: Text('${_customersList[index].nameReading}'),
                    onTap: () => _customersListItemSelected(index),
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
                  _selectedCustomer.nameReading,
                  style: TextStyle(color: Colors.white70),
                ),
                Text(
                  _selectedCustomer.name,
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
                _selectedCustomer.gender,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              )),
        ],
      ),
    );
  }

  _startEditScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(),
      ),
    );
  }

  _getCustomersList() async {
    _customersList = await database.allCustomers;
    setState(() {});
  }

  _customersListItemSelected(int index) {
    setState(() {
      _selectedCustomer = _customersList[index];
    });
  }
}
