import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/polymorphism/basic_list_view_item.dart';
import 'package:flutter/material.dart';
import '../customer_information_panel.dart';
import '../customer_name_panel.dart';

class CustomerListItem extends BasicListViewItem<Customer> {
  CustomerListItem({
    @required Customer customer,
    ValueChanged onTap,
    ValueChanged onLongPress,
  }) : super(item: customer, onTap: onTap, onLongPress: onLongPress);

  @override
  Widget build(BuildContext context) {
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
                CustomerNamePanel(customer: item),
                Divider(),
                CustomerInformationPanel(
                  numberOfVisits: 1,
                  lastVisitDate: DateTime.now(),
                  personInCharge: Employee(id: null, name: 'うっき'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
