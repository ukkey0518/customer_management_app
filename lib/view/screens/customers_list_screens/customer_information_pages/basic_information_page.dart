import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/data/enums/date_format_mode.dart';
import 'package:customermanagementapp/data/gender_bool_data.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/convert_from_visit_history_list.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/util/functions.dart';
import 'package:customermanagementapp/view/components/custom_cards/basic_information_card.dart';
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
            Text(
              'プロフィール',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.left,
            ),
            BasicInformationCard(
              contentsMap: <String, Supplier<Widget>>{
                'お名前': () {
                  final nameStr = customer?.name ?? '--';
                  final nameReadingStr = customer?.nameReading ?? '--';
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(nameStr, style: TextStyle(color: Colors.grey)),
                      Text(nameReadingStr, style: TextStyle(fontSize: 16)),
                    ],
                  );
                },
                '性別': () {
                  final genderStr = customer != null
                      ? genderBoolData[customer.isGenderFemale]
                      : '--';
                  return Text(genderStr);
                },
                '生年月日': () {
                  var birthStr = '未登録';
                  var ageStr = '';
                  if (customer != null) {
                    birthStr = customer.birth != null
                        ? customer.birth?.toFormatStr(DateFormatMode.FULL)
                        : '未登録';
                    ageStr = customer.birth != null
                        ? '(${customer.birth?.toAge()}歳)'
                        : '';
                  }
                  return Text('$birthStr $ageStr');
                },
              },
            ),
            SizedBox(height: 30),
            Text(
              '来店情報',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.left,
            ),
            BasicInformationCard(
              contentsMap: {
                '来店回数': () {
                  final novStr = histories?.length?.toString();
                  return Text(novStr ?? '--');
                },
                '初回来店': () {
                  final firstVisitStr = histories
                      ?.getFirstVisitHistory()
                      ?.date
                      ?.toFormatStr(DateFormatMode.FULL);
                  return Text(firstVisitStr ?? '--');
                },
                '最終来店': () {
                  final lastVisit = histories
                      ?.getLastVisitHistory()
                      ?.date
                      ?.toFormatStr(DateFormatMode.FULL);
                  return Text(lastVisit ?? '--');
                },
                '初回来店理由': () {
                  final reasonStr = customer?.visitReason;
                  return Text(reasonStr ?? '--');
                },
              },
            ),
            SizedBox(height: 30),
            Text(
              '単価分析',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.left,
            ),
            BasicInformationCard(
              contentsMap: {
                'お支払い総額': () {
                  final totalPaymentStr =
                      histories?.toSumPriceList()?.getSum()?.toPriceString();
                  return Text(totalPaymentStr ?? '--');
                },
                '平均単価': () {
                  final avePriceStr = histories
                      ?.toSumPriceList()
                      ?.getAverage()
                      ?.toPriceString(1);
                  return Text(avePriceStr ?? '--');
                },
              },
            ),
            SizedBox(height: 30),
            Text(
              'リピート分析',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.left,
            ),
            BasicInformationCard(
              contentsMap: {
                '1ヶ月以内リピ': () {
                  final norWith1MonthStr = histories
                      ?.getNumOfRepeatDuringPeriodByMonths(
                        minMonth: 0,
                        maxMonth: 1,
                      )
                      ?.toString();
                  return Text(norWith1MonthStr ?? '0');
                },
                '3ヶ月以内リピ': () {
                  final norWith3MonthStr = histories
                      ?.getNumOfRepeatDuringPeriodByMonths(
                        minMonth: 1,
                        maxMonth: 3,
                      )
                      ?.toString();
                  return Text(norWith3MonthStr ?? '0');
                },
                'それ以降リピ': () {
                  final norWithMoreStr = histories
                      ?.getNumOfRepeatDuringPeriodByMonths(
                        minMonth: 3,
                      )
                      ?.toString();
                  return Text(norWithMoreStr ?? '0');
                },
                'リピートサイクル': () {
                  final repeatCycleStr =
                      histories?.getRepeatCycle()?.toString();
                  return Text(repeatCycleStr ?? '0');
                },
                '次回来店予想日': () {
                  final expectedNextVisit = histories
                      ?.expectedNextVisit()
                      ?.toFormatStr(DateFormatMode.FULL);
                  return Text(expectedNextVisit ?? '--');
                },
              },
            ),
          ],
        ),
      ),
    );
  }
}
