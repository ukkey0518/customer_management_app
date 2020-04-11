import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/screens/visit_record_list_screens/visit_record_list_screen.dart';
import 'package:flutter/material.dart';

class VisitRecordInformationScreen extends StatefulWidget {
  final VisitRecordListScreenPreferences pref;
  final Customer visitRecord;

  VisitRecordInformationScreen(this.pref, {this.visitRecord});
  @override
  _VisitRecordInformationScreenState createState() =>
      _VisitRecordInformationScreenState();
}

class _VisitRecordInformationScreenState
    extends State<VisitRecordInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
