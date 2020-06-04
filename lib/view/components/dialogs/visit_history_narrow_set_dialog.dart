import 'package:customermanagementapp/data/data_classes/visit_history_narrow_data.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/custom_dropdown_button/simple_dropdown_button.dart';
import 'package:customermanagementapp/view/components/dialogs/dialog_title_text.dart';
import 'package:customermanagementapp/view/components/input_widgets/period_input_tile.dart';
import 'package:flutter/material.dart';

class VisitHistoryNarrowSetDialog extends StatelessWidget {
  VisitHistoryNarrowSetDialog({
    @required this.narrowData,
    @required this.allEmployees,
    @required this.allMenuCategories,
  });

  final VisitHistoryNarrowData narrowData;
  final List<Employee> allEmployees;
  final List<MenuCategory> allMenuCategories;

  @override
  Widget build(BuildContext context) {
    var unselectedValue = '未設定';
    var narrow = narrowData;

    var selectedSinceDate = narrow.sinceDate;
    var selectedUntilDate = narrow.untilDate;

    var employeeNameList = allEmployees?.map<String>((e) => e.name)?.toList();
    var menuCategoryNameList =
        allMenuCategories?.map<String>((mc) => mc.name)?.toList();

    var selectedEmployeeName =
        narrow.employee != null ? narrow.employee.name : unselectedValue;
    var selectedCategoryName = narrow.menuCategory != null
        ? narrow.menuCategory.name
        : unselectedValue;

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
                SizedBox(height: 16),
                // スタッフ指定
                Text('担当スタップ：'),
                SimpleDropdownButton(
                  items: employeeNameList,
                  selectedItem: selectedEmployeeName,
                  onChanged: (value) =>
                      setState(() => selectedEmployeeName = value),
                  isExpand: true,
                  textColor: Theme.of(context).primaryColorDark,
                  unselectedValue: unselectedValue,
                ),
                SizedBox(height: 16),
                // メニューカテゴリ指定
                Text('メニューカテゴリ：'),
                SimpleDropdownButton(
                  items: menuCategoryNameList,
                  selectedItem: selectedCategoryName,
                  onChanged: (value) =>
                      setState(() => selectedCategoryName = value),
                  isExpand: true,
                  textColor: Theme.of(context).primaryColorDark,
                  unselectedValue: unselectedValue,
                ),
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
                  employee: _getEmployee(selectedEmployeeName),
                  menuCategory: _getMenuCategory(selectedCategoryName),
                );
                Navigator.of(context).pop(narrow);
              },
            ),
          ],
        );
      },
    );
  }

  Employee _getEmployee(String name) {
    var employee = allEmployees.where((e) => e.name == name).toList();
    return employee.isNotEmpty ? employee.single : null;
  }

  MenuCategory _getMenuCategory(String name) {
    var menuCategory =
        allMenuCategories.where((mc) => mc.name == name).toList();
    return menuCategory.isNotEmpty ? menuCategory.single : null;
  }
}
