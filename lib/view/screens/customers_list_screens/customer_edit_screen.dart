import 'package:customermanagementapp/db/dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/list_status.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/util/abstract_classes.dart';
import 'package:customermanagementapp/view/components/basic_input_form.dart';
import 'package:customermanagementapp/view/components/input_form_widgets/date_select_form.dart';
import 'package:customermanagementapp/view/components/input_form_widgets/input_field.dart';
import 'package:customermanagementapp/view/components/input_form_widgets/select_buttons.dart';
import 'package:customermanagementapp/view/screens/customers_list_screen.dart';
import 'package:customermanagementapp/util/my_custom_route.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'customer_information_pages/customer_information_screen.dart';

class CustomerEditScreen extends StatefulWidget {
  final CustomerListScreenPreferences pref;
  final Customer customer;
  CustomerEditScreen(this.pref, {this.customer});

  @override
  _CustomerEditScreenState createState() => _CustomerEditScreenState();
}

class _CustomerEditScreenState extends State<CustomerEditScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _nameReadingController = TextEditingController();
  bool _isGenderFemale = true;
  DateTime _birthDay = DateTime(1980, 1, 1);
  String _titleStr = '';
  String _completeMessage = '';
  Customer _editedCustomer;

  String _nameFieldErrorText;
  String _nameReadingFieldErrorText;

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
      onWillPop: () => _finishEditScreen(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(_titleStr),
          // 戻るボタン
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => _finishEditScreen(context),
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
                      errorText: _nameFieldErrorText,
                    ),
                    'よみがな*': InputField(
                      controller: _nameReadingController,
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
    _nameFieldErrorText = _nameController.text.isEmpty ? '必須入力です' : null;
    _nameReadingFieldErrorText =
        _nameReadingController.text.isEmpty ? '必須入力です' : null;

    final dao = MyDao(database);

    _nameFieldErrorText = widget.customer == null &&
            await dao.getCustomersByName(_nameController.text) != null
        ? '同名の顧客データが存在しています。'
        : _nameFieldErrorText;

    setState(() {});

    if (_nameFieldErrorText != null || _nameReadingFieldErrorText != null) {
      return;
    }

    _editedCustomer = Customer(
      id: widget.customer?.id,
      name: _nameController.text,
      nameReading: _nameReadingController.text,
      isGenderFemale: _isGenderFemale,
      birth: _birthDay,
    );

    // DBに新規登録
    await dao.addCustomer(_editedCustomer);
    Toast.show(_completeMessage, context);

    // 画面を終了
    _finishEditScreen(context);
  }

  // [コールバック：画面終了時]
  Future<bool> _finishEditScreen(BuildContext context) {
    var widgetBuilder;
    if (widget.customer == null) {
      widgetBuilder = (context) => CustomersListScreen(pref: widget.pref);
    } else {
      widgetBuilder = (context) => CustomerInformationScreen(
            widget.pref,
            customer: _editedCustomer,
          );
    }
    Navigator.pushReplacement(
      context,
      MyCustomRoute(
        builder: widgetBuilder,
      ),
    );
    return Future.value(false);
  }
}
