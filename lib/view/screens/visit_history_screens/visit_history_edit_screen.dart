import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/contents_column_with_title.dart';
import 'package:customermanagementapp/view/components/custom_cards/selected_customer_card.dart';
import 'package:customermanagementapp/view/components/dialogs/unsaved_confirm_dialog.dart';
import 'package:customermanagementapp/view/components/icon_button_to_switch.dart';
import 'package:customermanagementapp/view/components/indicators/current_mode_indicator.dart';
import 'package:customermanagementapp/view/components/indicators/error_indicator.dart';
import 'package:customermanagementapp/view/components/input_widgets/date_input_tile.dart';
import 'package:customermanagementapp/view/components/input_widgets/employee_input_button.dart';
import 'package:customermanagementapp/view/components/input_widgets/menu_input_tile.dart';
import 'package:customermanagementapp/view/components/my_divider.dart';
import 'package:customermanagementapp/view/components/row_with_icon.dart';
import 'package:customermanagementapp/view/screens/visit_history_screens/select_screens/menu_select_screen.dart';
import 'package:customermanagementapp/viewmodel/visit_history_edit_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class VisitHistoryEditScreen extends StatelessWidget {
  VisitHistoryEditScreen({this.visitHistory});

  final VisitHistory visitHistory;

  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<VisitHistoryEditViewModel>(context, listen: false);

    Future(() {
      viewModel.reflectVisitHistoryData(visitHistory: visitHistory);
    });

    return WillPopScope(
      onWillPop: () => _finishEditScreen(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('来店情報'),
          // 戻るボタン
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => _finishEditScreen(context),
          ),
          actions: <Widget>[
            Consumer<VisitHistoryEditViewModel>(
              builder: (context, viewModel, child) {
                return IconButtonToSwitch(
                  switchFlag: viewModel.isReadingMode,
                  trueButton: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _setStatus(context, isReadingMode: false),
                  ),
                  falseButton: IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () => _saveSingleVisitHistory(context),
                  ),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Consumer<VisitHistoryEditViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CurrentModeIndicator(
                    modeText: viewModel.isReadingMode ? '閲覧モード' : '編集モード',
                    color: viewModel.isReadingMode
                        ? Theme.of(context).primaryColorLight
                        : Colors.amber,
                  ),
                  ErrorIndicator(
                    errorTexts: [
                      viewModel.customerErrorText,
                      viewModel.employeeErrorText,
                      viewModel.menusErrorText,
                    ],
                  ),
                  ContentsColumnWithTitle(
                    title: 'お客様情報',
                    children: <Widget>[
                      RowWithIcon(
                        icon: Icon(Icons.account_circle),
                        title: '顧客',
                        content: SelectedContainerCard(
                          customer: viewModel.customer,
                          onSelected: viewModel.isReadingMode
                              ? null
                              : (customer) =>
                                  _setStatus(context, customer: customer),
                        ),
                      ),
                    ],
                  ),
                  MyDivider(),
                  SizedBox(height: 30),
                  ContentsColumnWithTitle(
                    title: '詳細情報',
                    children: <Widget>[
                      RowWithIcon(
                        icon: Icon(Icons.calendar_today),
                        title: '日付',
                        content: DateInputTile(
                          selectedDate: viewModel.date,
                          onConfirm: (date) => _setStatus(context, date: date),
                          isDisabled: viewModel.isReadingMode,
                        ),
                      ),
                      RowWithIcon(
                        icon: Icon(Icons.supervisor_account),
                        title: '担当',
                        content: EmployeeInputButton(
                          selectedEmployee: viewModel.employee,
                          employees: viewModel.employeeList,
                          onChanged: (employee) =>
                              _setStatus(context, employee: employee),
                          isDisabled: viewModel.isReadingMode,
                        ),
                      ),
                    ],
                  ),
                  MyDivider(),
                  SizedBox(height: 30),
                  ContentsColumnWithTitle(
                    title: '提供メニュー',
                    children: <Widget>[Container()],
                  ),
                  Expanded(
                    child: MenuInputTile(
                      screenAbsorbing: viewModel.isReadingMode,
                      onTap: () => _startMenuSelectScreen(context),
                      menus: viewModel.menus,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  _setStatus(
    BuildContext context, {
    Customer customer,
    DateTime date,
    Employee employee,
    List<Menu> menus,
    bool isReadingMode,
  }) async {
    final viewModel =
        Provider.of<VisitHistoryEditViewModel>(context, listen: false);

    await viewModel.setStatus(
        customer: customer,
        date: date,
        employee: employee,
        menus: menus,
        isReadingMode: isReadingMode);
  }

  // [コールバック：メニュー欄タップ時]
  _startMenuSelectScreen(BuildContext context) {
    final viewModel =
        Provider.of<VisitHistoryEditViewModel>(context, listen: false);

    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) {
              return MenuSelectScreen(selectedMenus: viewModel.menus);
            },
            fullscreenDialog: true,
          ),
        )
        .then((menus) => _setStatus(context, menus: menus));
  }

  // [コールバック：保存ボタン押下時]
  _saveSingleVisitHistory(BuildContext context) async {
    final viewModel =
        Provider.of<VisitHistoryEditViewModel>(context, listen: false);

    await viewModel.saveVisitHistory();

    if (viewModel.isSaved) {
      Toast.show('保存しました。', context);
    }
  }

  // [コールバック：画面終了時の処理]
  Future<bool> _finishEditScreen(BuildContext context) async {
    final viewModel =
        Provider.of<VisitHistoryEditViewModel>(context, listen: false);

    if (viewModel.isSaved) {
      Navigator.of(context).pop();
    } else {
      await showDialog(
        context: context,
        builder: (_) => UnsavedConfirmDialog(),
      ).then((flag) {
        if (flag) {
          Navigator.of(context).pop();
        }
      });
    }
    return Future.value(false);
  }
}
