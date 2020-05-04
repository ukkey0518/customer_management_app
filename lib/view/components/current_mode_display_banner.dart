import 'package:flutter/material.dart';

class CurrentModeDisplayBanner extends StatelessWidget {
  CurrentModeDisplayBanner({this.modeText, this.color});

  final String modeText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: color,
        ),
        child: Text(modeText),
      ),
    );
  }
}
