import 'package:customermanagementapp/parts/my_drawer.dart';
import 'package:flutter/material.dart';

class VisitRecordListScreen extends StatefulWidget {
  @override
  _VisitRecordListScreenState createState() => _VisitRecordListScreenState();
}

class _VisitRecordListScreenState extends State<VisitRecordListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('来店記録一覧'),
      ),
      drawer: MyDrawer(),
    );
  }
}
