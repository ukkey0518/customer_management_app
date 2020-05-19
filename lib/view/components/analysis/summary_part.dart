import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';

class SummaryPart extends StatelessWidget {
  SummaryPart({
    @required this.visitHistories,
  });

  final List<VisitHistory> visitHistories;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          //TODO 売上金額集計
          Container(),
          //TODO 男女人数
          //TODO 来店人数集計(新規orワンリピorリピ)
          //TODO 新規内訳
          //TODO ワンリピ内訳
          //TODO リピート内訳
          //TODO カテゴリ別集計
        ],
      ),
    );
  }
}
