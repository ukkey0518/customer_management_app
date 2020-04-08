import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/main.dart';
import 'package:customermanagementapp/screens/home_screen.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _nameReadingController = TextEditingController();
  bool _isGenderFemale = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _finishEditScreen(context),
      child: Scaffold(
        appBar: AppBar(
          // TODO: 編集or登録でタイトルが変わる
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => _finishEditScreen(context),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _onSaveButtonClick,
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
              _genderSelectPart(),
              SizedBox(height: 16),
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
                    value: true,
                    groupValue: _isGenderFemale,
                    onChanged: (value) => _genderSelected(value),
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: const Text('男性'),
                    value: false,
                    groupValue: _isGenderFemale,
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
      _isGenderFemale = value;
    });
  }

  // 保存ボタン押下時の処理
  _onSaveButtonClick() async {
    if (_nameController.text.isEmpty || _nameReadingController.text.isEmpty) {
      //TODO エラーメッセージ
      print('未入力');
      return;
    }

    // 新しいCustomerオブジェクト生成
    var customer = Customer(
      name: _nameController.text,
      nameReading: _nameReadingController.text,
      gender: _isGenderFemale ? '女性' : '男性',
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
