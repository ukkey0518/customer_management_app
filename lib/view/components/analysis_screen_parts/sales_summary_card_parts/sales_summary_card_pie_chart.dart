import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class SalesSummaryCardPieCharts extends StatelessWidget {
  SalesSummaryCardPieCharts({
    @required this.numberOfVisitorDataMap,
    @required this.priceDataMap,
    @required this.isEmpty,
    this.colorList,
  });

  final Map<String, double> numberOfVisitorDataMap;
  final Map<String, double> priceDataMap;
  final List<Color> colorList;
  final bool isEmpty;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Text('人数割合'),
              isEmpty
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              shape: BoxShape.circle,
                            ),
                            height: 200,
                          ),
                        ),
                        Text('データなし'),
                      ],
                    )
                  : Container(
                      height: 200,
                      child: PieChart(
                        dataMap: numberOfVisitorDataMap,
                        showLegends: false,
                        initialAngle: 300,
                        colorList: colorList,
                      ),
                    ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text('金額割合'),
              isEmpty
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              shape: BoxShape.circle,
                            ),
                            height: 200,
                          ),
                        ),
                        Text('データなし'),
                      ],
                    )
                  : Container(
                      height: 200,
                      child: PieChart(
                        dataMap: priceDataMap,
                        showLegends: false,
                        initialAngle: 300,
                        colorList: colorList,
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
