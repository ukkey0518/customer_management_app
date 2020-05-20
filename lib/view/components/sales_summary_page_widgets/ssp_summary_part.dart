import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:flutter/material.dart';

class SSPTotalPart extends StatelessWidget {
  SSPTotalPart({this.dataMap});

  final Map<String, int> dataMap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          '総来店人数',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          dataMap['総来店人数'].toString(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          '総売上金額',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          dataMap['総売上金額'].toPriceString(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget getDivider(bool isEnd) {
    return isEnd ? Container() : Divider();
  }
}
