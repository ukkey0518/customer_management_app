import 'package:customermanagementapp/data/enums/input_field_style.dart';
import 'package:customermanagementapp/data/gender_bool_data.dart';
import 'package:customermanagementapp/data/visit_reason_data.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/input_forms/vertical_input_form.dart';
import 'package:customermanagementapp/view/components/custom_containers/date_input_container.dart';
import 'package:customermanagementapp/view/components/custom_text_fields/text_input_field.dart';
import 'package:customermanagementapp/view/components/dialogs/unsaved_confirm_dialog.dart';
import 'package:customermanagementapp/view/components/buttons/raised_switch_buttons.dart';
import 'package:customermanagementapp/view/components/custom_containers/single_item_picker_selecter.dart';
import 'package:customermanagementapp/viewmodel/customer_edit_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerEditScreen extends StatelessWidget {
  CustomerEditScreen({this.customer});

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<CustomerEditViewModel>(context, listen: false);

    if (viewModel.customer == null) {
      Future(() {
        viewModel.setCustomer(customer);
      });
    }

    return WillPopScope(
      onWillPop: () => _finishEditScreen(context),
      child: Consumer<CustomerEditViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(viewModel.title),
              // 戻るボタン
              leading: IconButton(
                icon: Icon(Icons.close),
                onPressed: () => _finishEditScreen(context),
              ),
              actions: <Widget>[
                // 保存ボタン
                IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () => _saveCustomer(context),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    VerticalInputForm(
                      formTitle: '基本情報',
                      items: <String, Widget>{
                        '氏名*': TextInputField(
                          controller: viewModel.nameController,
                          onChanged: (_) => _onInputFieldChanged(context),
                          inputType: TextInputType.text,
                          errorText: viewModel.nameFieldErrorText,
                          hintText: '顧客 太郎',
                          style: InputFieldStyle.ROUNDED_RECTANGLE,
                        ),
                        'よみがな*': TextInputField(
                          controller: viewModel.nameReadingController,
                          onChanged: (_) => _onInputFieldChanged(context),
                          inputType: TextInputType.text,
                          errorText: viewModel.nameReadingFieldErrorText,
                          hintText: 'こきゃく たろう',
                          style: InputFieldStyle.ROUNDED_RECTANGLE,
                        ),
                        '性別*': RaisedSwitchButtons(
                          values: genderBoolData.values.toList(),
                          selectedValue:
                              genderBoolData[viewModel.isGenderFemale],
                          onChanged: (genderStr) => _onGenderChanged(
                            context,
                            genderBoolData.getKeyFromValue(genderStr),
                          ),
                        ),
                        '生年月日（長押しでクリア）': DateInputContainer(
                          selectedDate: viewModel.birthDay,
                          onConfirm: (birthDay) =>
                              _onBirthdayChanged(context, birthDay),
                          isClearable: true,
                          paddingVertical: 8,
                          paddingHorizontal: 8,
                          backgroundColor: Colors.white,
                        ),
                      },
                    ),
                    SizedBox(height: 30),
                    VerticalInputForm(
                      formTitle: 'その他情報',
                      items: <String, Widget>{
                        '来店動機（長押しでクリア）': SingleItemPickerContainer(
                          items: visitReasonData.keys.toList(),
                          isClearable: true,
                          selectedItem: viewModel.selectedVisitReason,
                          onConfirm: (visitReason) =>
                              _onVisitReasonChanged(context, visitReason),
                        ),
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // [コールバック：入力欄変更時]
  _onInputFieldChanged(BuildContext context) async {
    final viewModel =
        Provider.of<CustomerEditViewModel>(context, listen: false);

    await viewModel.onInputFieldChanged();
  }

  // [コールバック：性別変更時]
  _onGenderChanged(BuildContext context, bool isGenderFemale) async {
    final viewModel =
        Provider.of<CustomerEditViewModel>(context, listen: false);

    await viewModel.onGenderChanged(isGenderFemale);
  }

  // [コールバック：生年月日変更時]
  _onBirthdayChanged(BuildContext context, DateTime birthDay) async {
    final viewModel =
        Provider.of<CustomerEditViewModel>(context, listen: false);

    await viewModel.onBirthdayChanged(birthDay);
  }

  // [コールバック：生年月日変更時]
  _onVisitReasonChanged(BuildContext context, String visitReason) async {
    final viewModel =
        Provider.of<CustomerEditViewModel>(context, listen: false);

    await viewModel.onVisitReasonChanged(visitReason);
  }

  // [コールバック：保存ボタンタップ時]
  _saveCustomer(BuildContext context) async {
    final viewModel =
        Provider.of<CustomerEditViewModel>(context, listen: false);

    final flag = await viewModel.saveCustomer();

    if (flag) {
      _finishEditScreen(context);
    }
  }

  // [コールバック：画面終了時]
  Future<bool> _finishEditScreen(BuildContext context) async {
    final viewModel =
        Provider.of<CustomerEditViewModel>(context, listen: false);

    if (!viewModel.isSaved) {
      await showDialog(
        context: context,
        builder: (_) => UnsavedConfirmDialog(),
      ).then((flag) {
        if (flag) {
          Navigator.of(context).pop();
        }
      });
    } else {
      Navigator.of(context).pop();
    }

    return Future.value(false);
  }
}
