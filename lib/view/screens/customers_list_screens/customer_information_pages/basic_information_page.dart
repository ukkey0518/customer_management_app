import 'package:customermanagementapp/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions.dart';
import 'package:customermanagementapp/view/components/list_card_widgets/price_analysis_card_widget.dart';
import 'package:customermanagementapp/view/components/list_card_widgets/profile_card_widget.dart';
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
  List<VisitHistory> _histories;

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
              totalPayment: null, //TODO
              averagePrice: null, //TODO
            ),
            SizedBox(height: 30),
            _repeatAnalysisPart(),
          ],
        ),
      ),
    );
  }

  Widget _repeatAnalysisPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'リピート分析',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.left,
        ),
        Card(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child: Text('１ヶ月以内リピ')),
                    Expanded(child: Text('(未データ)')),
                  ],
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(child: Text('３ヶ月以内リピ')),
                    Expanded(child: Text('(未データ)')),
                  ],
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(child: Text('それ以降リピ')),
                    Expanded(child: Text('(未データ)')),
                  ],
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(child: Text('リピートサイクル')),
                    Expanded(child: Text('(未データ)')),
                  ],
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(child: Text('次回来店予想')),
                    Expanded(child: Text('(未データ)')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
