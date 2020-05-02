import 'package:flutter/material.dart';

abstract class ListCardWidget extends StatelessWidget {
  ListCardWidget({this.title, this.contentsMap});
  final String title;
  final Map<String, String> contentsMap;

  @override
  Widget build(BuildContext context) {
    final entries = contentsMap.entries.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.left,
        ),
        Card(
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
                        Expanded(
                          child: Text(entry.value),
                        ),
                      ],
                    ),
                    Divider(),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
