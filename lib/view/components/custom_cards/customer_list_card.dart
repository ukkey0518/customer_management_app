import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/data/enums/date_format_mode.dart';
import 'package:customermanagementapp/util/extensions/convert_from_string.dart';
import 'package:customermanagementapp/util/extensions/convert_from_visit_history_list.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/custom_cards/list_view_card.dart';
import 'package:customermanagementapp/view/components/custom_cards/card_parts/customer_name_parts.dart';
import 'package:customermanagementapp/view/components/custom_cards/card_parts/simple_table_item.dart';
import 'package:flutter/material.dart';

class CustomerListCard extends ListViewCard<VisitHistoriesByCustomer> {
  CustomerListCard({
    @required VisitHistoriesByCustomer visitHistoriesByCustomer,
    ValueChanged<VisitHistoriesByCustomer> onTap,
    ValueChanged<VisitHistoriesByCustomer> onLongPress,
  }) : super(
          item: visitHistoriesByCustomer,
          onTap: onTap,
          onLongPress: onLongPress,
        );

  @override
  Widget build(BuildContext context) {
    var customer = item.customer;
    var histories = item.histories;
    var lastVisitHistory = histories.getLastVisitHistory();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        child: InkWell(
          onTap: () => onTap(item),
          onLongPress: () => onLongPress(item),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                CustomerNameParts(customer: customer),
                Divider(),
                Table(
                  children: <TableRow>[
                    TableRow(
                      children: <Widget>[
                        SimpleTableItem(
                          titleText: '来店回数',
                          contentText: histories != null
                              ? histories.length.toString()
                              : 0,
                        ),
                        SimpleTableItem(
                          titleText: '最終来店日',
                          contentText: lastVisitHistory?.date != null
                              ? lastVisitHistory.date
                                  .toFormatStr(DateFormatMode.FULL)
                              : '--',
                        ),
                        SimpleTableItem(
                          titleText: '担当',
                          contentText:
                              lastVisitHistory?.employeeJson?.toEmployee() !=
                                      null
                                  ? lastVisitHistory?.employeeJson
                                      ?.toEmployee()
                                      ?.name
                                  : '--',
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
