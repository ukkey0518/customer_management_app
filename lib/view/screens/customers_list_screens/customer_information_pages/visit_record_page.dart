import 'package:customermanagementapp/view/components/search_bar.dart';
import 'package:flutter/material.dart';

class VisitRecordPage extends StatefulWidget {
  @override
  _VisitRecordPageState createState() => _VisitRecordPageState();
}

class _VisitRecordPageState extends State<VisitRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SearchBar(),
      ],
    );
  }
}
