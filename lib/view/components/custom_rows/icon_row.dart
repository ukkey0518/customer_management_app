import 'package:flutter/material.dart';

class IconRow extends StatelessWidget {
  IconRow({this.icon, this.title, this.content});

  final Icon icon;
  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: icon,
                ),
                Text(title, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            flex: 8,
            child: content,
          ),
        ],
      ),
    );
  }
}
