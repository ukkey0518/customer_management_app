import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/sales_summary_cards/gender_breakdown_card.dart';
import 'package:flutter/material.dart';

class GenderSummaryPage extends StatefulWidget {
  GenderSummaryPage({
    @required this.allVisitHistories,
    @required this.vhList,
  });

  final List<VisitHistory> allVisitHistories;
  final List<VisitHistory> vhList;

  @override
  _GenderSummaryPageState createState() => _GenderSummaryPageState();
}

class _GenderSummaryPageState extends State<GenderSummaryPage> {
  @override
  Widget build(BuildContext context) {
    print(
        'male: ${widget.allVisitHistories.getMaleVisitors(widget.vhList).values.map(
      (vhList) {
        return vhList.map((vh) {
          return vh.customerJson.toCustomer().isGenderFemale;
        });
      },
    )}');

    print(
      'female: ${widget.allVisitHistories.getFemaleVisitors(widget.vhList).values.map(
        (vhList) {
          return vhList.map((vh) {
            return vh.customerJson.toCustomer().isGenderFemale;
          });
        },
      )}',
    );

    return Container(
      child: Expanded(
        child: ListView(
          children: <Widget>[
            GenderBreakDownCard(
              maleVisitorsData:
                  widget.allVisitHistories.getMaleVisitors(widget.vhList),
              femaleVisitorsData:
                  widget.allVisitHistories.getFemaleVisitors(widget.vhList),
            ),
          ],
        ),
      ),
    );
  }
}
