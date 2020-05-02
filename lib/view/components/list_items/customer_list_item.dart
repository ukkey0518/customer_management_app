import 'package:customermanagementapp/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/util/extensions.dart';
import 'package:customermanagementapp/view/components/polymorphism/basic_list_view_item.dart';
import 'package:flutter/material.dart';
import '../customer_information_panel.dart';
import '../customer_name_panel.dart';

class CustomerListItem extends BasicListViewItem<VisitHistoriesByCustomer> {
  CustomerListItem({
    @required VisitHistoriesByCustomer visitHistoriesByCustomer,
    ValueChanged onTap,
    ValueChanged onLongPress,
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
                CustomerNamePanel(customer: customer),
                Divider(),
                CustomerInformationPanel(
                  numberOfVisits: histories?.length,
                  lastVisitDate: lastVisitHistory?.date,
                  personInCharge: lastVisitHistory?.employeeJson?.toEmployee(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
