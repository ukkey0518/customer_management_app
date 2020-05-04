import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions.dart';
import 'package:customermanagementapp/styles.dart';
import 'package:customermanagementapp/view/screens/visit_history_screens/select_screens/customer_select_screen.dart';
import 'package:flutter/material.dart';

class CustomerSelectedCard extends StatelessWidget {
  CustomerSelectedCard({this.customer, this.onSelected});

  final Customer customer;
  final ValueChanged<Customer> onSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xeeeeeeee),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => CustomerSelectScreen(),
                  fullscreenDialog: true,
                ),
              )
              .then((context) => onSelected(context));
        },
        onLongPress: null,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            padding: EdgeInsets.all(12),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(
                    Icons.account_circle,
                    color: customer.isGenderFemale
                        ? Styles.femaleIconColor
                        : Styles.maleIconColor,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${customer.nameReading}',
                        style: Styles.nameReadingStyle,
                      ),
                      Text(
                        '${customer.name} 様',
                        style: Styles.nameStyle,
                      ),
                    ],
                  ),
                ),
                Text('${customer.birth.toAge() ?? '?'}歳'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
