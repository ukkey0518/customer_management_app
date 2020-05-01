import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';

import '../list_items/customer_list_card.dart';

class CustomersListView extends StatelessWidget {
  CustomersListView({this.customers, this.onItemTap, this.onItemLongPress});

  final List<Customer> customers;
  final ValueChanged<Customer> onItemTap;
  final ValueChanged<Customer> onItemLongPress;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            var customer = customers[index];
            return CustomerListCard(
              customer: customer,
              onTap: () => onItemTap(customer),
              onLongPress: () => onItemLongPress(customer),
            );
          },
          itemCount: customers.length,
        ),
      ),
    );
  }
}
