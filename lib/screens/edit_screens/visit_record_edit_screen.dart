import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/screens/visit_record_list_screens/visit_record_list_screen.dart';
import 'package:flutter/material.dart';

enum VisitRecordEditState { ADD, EDIT }

class VisitRecordEditScreen extends StatefulWidget {
  final VisitRecordListScreenPreferences pref;
  final VisitRecordEditState state;

  VisitRecordEditScreen(this.pref, {this.state});
  @override
  _VisitRecordEditScreenState createState() => _VisitRecordEditScreenState();
}

class _VisitRecordEditScreenState extends State<VisitRecordEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
