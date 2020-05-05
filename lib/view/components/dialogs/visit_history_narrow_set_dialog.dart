import 'package:customermanagementapp/data_classes/visit_history_narrow_state.dart';
import 'package:customermanagementapp/view/components/dialogs/dialog_title_text.dart';
import 'package:customermanagementapp/view/components/input_widgets/period_input_tile.dart';
import 'package:flutter/material.dart';

class VisitHistoryNarrowSetDialog extends StatelessWidget {
  VisitHistoryNarrowSetDialog({
    @required this.narrowData,
  });

  final VisitHistoryNarrowData narrowData;
  @override
  Widget build(BuildContext context) {
    var narrow = narrowData;

    var selectedSinceDate = narrow.sinceDate;
    var selectedUntilDate = narrow.untilDate;
    var selectedCustomer = narrow.customer;
    var selectedEmployee = narrow.employee;
    var selectedMenuCategory = narrow.menuCategory;

    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: DialogTitleText('絞り込み条件の設定'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // 日付指定
                Text('絞り込み期間：'),
                PeriodInputTile(
                  sinceDate: selectedSinceDate,
                  untilDate: selectedUntilDate,
                  onSinceDateConfirm: (date) =>
                      setState(() => selectedSinceDate = date),
                  onUntilDateConfirm: (date) =>
                      setState(() => selectedUntilDate = date),
                ),
                SizedBox(height: 8),
                // TODO 顧客指定
                // TODO スタッフ指定
                // TODO メニューカテゴリ指定
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('キャンセル'),
              onPressed: () => Navigator.of(context).pop(narrow),
            ),
            FlatButton(
              child: Text('決定'),
              onPressed: () {
                narrow = VisitHistoryNarrowData(
                  sinceDate: selectedSinceDate,
                  untilDate: selectedUntilDate,
                  customer: selectedCustomer,
                  employee: selectedEmployee,
                  menuCategory: selectedMenuCategory,
                );

                Navigator.of(context).pop(narrow);
              },
            ),
          ],
        );
      },
    );
  }
}
