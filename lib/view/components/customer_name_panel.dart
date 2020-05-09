import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';

import 'package:flutter/material.dart';

import '../../styles.dart';

class CustomerNamePanel extends StatelessWidget {
  const CustomerNamePanel({
    @required this.customer,
  });

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    var iconColor =
        customer.isGenderFemale ? Styles.femaleIconColor : Styles.maleIconColor;
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Icon(
            Icons.account_circle,
            color: iconColor,
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
        Text('${customer.birth.toAge() ?? '?'} 歳'),
      ],
    );
  }
}
