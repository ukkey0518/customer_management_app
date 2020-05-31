import 'package:flutter/material.dart';

class SearchResults extends StatelessWidget {
  SearchResults({@required this.numOfResult});

  final numOfResult;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: <TextSpan>[
          const TextSpan(text: '結果：'),
          TextSpan(
            text: '$numOfResult',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.red,
            ),
          ),
          const TextSpan(text: '件'),
        ],
      ),
    );
  }
}
