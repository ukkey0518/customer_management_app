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

    return Column(
      children: <Widget>[
        Text(
          '検索結果',
          style: TextStyle(
            color: Theme.of(context).textSelectionHandleColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          width: 80,
          height: 40,
          alignment: Alignment.center,
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '$numOfResult',
                  style: TextStyle(
                    fontSize: 26,
                    color: textColor,
                  ),
                ),
                const TextSpan(text: '件', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
