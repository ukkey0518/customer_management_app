import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/custom_cards/visit_history_list_card.dart';
import 'package:customermanagementapp/view/screens/visit_history_screens/visit_history_edit_screen.dart';
import 'package:flutter/material.dart';

class VisitHistoryPage extends StatefulWidget {
  VisitHistoryPage({this.vhbc});

  final VisitHistoriesByCustomer vhbc;

  @override
  _VisitHistoryPageState createState() => _VisitHistoryPageState();
}

class _VisitHistoryPageState extends State<VisitHistoryPage> {
  List<VisitHistory> _visitHistories = List();

  bool setStateFlag = false;

  @override
  void initState() {
    if (widget.vhbc != null) {
      _visitHistories = widget.vhbc.histories;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (setStateFlag) setStateFlag = false;
    });
    if (!setStateFlag) {
      _visitHistories = widget.vhbc.histories;
    }
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: List<Widget>.generate(_visitHistories.length, (index) {
              return VisitHistoryListCard(
                visitHistory: _visitHistories[index],
                onTap: (_) =>
                    _editVisitHistory(context, _visitHistories[index]),
                onLongPress: null,
              );
            }),
          ),
        ),
      ],
    );
  }

  _editVisitHistory(BuildContext context, VisitHistory visitHistory) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return VisitHistoryEditScreen(visitHistory: visitHistory);
        },
      ),
    ).then((value) {
      setState(() => _visitHistories = widget.vhbc.histories);
    });
  }
}
