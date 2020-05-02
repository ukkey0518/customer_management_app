import 'package:customermanagementapp/view/components/polymorphism/list_card_view.dart';
import 'package:customermanagementapp/util/extensions.dart';

import 'package:flutter/material.dart';

class RepeatAnalysisCardWidget extends ListCardWidget {
  RepeatAnalysisCardWidget({
    @required int numberOfRepeatWithinAMonth,
    @required int numberOfRepeatWithinThreeMonth,
    @required int numberOfRepeatMore,
    @required int repeatCycle,
    @required DateTime expectedNextVisit,
  }) : super(
          title: 'リピート分析',
          contentsMap: {
            '１ヶ月以内リピ': numberOfRepeatWithinAMonth?.toString(),
            '３ヶ月以内リピ': numberOfRepeatWithinThreeMonth?.toString(),
            'それ以降リピ': numberOfRepeatMore?.toString(),
            'リピートサイクル': repeatCycle?.toString(),
            '次回来店予想': expectedNextVisit?.toFormatString(),
          },
        );
}
