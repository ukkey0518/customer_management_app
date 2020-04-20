import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/list_status.dart';
import 'package:customermanagementapp/screens/customers_list_screens/customers_list_screen.dart';
import 'package:customermanagementapp/src/my_custom_route.dart';
import 'package:flutter/material.dart';

import '../customer_edit_screen.dart';
import 'basic_information_page.dart';
import 'visit_record_page.dart';

class CustomerInformationScreen extends StatefulWidget {
  final customer;
  final ListScreenPreferences pref;

  CustomerInformationScreen(this.pref, {this.customer});

  @override
  _CustomerInformationScreenState createState() =>
      _CustomerInformationScreenState();
}

class _CustomerInformationScreenState extends State<CustomerInformationScreen> {
  Customer _customer;
  ListScreenPreferences _pref;
  final _tabs = <Tab>[
    Tab(text: '基本情報', icon: Icon(Icons.account_circle)),
    Tab(text: '来店記録', icon: Icon(Icons.shopping_cart)),
  ];

  @override
  void initState() {
    super.initState();
    _customer = widget.customer;
    _pref = widget.pref;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _finishInfoScreen(context),
      child: DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text('顧客情報'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => _finishInfoScreen(context),
            ),
            bottom: TabBar(tabs: _tabs),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => _editCustomer(_customer),
              )
            ],
          ),
          body: TabBarView(
            children: <Widget>[
              BasicInformationPage(
                customer: _customer,
              ),
              VisitRecordPage(),
            ],
          ),
        ),
      ),
    );
  }

  // [コールバック：編集ボタンタップ]
  // →表示中の顧客情報を編集する
  _editCustomer(Customer customer) {
    Navigator.pushReplacement(
      context,
      MyCustomRoute(
        builder: (context) => CustomerEditScreen(
          _pref,
          customer: customer,
        ),
      ),
    );
  }

  // [コールバック：画面終了時]
  Future<bool> _finishInfoScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MyCustomRoute(
        builder: (context) => CustomersListScreen(pref: widget.pref),
      ),
    );
    return Future.value(false);
  }
}
