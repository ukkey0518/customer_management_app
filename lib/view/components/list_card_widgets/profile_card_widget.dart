import 'package:customermanagementapp/view/components/polymorphism/list_card_view.dart';
import 'package:customermanagementapp/util/extensions.dart';
import 'package:flutter/material.dart';

class ProfileCardWidget extends ListCardWidget {
  ProfileCardWidget({
    @required this.name,
    @required this.nameReading,
    @required this.isGenderFemale,
    @required this.birth,
  }) : super(title: 'プロフィール');

  final String name;
  final String nameReading;
  final bool isGenderFemale;
  final DateTime birth;

  @override
  Widget build(BuildContext context) {
    final genderStr = isGenderFemale ? '女性' : '男性';
    final birthStr = birth.toBirthDayString();
    final ageStr = birth.toAge();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
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
                    Expanded(child: Text('お名前')),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('$nameReading'),
                          Text('$name 様'),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(child: Text('性別')),
                    Expanded(child: Text(genderStr)),
                  ],
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(child: Text('生年月日')),
                    Expanded(child: Text('$birthStr ($ageStr歳)')),
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
