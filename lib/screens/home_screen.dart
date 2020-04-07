import 'package:customermanagementapp/screens/edit_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.orangeAccent,
          tooltip: '新規登録',
          onPressed: _startEditScreen,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/images/flutter_logo.png',
                height: 200,
                width: 200,
              ),
              _titleText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleText() {
    return Container(
      color: Colors.brown,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      child: Text(
        '顧客管理アプリ',
        style: TextStyle(fontSize: 36),
      ),
    );
  }

  _startEditScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(),
      ),
    );
  }
}
