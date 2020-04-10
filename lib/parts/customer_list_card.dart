import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';

class CustomerListCard extends StatelessWidget {
  CustomerListCard({this.customer, this.onTap, this.onLongPress});

  final Customer customer;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: _getGenderIcon(),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${customer.nameReading}',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          '${customer.name} 様',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getGenderIcon() {
    var iconColor =
        customer.gender == '女性' ? Colors.pinkAccent : Colors.blueAccent;

    return Icon(
      Icons.account_circle,
      color: iconColor,
    );
  }
}
