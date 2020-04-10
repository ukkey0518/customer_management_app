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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _profilePart(),
          _recordPart(),
        ],
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
          '顧客情報',
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
    return Container();
  }
}
