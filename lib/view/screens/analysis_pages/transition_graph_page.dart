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
    //TODO UI実装
    return Center(
      child: Text('推移グラフページ'),
    );
  }
}
