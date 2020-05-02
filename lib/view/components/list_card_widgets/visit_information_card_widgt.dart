import 'package:customermanagementapp/view/components/polymorphism/list_card_view.dart';
import 'package:customermanagementapp/util/extensions.dart';

import 'package:flutter/material.dart';

class VisitInformationCardWidget extends ListCardWidget {
  VisitInformationCardWidget({
    @required int numberOfVisit,
    @required DateTime firstVisitDate,
    @required DateTime lastVisitDate,
    @required String reasonForVisit,
  }) : super(
          title: '来店情報',
          contentsMap: {
            '来店回数': numberOfVisit?.toString(),
            '初回来店': firstVisitDate?.toFormatString(),
            '最終来店': lastVisitDate?.toFormatString(),
            '初回来店理由': reasonForVisit,
          },
        );
}
