import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';

import '../../customer_edit_screen.dart';
import 'basic_information_page.dart';
import 'visit_record_page.dart';

class CustomerInformationScreen extends StatelessWidget {
  CustomerInformationScreen(this.customers, {this.vhbc});

  final VisitHistoriesByCustomer vhbc;
  final List<Customer> customers;

  final _tabs = <Tab>[
    Tab(text: '基本情報', icon: Icon(Icons.account_circle)),
    Tab(text: '来店履歴', icon: Icon(Icons.shopping_cart)),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('顧客情報'),
          bottom: TabBar(tabs: _tabs),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _editCustomer(context, vhbc.customer),
            )
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            BasicInformationPage(
              historiesByCustomer: vhbc,
            ),
            VisitRecordPage(),
          ],
        ),
      ),
    );
  }

  // [コールバック：編集ボタンタップ]
  // →表示中の顧客情報を編集する
  _editCustomer(BuildContext context, Customer customer) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CustomerEditScreen(
          customers,
          customer: vhbc.customer,
        ),
      ),
    );
  }
}
