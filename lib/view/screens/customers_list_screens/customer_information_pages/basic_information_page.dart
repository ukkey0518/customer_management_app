import 'package:customermanagementapp/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/list_card_widgets/profile_card_widget.dart';
import 'package:flutter/material.dart';

class BasicInformationPage extends StatefulWidget {
  BasicInformationPage({this.customer, this.histories});

  final Customer customer;
  final VisitHistoriesByCustomer histories;

  @override
  _BasicInformationPageState createState() => _BasicInformationPageState();
}

class _BasicInformationPageState extends State<BasicInformationPage> {
  Customer _customer;

  @override
  void initState() {
    super.initState();
    _customer = widget.customer;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ProfileCardWidget(
              name: _customer.name,
              nameReading: _customer.nameReading,
              isGenderFemale: _customer.isGenderFemale,
              birth: _customer.birth,
            ),
            SizedBox(height: 30),
            _recordPart(),
            SizedBox(height: 30),
            _priceAnalysisPart(),
            SizedBox(height: 30),
            _repeatAnalysisPart(),
          ],
        ),
      ),
    );
  }

  // [ウィジェット：記録部分]
  Widget _recordPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '来店情報',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.left,
        ),
        Card(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child: Text('来店回数')),
                    Expanded(child: Text('(未データ)')),
                  ],
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(child: Text('初回来店日')),
                    Expanded(child: Text('(未データ)')),
                  ],
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(child: Text('最終来店日')),
                    Expanded(child: Text('(未データ)')),
                  ],
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(child: Text('初回来店理由')),
                    Expanded(child: Text('(未データ)')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _repeatAnalysisPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'リピート分析',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.left,
        ),
        Card(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child: Text('１ヶ月以内リピ')),
                    Expanded(child: Text('(未データ)')),
                  ],
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(child: Text('３ヶ月以内リピ')),
                    Expanded(child: Text('(未データ)')),
                  ],
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(child: Text('それ以降リピ')),
                    Expanded(child: Text('(未データ)')),
                  ],
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(child: Text('リピートサイクル')),
                    Expanded(child: Text('(未データ)')),
                  ],
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(child: Text('次回来店予想')),
                    Expanded(child: Text('(未データ)')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _priceAnalysisPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '単価分析',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.left,
        ),
        Card(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child: Text('お支払い総額')),
                    Expanded(child: Text('(未データ)')),
                  ],
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(child: Text('平均単価')),
                    Expanded(child: Text('(未データ)')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
