import 'package:customermanagementapp/viewmodel/customer_information_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../customer_edit_screen.dart';
import 'basic_information_page.dart';
import 'visit_record_page.dart';

class CustomerInformationScreen extends StatelessWidget {
  CustomerInformationScreen({@required this.customerId});

  final int customerId;

  final _tabs = <Tab>[
    Tab(text: '基本情報', icon: Icon(Icons.account_circle)),
    Tab(text: '来店履歴', icon: Icon(Icons.shopping_cart)),
  ];

  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<CustomerInformationViewModel>(context, listen: false);

    Future(() {
      viewModel.getVHBC(id: customerId);
    });

    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('顧客情報'),
          bottom: TabBar(tabs: _tabs),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _editCustomer(context),
            )
          ],
        ),
        body: Consumer<CustomerInformationViewModel>(
            builder: (context, viewModel, child) {
          return TabBarView(
            children: <Widget>[
              BasicInformationPage(
                vhbc: viewModel.vhbc,
              ),
              VisitRecordPage(),
            ],
          );
        }),
      ),
    );
  }

  // [コールバック：編集ボタンタップ]
  // →表示中の顧客情報を編集する
  _editCustomer(BuildContext context) {
    final viewModel =
        Provider.of<CustomerInformationViewModel>(context, listen: false);

    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) {
          return CustomerEditScreen(
            viewModel.customers,
            customer: viewModel.vhbc.customer,
          );
        },
        fullscreenDialog: true,
      ),
    )
        .then((customer) async {
      if (customer != null) {
        await viewModel.addCustomer(customer);
        Toast.show('更新されました。', context);
      }
    });
  }
}
