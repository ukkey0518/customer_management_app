import 'package:customermanagementapp/parts/my_drawer.dart';
import 'package:flutter/material.dart';

class MainSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('各種設定画面'),
      ),
      drawer: MyDrawer(),
      body: Container(),
    );
  }
}
