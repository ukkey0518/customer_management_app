import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:flutter/material.dart';

class SSPTotalPart extends StatelessWidget {
  SSPTotalPart({
    @required this.vhList,
  });

  final List<VisitHistory> vhList;

  @override
  Widget build(BuildContext context) {
    final int totalNumOfVisitors = vhList.length;
    final int totalPrice = vhList.toSumPriceList().getSum();
    final double averagePrice = vhList.toSumPriceList().getAverage();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      '総客数',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '総売上',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '平均単価',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${totalNumOfVisitors.toString()} 人',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${totalPrice.toPriceString()}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${averagePrice.toPriceString(1)}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getDivider(bool isEnd) {
    return isEnd ? Container() : Divider();
  }
}
