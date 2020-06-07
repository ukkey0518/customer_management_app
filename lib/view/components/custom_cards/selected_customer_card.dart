import 'package:customermanagementapp/data/enums/screen_display_mode.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/util/styles.dart';
import 'package:customermanagementapp/view/screens/customers_list_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class SelectedContainerCard extends StatelessWidget {
  SelectedContainerCard({this.customer, this.onSelected});

  final Customer customer;
  final ValueChanged<Customer> onSelected;

  @override
  Widget build(BuildContext context) {
    var content;
    if (customer == null) {
      content = SizedBox(
        width: double.infinity,
        child: DottedBorder(
          borderType: BorderType.RRect,
          color: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '+タップして顧客を選択',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      content = Container(
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
      );
    }
    return Card(
      color: Color(0xeeeeeeee),
      child: InkWell(
        onTap: onSelected != null
            ? () {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (context) {
                          return CustomersListScreen(
                            displayMode: ScreenDisplayMode.SELECTABLE,
                          );
                        },
                        fullscreenDialog: true,
                      ),
                    )
                    .then((customer) => onSelected(customer));
              }
            : null,
        onLongPress: null,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: content,
        ),
      ),
    );
  }
}
