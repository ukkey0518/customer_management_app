import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';

class CustomerListCard extends StatelessWidget {
  final Customer customer;

  final GestureTapCallback onTap;

  final GestureLongPressCallback onLongPress;

  CustomerListCard({this.customer, this.onTap, this.onLongPress});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: SizedBox(
          height: double.infinity,
          child: Icon(Icons.account_circle),
        ),
        title: Text(
          '${customer.name}',
          style: TextStyle(fontSize: 20),
        ),
        subtitle: Text(
          '${customer.nameReading}',
          style: TextStyle(fontSize: 16),
        ),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}
