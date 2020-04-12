import 'package:flutter/material.dart';

class EmployeeSettingScreen extends StatefulWidget {
  @override
  _EmployeeSettingScreenState createState() => _EmployeeSettingScreenState();
}

class _EmployeeSettingScreenState extends State<EmployeeSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('スタッフ管理'),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
