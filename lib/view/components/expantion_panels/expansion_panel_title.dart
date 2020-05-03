import 'package:flutter/material.dart';

class ExpansionPanelTitle extends StatelessWidget {
  ExpansionPanelTitle({
    this.title,
    this.leading,
  });

  final String title;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        leading: leadingPart(),
      ),
    );
  }

  Widget leadingPart() {
    return leading ?? Container();
  }
}
