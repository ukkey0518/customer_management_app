import 'package:customermanagementapp/data/gender_entry.dart';
import 'package:customermanagementapp/data/input_field_style.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/polymorphism/input_widget.dart';
import 'package:customermanagementapp/view/components/basic_input_form.dart';
import 'package:customermanagementapp/view/components/input_widgets/date_input_tile.dart';
import 'package:customermanagementapp/view/components/input_widgets/text_input_field.dart';
import 'package:customermanagementapp/view/components/input_widgets/select_switch_buttons.dart';
import 'package:customermanagementapp/view/components/dialogs/unsaved_confirm_dialog.dart';
import 'package:flutter/material.dart';

class CustomerEditScreen extends StatefulWidget {
  CustomerEditScreen(this.customers, {this.customer});

  final List<Customer> customers;
  final Customer customer;

  @override
  _CustomerEditScreenState createState() => _CustomerEditScreenState();
}

class _CustomerEditScreenState extends State<CustomerEditScreen> {
  String _titleStr = '';

  TextEditingController _nameController = TextEditingController();
  TextEditingController _nameReadingController = TextEditingController();
  bool _isGenderFemale = true;
  DateTime _birthDay = DateTime(1980, 1, 1);

  Customer _editedCustomer;

  String _nameFieldErrorText;
  String _nameReadingFieldErrorText;

  @override
  void initState() {
    super.initState();
    if (widget.customer == null) {
      _titleStr = '顧客情報の新規登録';
      _nameController.text = '';
      _nameReadingController.text = '';
      _isGenderFemale = true;
      _birthDay = null;
    } else {
      _titleStr = '顧客情報の編集';
      _nameController.text = widget.customer.name;
      _nameReadingController.text = widget.customer.nameReading;
      _isGenderFemale = widget.customer.isGenderFemale;
      _birthDay = widget.customer.birth;
    }
  }

  // [コールバック：性別選択時]
  _setGender(String value) {
    _isGenderFemale = genderEntry.getKeyFromValue(value);
    setState(() {});
  }

  // [コールバック：誕生日入力を決定した時]
  _setBirthDay(DateTime birthDay) {
    setState(() {
      _birthDay = birthDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _finishEditScreen(context, true),
      child: Scaffold(
        appBar: AppBar(
          title: Text(_titleStr),
          // 戻るボタン
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => _finishEditScreen(context, true),
          ),
          actions: <Widget>[
            // 保存ボタン
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveCustomer,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BasicInputForm(
                  formTitle: '基本情報',
                  items: <String, InputWidget>{
                    '氏名*': TextInputField(
                      controller: _nameController,
                      inputType: TextInputType.text,
                      errorText: _nameFieldErrorText,
                      hintText: '顧客 太郎',
                      style: InputFieldStyle.ROUNDED_RECTANGLE,
                    ),
                    'よみがな*': TextInputField(
                      controller: _nameReadingController,
                      inputType: TextInputType.text,
                      errorText: _nameReadingFieldErrorText,
                      hintText: 'こきゃく たろう',
                      style: InputFieldStyle.ROUNDED_RECTANGLE,
                    ),
                    '性別*': SelectSwitchButtons(
                      values: genderEntry.values.toList(),
                      selectedValue: genderEntry[_isGenderFemale],
                      onChanged: _setGender,
                    ),
                    '生年月日': DateInputTile(
                      selectedDate: _birthDay,
                      onConfirm: _setBirthDay,
                      isClearable: true,
                      paddingVertical: 8,
                      paddingHorizontal: 8,
                      color: Colors.white,
                    ),
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // [コールバック：保存ボタンタップ時]
  _saveCustomer() async {
    // 未入力チェック
    _nameFieldErrorText = _nameController.text.isEmpty ? '必須入力です' : null;
    _nameReadingFieldErrorText =
        _nameReadingController.text.isEmpty ? '必須入力です' : null;

    //重複チェック：
    _nameFieldErrorText =
        widget.customers.isNameDuplicated(_nameController.text)
            ? '同名の顧客データが存在しています。'
            : _nameFieldErrorText;

    // エラー時は画面を更新して戻る
    if (_nameFieldErrorText != null || _nameReadingFieldErrorText != null) {
      setState(() {});
      return;
    }

    // 編集後の顧客データを作成
    _editedCustomer = Customer(
      id: widget.customer?.id,
      name: _nameController.text,
      nameReading: _nameReadingController.text,
      isGenderFemale: _isGenderFemale,
      birth: _birthDay,
    );

    // 画面を終了
    _finishEditScreen(context, false);
  }

  // [コールバック：画面終了時]
  Future<bool> _finishEditScreen(
      BuildContext context, bool dialogShowFlag) async {
    if (dialogShowFlag) {
      await showDialog(
        context: context,
        builder: (_) => UnsavedConfirmDialog(),
      ).then((flag) {
        if (flag) {
          Navigator.of(context).pop(_editedCustomer);
        }
      });
    } else {
      Navigator.of(context).pop(_editedCustomer);
    }
    return Future.value(false);
  }
}
