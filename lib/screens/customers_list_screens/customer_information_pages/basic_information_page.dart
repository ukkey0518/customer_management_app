import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BasicInformationPage extends StatefulWidget {
  final Customer customer;

  BasicInformationPage({this.customer});
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
            _profilePart(),
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

  // [ウィジェット：プロフィール部分]
  Widget _profilePart() {
    var birth = _customer.birth == null
        ? '未登録'
        : DateFormat('yyyy/M/d').format(_customer.birth);
    var age = _customer.birth == null
        ? ''
        : ' (${(DateTime.now().difference(_customer.birth).inDays / 365).floor().toString()}歳)';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'プロフィール',
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
                    Expanded(child: Text('お名前')),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${_customer.nameReading}'),
                          Text('${_customer.name} 様'),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(child: Text('性別')),
                    Expanded(
                        child:
                            Text('${_customer.isGenderFemale ? '女性' : '男性'}')),
                  ],
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(child: Text('生年月日')),
                    Expanded(child: Text('${birth + age}')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
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
