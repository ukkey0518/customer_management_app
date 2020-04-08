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
          Column(),
          Expanded(
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('${_customersList[index].name}'),
                  subtitle: Text('${_customersList[index].nameReading}'),
                  onTap: () => _customersListItemSelected(index),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemCount: _customersList.length,
            ),
          ),
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

  void _getCustomersList() async {
    _customersList = await database.allCustomers;
    setState(() {});
  }

  _customersListItemSelected(int index) {
    setState(() {
      _selectedCustomer = _customersList[index];
    });
    print(_selectedCustomer.name); //TODO: 反映処理書いたら削除OK
  }
}
