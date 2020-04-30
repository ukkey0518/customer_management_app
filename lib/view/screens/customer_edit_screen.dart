import 'package:customermanagementapp/db/dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/list_status.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/util/abstract_classes.dart';
import 'package:customermanagementapp/view/components/basic_input_form.dart';
import 'package:customermanagementapp/view/components/input_form_widgets/date_select_form.dart';
import 'package:customermanagementapp/view/components/input_form_widgets/input_field.dart';
import 'package:customermanagementapp/view/components/input_form_widgets/select_buttons.dart';
import 'package:customermanagementapp/view/components/dialogs/unsaved_confirm_dialog.dart';
import 'package:customermanagementapp/util/my_custom_route.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'customers_list_screen.dart';
import 'customers_list_screens/customer_information_pages/customer_information_screen.dart';

class CustomerEditScreen extends StatefulWidget {
  CustomerEditScreen(this.pref, {this.customer});

  final CustomerListScreenPreferences pref;
  final Customer customer;

  @override
  _CustomerEditScreenState createState() => _CustomerEditScreenState();
}

class _CustomerEditScreenState extends State<CustomerEditScreen> {
  // [フィールド：名前入力欄のTextEditingController]
  TextEditingController _nameController = TextEditingController();

  // [フィールド：名前入力欄のTextEditingController]
  TextEditingController _nameReadingController = TextEditingController();

  // [フィールド：性別]
  bool _isGenderFemale = true;

  // [フィールド：生年月日]
  DateTime _birthDay = DateTime(1980, 1, 1);

  // [フィールド：タイトル]
  String _titleStr = '';

  // [フィールド：完了時のメッセージ]
  String _completeMessage = '';

  // [フィールド：編集したカスタマー]
  Customer _editedCustomer;

  // [フィールド：名前入力欄のエラーメッセージ]
  String _nameFieldErrorText;

  // [フィールド：よみがな入力欄のエラーメッセージ]
  String _nameReadingFieldErrorText;

  // [定数フィールド：DAO]
  final MyDao dao = MyDao(database);

  @override
  void initState() {
    super.initState();
    if (widget.customer == null) {
      _nameController.text = '';
      _nameReadingController.text = '';
      _isGenderFemale = true;
      _birthDay = null;
      _titleStr = '顧客情報の新規登録';
      _completeMessage = '登録されました。';
    } else {
      _nameController.text = widget.customer.name;
      _nameReadingController.text = widget.customer.nameReading;
      _isGenderFemale = widget.customer.isGenderFemale;
      _birthDay = widget.customer.birth;
      _titleStr = '顧客情報の編集';
      _editedCustomer = widget.customer;
      _completeMessage = '更新されました。';
    }
  }

  // [コールバック：性別選択時]
  _setGender(String value) {
    switch (value) {
      case '女性':
        _isGenderFemale = true;
        break;
      case '男性':
        _isGenderFemale = false;
        break;
    }
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
    final Map<bool, String> genderEntry = {true: '女性', false: '男性'};

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
                    '氏名*': InputField(
                      controller: _nameController,
                      inputType: TextInputType.text,
                      errorText: _nameFieldErrorText,
                    ),
                    'よみがな*': InputField(
                      controller: _nameReadingController,
                      inputType: TextInputType.text,
                      errorText: _nameReadingFieldErrorText,
                    ),
                    '性別*': SelectButtons(
                      values: genderEntry.values.toList(),
                      selectedValue: genderEntry[_isGenderFemale],
                      onChanged: _setGender,
                    ),
                    '生年月日': DateSelectForm(
                      selectedDate: _birthDay,
                      onConfirm: _setBirthDay,
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
    // 未入力チェック：名前入力欄
    _nameFieldErrorText = _nameController.text.isEmpty ? '必須入力です' : null;

    // 未入力チェック：よみがな入力欄
    _nameReadingFieldErrorText =
        _nameReadingController.text.isEmpty ? '必須入力です' : null;

    // 重複チェック：
    _nameFieldErrorText = widget.customer == null &&
            await dao.getCustomersByName(_nameController.text) != null
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

    // DBに新規登録
    await dao.addCustomer(_editedCustomer);

    // メッセージを表示
    Toast.show(_completeMessage, context);

    // 画面を終了
    _finishEditScreen(context, false);
  }

  // [コールバック：画面終了時]
  Future<bool> _finishEditScreen(
      BuildContext context, bool dialogShowFlag) async {
    var widgetBuilder;
    if (widget.customer == null) {
      widgetBuilder = (context) => CustomersListScreen(pref: widget.pref);
    } else {
      widgetBuilder = (context) => CustomerInformationScreen(
            widget.pref,
            customer: _editedCustomer,
          );
    }
    if (dialogShowFlag) {
      await showDialog(
        context: context,
        builder: (_) => UnsavedConfirmDialog(),
      ).then((flag) {
        if (flag) {
          Navigator.pushReplacement(
            context,
            MyCustomRoute(
              builder: widgetBuilder,
            ),
          );
        }
      });
    } else {
      Navigator.pushReplacement(
        context,
        MyCustomRoute(
          builder: widgetBuilder,
        ),
      );
    }
    return Future.value(false);
  }
}
