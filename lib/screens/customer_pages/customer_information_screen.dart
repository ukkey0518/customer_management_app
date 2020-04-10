import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../edit_screen.dart';

class CustomerInformationScreen extends StatefulWidget {
  final customer;
  final HomeScreenPreferences pref;

  CustomerInformationScreen(this.pref, {this.customer});

  @override
  _CustomerInformationScreenState createState() =>
      _CustomerInformationScreenState();
}

class _CustomerInformationScreenState extends State<CustomerInformationScreen> {
  Customer _customer;
  HomeScreenPreferences _pref;

  @override
  void initState() {
    super.initState();
    _customer = widget.customer;
    _pref = widget.pref;
  }

  @override
  Widget build(BuildContext context) {
    print(_customer);
    return WillPopScope(
      onWillPop: () => _finishInfoScreen(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('顧客情報'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => _finishInfoScreen(context),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _editCustomer(_customer),
            )
          ],
        ),
        body: Center(
          child: Text(_customer.toString()),
        ),
      ),
    );
  }

  // [コールバック：編集ボタンタップ]
  // →選択した顧客情報を編集する
  _editCustomer(Customer customer) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(
          _pref,
          state: EditState.EDIT,
          customer: customer,
        ),
      ),
    );
  }

  // [コールバック：画面終了時]
  Future<bool> _finishInfoScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(pref: widget.pref),
      ),
    );
    return Future.value(false);
  }
}
