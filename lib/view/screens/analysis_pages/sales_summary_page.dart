import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';

class SalesSummaryPage extends StatefulWidget {
  SalesSummaryPage({@required this.visitHistories});

  final List<VisitHistory> visitHistories;

  @override
  _SalesSummaryPageState createState() => _SalesSummaryPageState();
}

class _SalesSummaryPageState extends State<SalesSummaryPage> {
  @override
  Widget build(BuildContext context) {
    //TODO UI実装
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              '売上集計ページ',
              style: TextStyle(fontSize: 20),
            ),
            Text('${widget.visitHistories}'),
          ],
        ),
      ),
    );
  }
}
