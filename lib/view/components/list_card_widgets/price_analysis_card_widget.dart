import 'package:customermanagementapp/view/components/polymorphism/list_card_view.dart';
import 'package:customermanagementapp/util/extensions.dart';

import 'package:flutter/material.dart';

class PriceAnalysisCardWidget extends ListCardWidget {
  PriceAnalysisCardWidget({
    @required int totalPayment,
    @required int averagePrice,
  }) : super(
          title: '単価分析',
          contentsMap: {
            'お支払い総額': totalPayment?.toPriceString(),
            '平均単価': averagePrice?.toPriceString(),
          },
        );
}
