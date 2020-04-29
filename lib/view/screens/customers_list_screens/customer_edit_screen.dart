import 'package:customermanagementapp/db/dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/list_status.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/view/screens/customers_list_screens/customers_list_screen.dart';
import 'package:customermanagementapp/util/my_custom_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

import 'customer_information_pages/customer_information_screen.dart';

class CustomerEditScreen extends StatefulWidget {
  final ListScreenPreferences pref;
  final Customer customer;
  CustomerEditScreen(this.pref, {this.customer});

  @override
  _CustomerEditScreenState createState() => _CustomerEditScreenState();
}

class _CustomerEditScreenState extends State<CustomerEditScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _nameReadingController = TextEditingController();
  bool _isGenderFemale = true;
  String _titleStr = '';
  DateTime _birthDay = DateTime(1980, 1, 1);
  DateFormat _birthDayFormatter = DateFormat('yyyy年 M月 d日');
  Customer _editedCustomer;
  String _completeMessage = '';

  @override
  void initState() {
    super.initState();
    if (widget.customer == null) {
      _nameController.text = '';
      _nameReadingController.text = '';
      _isGenderFemale = null;
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

  // [更新：性別選択後に更新する処理]
  _setGender(value) {
    setState(() {
      _isGenderFemale = value;
    });
  }

  // [更新：誕生日入力後に更新する処理]
  _setBirthDay(DateTime birthDay) {
    setState(() {
      _birthDay = birthDay;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              const Text('基本情報', style: TextStyle(fontSize: 20)),
              SizedBox(height: 16),
              _nameInputPart(),
              SizedBox(height: 16),
              _nameReadingInputPart(),
              SizedBox(height: 16),
              _genderInputPart(),
              SizedBox(height: 30),
              const Text('詳細情報', style: TextStyle(fontSize: 20)),
              SizedBox(height: 16),
              _birthDayInputPart(),
            ],
          ),
        ),
      ),
    );
  }

  // [ウィジェットビルダー：各入力欄のフォーマッタ]
  Widget _inputPartBuilder({String title, Widget content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(title, style: TextStyle(fontSize: 20)),
          ),
          Expanded(
            flex: 7,
            child: content,
          ),
        ],
      ),
    );
  }

  // [ウィジェット：名前入力部分]
  Widget _nameInputPart() {
    return _inputPartBuilder(
      title: 'お名前',
      content: TextField(
        controller: _nameController,
        keyboardType: TextInputType.text,
      ),
    );
  }

  // [ウィジェット：よみがな入力部分]
  Widget _nameReadingInputPart() {
    return _inputPartBuilder(
      title: 'よみがな',
      content: TextField(
        controller: _nameReadingController,
        keyboardType: TextInputType.text,
      ),
    );
  }

  // [ウィジェット：性別入力部分]
  Widget _genderInputPart() {
    return _inputPartBuilder(
      title: '性別',
      content: Row(
        children: <Widget>[
          Expanded(
            child: RadioListTile(
              title: const Text('女性'),
              value: true,
              groupValue: _isGenderFemale,
              onChanged: (gender) => _setGender(gender),
            ),
          ),
          Expanded(
            child: RadioListTile(
              title: const Text('男性'),
              value: false,
              groupValue: _isGenderFemale,
              onChanged: (gender) => _setGender(gender),
            ),
          ),
        ],
      ),
    );
  }

  // [ウィジェット：生年月日入力部分]
  Widget _birthDayInputPart() {
    return _inputPartBuilder(
      title: '生年月日',
      content: InkWell(
        onTap: _showBirthDaySelectPicker,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                _birthDay == null
                    ? '未登録'
                    : '${_birthDayFormatter.format(_birthDay)}',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  // [コールバック：誕生日欄タップ時]
  _showBirthDaySelectPicker() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1970, 1, 1),
      maxTime: DateTime.now(),
      onConfirm: (birthDay) => _setBirthDay(birthDay),
      currentTime: _birthDay == null ? DateTime(1990, 1, 1) : _birthDay,
      locale: LocaleType.jp,
    );
    setState(() {});
  }

  // [コールバック：保存ボタンタップ時]
  _saveCustomer() async {
    if (_nameController.text.isEmpty ||
        _nameReadingController.text.isEmpty ||
        _isGenderFemale == null) {
      Toast.show('すべての入力欄を埋めてください', context);
      return;
    }
    final dao = MyDao(database);

    if (widget.customer == null &&
        await dao.getCustomersByName(_nameController.text) != null) {
      Toast.show('同名の顧客データが存在しています。', context);
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
