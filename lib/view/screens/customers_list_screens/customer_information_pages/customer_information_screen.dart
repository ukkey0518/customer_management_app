import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/db/dao/customer_dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/view/screens/customers_list_screen.dart';
import 'package:customermanagementapp/util/my_custom_route.dart';
import 'package:flutter/material.dart';

import '../../customer_edit_screen.dart';
import 'basic_information_page.dart';
import 'visit_record_page.dart';

class CustomerInformationScreen extends StatefulWidget {
  final VisitHistoriesByCustomer historiesByCustomer;

  CustomerInformationScreen({this.historiesByCustomer});

  @override
  _CustomerInformationScreenState createState() =>
      _CustomerInformationScreenState();
}

class _CustomerInformationScreenState extends State<CustomerInformationScreen> {
  VisitHistoriesByCustomer _visitHistoriesByCustomer;

  final _tabs = <Tab>[
    Tab(text: '基本情報', icon: Icon(Icons.account_circle)),
    Tab(text: '来店履歴', icon: Icon(Icons.shopping_cart)),
  ];

  final dao = CustomerDao(database);

  @override
  void initState() {
    super.initState();
    _visitHistoriesByCustomer = widget.historiesByCustomer;
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
                onPressed: () =>
                    _editCustomer(_visitHistoriesByCustomer.customer),
              )
            ],
          ),
          body: TabBarView(
            children: <Widget>[
              BasicInformationPage(
                historiesByCustomer: _visitHistoriesByCustomer,
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
    final customer = widget.historiesByCustomer.customer;
    Navigator.pushReplacement(
      context,
      MyCustomRoute(
        builder: (context) => CustomerEditScreen(
          List(),
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
        builder: (context) => CustomersListScreen(),
      ),
    );
    return Future.value(false);
  }
}
