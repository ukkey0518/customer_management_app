import 'package:flutter/material.dart';

class ErrorIndicator extends StatelessWidget {
  ErrorIndicator({
    @required this.errorTexts,
  });

  final List<String> errorTexts;
  @override
  Widget build(BuildContext context) {
    if (errorTexts.reduce((a, b) => b != null ? b : a) == null) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.yellowAccent.shade100,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: List.generate(errorTexts.length, (index) {
            var text = errorTexts[index];
            return text != null
                ? Text(
                    '・${errorTexts[index]}',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  )
                : Container();
          }),
        ),
      ),
    );
  }
}
