import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/util/extensions/convert_from_visit_history_list.dart';
import 'package:customermanagementapp/view/components/list_card_widgets/price_analysis_card_widget.dart';
import 'package:customermanagementapp/view/components/list_card_widgets/profile_card_widget.dart';
import 'package:customermanagementapp/view/components/list_card_widgets/repeat_analysis_card_widget.dart';
import 'package:customermanagementapp/view/components/list_card_widgets/visit_information_card_widgt.dart';
import 'package:flutter/material.dart';

class BasicInformationPage extends StatefulWidget {
  BasicInformationPage({@required this.historiesByCustomer});

  final VisitHistoriesByCustomer historiesByCustomer;

  @override
  _BasicInformationPageState createState() => _BasicInformationPageState();
}

class _BasicInformationPageState extends State<BasicInformationPage> {
  Customer _customer;
  List<VisitHistory> _histories = List();

  @override
  void initState() {
    super.initState();
    _customer = widget.historiesByCustomer.customer;
    _histories = widget.historiesByCustomer.histories;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ProfileCardWidget(
              name: _customer.name,
              nameReading: _customer.nameReading,
              isGenderFemale: _customer.isGenderFemale,
              birth: _customer.birth,
            ),
            SizedBox(height: 30),
            VisitInformationCardWidget(
              numberOfVisit: _histories?.length,
              firstVisitDate: _histories?.getFirstVisitHistory()?.date,
              lastVisitDate: _histories?.getLastVisitHistory()?.date,
              reasonForVisit: null, //TODO
            ),
            SizedBox(height: 30),
            PriceAnalysisCardWidget(
              totalPayment: _histories?.toSumPriceList()?.getSum(),
              averagePrice: _histories?.toSumPriceList()?.getAverage(),
            ),
            SizedBox(height: 30),
            RepeatAnalysisCardWidget(
              numberOfRepeatWithinAMonth:
                  _histories?.getNumOfRepeatDuringPeriodByMonths(
                minMonth: 0,
                maxMonth: 1,
              ),
              numberOfRepeatWithinThreeMonth:
                  _histories?.getNumOfRepeatDuringPeriodByMonths(
                minMonth: 1,
                maxMonth: 3,
              ),
              numberOfRepeatMore:
                  _histories?.getNumOfRepeatDuringPeriodByMonths(
                minMonth: 3,
              ),
              repeatCycle: _histories?.getRepeatCycle(),
              expectedNextVisit: _histories?.expectedNextVisit(),
            ),
          ],
        ),
      ),
    );
  }
}
