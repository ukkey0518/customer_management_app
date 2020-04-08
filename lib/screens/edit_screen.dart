import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/screens/home_screen.dart';
import 'package:flutter/material.dart';

enum Gender { MALE, FEMALE }

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _nameReadingController = TextEditingController();
  Gender _gender = Gender.FEMALE;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _finishEditScreen(context),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => _finishEditScreen(context),
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              const Text('基本情報'),
              _nameInputPart(),
              _nameReadingInputPart(),
              _genderSelectPart(),
              RaisedButton(
                child: const Text(
                  '登録',
                  style: TextStyle(color: Colors.black),
                ),
                color: Colors.orangeAccent,
                onPressed: _onRegisterButtonClick,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _finishEditScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
    return Future.value(false);
  }

  // お名前入力欄
  Widget _nameInputPart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: const Text(
              'お名前',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            flex: 7,
            child: TextField(
              controller: _nameController,
              keyboardType: TextInputType.text,
            ),
          ),
        ],
      ),
    );
  }

  // よみがな入力欄
  Widget _nameReadingInputPart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: const Text(
              'よみがな',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            flex: 7,
            child: TextField(
              controller: _nameReadingController,
              keyboardType: TextInputType.text,
            ),
          ),
        ],
      ),
    );
  }

  // 性別選択ラジオボタン欄
  Widget _genderSelectPart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: const Text(
              '性別',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            flex: 7,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RadioListTile(
                    title: const Text('女性'),
                    value: Gender.FEMALE,
                    groupValue: _gender,
                    onChanged: (value) => _genderSelected(value),
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: const Text('男性'),
                    value: Gender.MALE,
                    groupValue: _gender,
                    onChanged: (value) => _genderSelected(value),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 性別を選択したときの処理
  _genderSelected(value) {
    setState(() {
      _gender = value;
    });
  }

  // 登録ボタン押下時の処理
  _onRegisterButtonClick() async {
    if (_nameController.text.isEmpty || _nameReadingController.text.isEmpty) {
      //TODO エラーメッセージ
      print('未入力');
      return;
    }

    // 新しいCustomerオブジェクト生成
    var customer = Customer(
      name: _nameController.text,
      nameReading: _nameReadingController.text,
      gender: _gender.toString(),
    );

    // TODO ”新規(Create)”と”編集(Update)”の処理分岐

    // DBに新規登録
    await database.addCustomer(customer);

    // 入力欄をクリア
    setState(() {
      _nameController.clear();
      _nameReadingController.clear();
    });
  }
}
