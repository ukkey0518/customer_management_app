import 'package:customermanagementapp/util/abstract_classes.dart';
import 'package:customermanagementapp/util/colors.dart';
import 'package:flutter/material.dart';

class BasicInputForm extends StatelessWidget {
  BasicInputForm({
    @required this.formTitle,
    @required this.items,
  });

  final String formTitle;
  final Map<String, InputWidget> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            formTitle,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        Card(
          color: MyColors.lightGrey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.entries.map<Widget>((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(entry.key,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    entry.value,
                    SizedBox(height: 16),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
