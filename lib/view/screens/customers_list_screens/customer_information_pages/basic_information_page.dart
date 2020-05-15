import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/convert_from_visit_history_list.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/list_card_widgets/price_analysis_card_widget.dart';
import 'package:customermanagementapp/view/components/list_card_widgets/profile_card_widget.dart';
import 'package:customermanagementapp/view/components/list_card_widgets/repeat_analysis_card_widget.dart';
import 'package:customermanagementapp/view/components/list_card_widgets/visit_information_card_widgt.dart';
import 'package:flutter/material.dart';

class BasicInformationPage extends StatelessWidget {
  BasicInformationPage({this.vhbc});

  final VisitHistoriesByCustomer vhbc;

  @override
  Widget build(BuildContext context) {
    Customer customer = vhbc?.customer;
    List<VisitHistory> histories = vhbc?.histories;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ProfileCardWidget(
              name: customer?.name,
              nameReading: customer?.nameReading,
              isGenderFemale:
                  customer == null ? false : customer.isGenderFemale,
              birth: customer?.birth,
            ),
            SizedBox(height: 30),
            VisitInformationCardWidget(
              numberOfVisit: histories?.length,
              firstVisitDate: histories?.getFirstVisitHistory()?.date,
              lastVisitDate: histories?.getLastVisitHistory()?.date,
              reasonForVisit: customer?.visitReason,
            ),
            SizedBox(height: 30),
            PriceAnalysisCardWidget(
              totalPayment: histories?.toSumPriceList()?.getSum(),
              averagePrice: histories?.toSumPriceList()?.getAverage(),
            ),
            SizedBox(height: 30),
            RepeatAnalysisCardWidget(
              numberOfRepeatWithinAMonth:
                  histories?.getNumOfRepeatDuringPeriodByMonths(
                minMonth: 0,
                maxMonth: 1,
              ),
              numberOfRepeatWithinThreeMonth:
                  histories?.getNumOfRepeatDuringPeriodByMonths(
                minMonth: 1,
                maxMonth: 3,
              ),
              numberOfRepeatMore: histories?.getNumOfRepeatDuringPeriodByMonths(
                minMonth: 3,
              ),
              repeatCycle: histories?.getRepeatCycle(),
              expectedNextVisit: histories?.expectedNextVisit(),
            ),
          ],
        ),
      ),
    );
  }
}
