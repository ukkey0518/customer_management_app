import 'package:flutter/material.dart';

class SearchResults extends StatelessWidget {
  SearchResults({@required this.numOfResult});

  final numOfResult;

  @override
  Widget build(BuildContext context) {
    var textColor;

    if (numOfResult != 0) {
      textColor = Colors.red;
    }

    return Text.rich(
      TextSpan(
        children: <TextSpan>[
          const TextSpan(text: '結果：'),
          TextSpan(
            text: '$numOfResult',
            style: TextStyle(
              fontSize: 20,
              color: textColor,
            ),
          ),
          const TextSpan(text: '件'),
        ],
      ),
    );
  }
}
