import 'package:customermanagementapp/data/enums/screen_display_mode.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/util/styles.dart';
import 'package:customermanagementapp/view/screens/customers_list_screen.dart';
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
        onTap: onSelected != null
            ? () {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (context) => CustomersListScreen(
                          displayMode: ScreenDisplayMode.SELECTABLE,
                        ),
                        fullscreenDialog: true,
                      ),
                    )
                    .then((context) => onSelected(context));
              }
            : null,
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
