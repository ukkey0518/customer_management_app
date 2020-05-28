import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';

class TransitionGraphPage extends StatefulWidget {
  TransitionGraphPage({@required this.visitHistories});

  final List<VisitHistory> visitHistories;

  @override
  _TransitionGraphPageState createState() => _TransitionGraphPageState();
}

class _TransitionGraphPageState extends State<TransitionGraphPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              '推移グラフページ',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
