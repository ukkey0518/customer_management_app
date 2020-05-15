import 'package:customermanagementapp/data/enums/screen_display_mode.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/screens/customers_list_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class CustomerNotSelectedCard extends StatelessWidget {
  CustomerNotSelectedCard({this.onSelected});

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
                  builder: (context) => CustomersListScreen(
                    displayMode: ScreenDisplayMode.SELECTABLE,
                  ),
                  fullscreenDialog: true,
                ),
              )
              .then((context) => onSelected(context));
        },
        onLongPress: null,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
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
          ),
        ),
      ),
    );
  }
}
