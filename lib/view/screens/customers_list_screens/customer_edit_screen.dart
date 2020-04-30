import 'package:customermanagementapp/db/dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/list_status.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/view/screens/customers_list_screen.dart';
import 'package:customermanagementapp/util/extensions.dart';
import 'package:customermanagementapp/util/my_custom_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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

  // [更新：性別選択後に更新する処理]
  _setGender(bool value) {
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('基本情報', style: TextStyle(fontSize: 20)),
                _profilePart(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _profilePart() {
    return Card(
      color: Color(0xe5e5e5e5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('氏名：', style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '顧客 太郎',
                  errorText: _nameFieldErrorText,
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                controller: _nameController,
              ),
            ),
            SizedBox(height: 16),
            Text('よみがな：', style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'こきゃく たろう',
                  errorText: _nameReadingFieldErrorText,
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                controller: _nameReadingController,
              ),
            ),
            SizedBox(height: 16),
            Text('性別：', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: <Widget>[
                RaisedButton(
                  color: _isGenderFemale
                      ? Theme.of(context).primaryColorLight
                      : Colors.white,
                  child: Text(
                    '女性',
                    style: TextStyle(
                      color: _isGenderFemale ? Colors.black : Colors.grey,
                    ),
                  ),
                  onPressed: () => _setGender(true),
                ),
                SizedBox(width: 4),
                RaisedButton(
                  color: _isGenderFemale
                      ? Colors.white
                      : Theme.of(context).primaryColorLight,
                  child: Text(
                    '男性',
                    style: TextStyle(
                      color: _isGenderFemale ? Colors.grey : Colors.black,
                    ),
                  ),
                  onPressed: () => _setGender(false),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('生年月日：', style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              color: Colors.white,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: InkWell(
                onTap: _showBirthDaySelectPicker,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _birthDay == null
                            ? '未登録'
                            : '${_birthDay.toBirthDayString()}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.centerRight,
              child: RaisedButton(
                child: Text('クリア'),
                onPressed: () => _setBirthDay(null),
              ),
            ),
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
