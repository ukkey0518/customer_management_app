import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/screens/visit_record_list_screens/visit_record_list_screen.dart';
import 'package:flutter/material.dart';

class VisitRecordInformationScreen extends StatefulWidget {
  final VisitRecordListScreenPreferences pref;
  final SalesMenuRecord visitRecord;

  VisitRecordInformationScreen(this.pref, {this.visitRecord});
  @override
  _VisitRecordInformationScreenState createState() =>
      _VisitRecordInformationScreenState();
}

class _VisitRecordInformationScreenState
    extends State<VisitRecordInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _finishScreen,
      child: Scaffold(
        appBar: AppBar(),
        body: Container(),
      ),
    );
  }

  Future<bool> _finishScreen() async {
    var customer = await database.getCustomersById(1);
    Navigator.of(context).pop(customer);
    return Future.value(false);
  }
}
