import 'package:customermanagementapp/screens/home_screen.dart';
import 'package:flutter/material.dart';

enum Gender { MALE, FEMALE }

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _nameController;
  TextEditingController _nameReadingController;
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

  _genderSelected(value) {
    setState(() {
      _gender = value;
    });
  }
}
