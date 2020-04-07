import 'package:customermanagementapp/screens/home_screen.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _nameController;

  TextEditingController _nameReadingController;

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
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: const Text(
              'お名前',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            flex: 8,
            child: TextField(
              controller: _nameController,
              keyboardType: TextInputType.text,
            ),
          ),
        ],
      ),
    );
  }

  Widget _nameReadingInputPart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: const Text(
              'よみがな',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            flex: 8,
            child: TextField(
              controller: _nameReadingController,
              keyboardType: TextInputType.text,
            ),
          ),
        ],
      ),
    );
  }
}
