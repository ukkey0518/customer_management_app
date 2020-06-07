import 'package:customermanagementapp/util/functional_interfaces.dart';
import 'package:flutter/material.dart';

class BasicInformationCard extends StatelessWidget {
  BasicInformationCard({@required this.contentsMap});

  final Map<String, Supplier<Widget>> contentsMap;

  @override
  Widget build(BuildContext context) {
    final entries = contentsMap.entries.toList();
    return Card(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: List.generate(entries.length, (index) {
            final entry = entries[index];
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child: Text(entry.key)),
                    Expanded(child: entry.value()),
                  ],
                ),
                getDivider(entries.length - 1 == index),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget getDivider(bool isEnd) {
    return isEnd ? Container() : Divider();
  }
}
