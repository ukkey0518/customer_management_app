import 'package:flutter/material.dart';

class MenuCategorySettingScreen extends StatefulWidget {
  @override
  _MenuCategorySettingScreenState createState() =>
      _MenuCategorySettingScreenState();
}

class _MenuCategorySettingScreenState extends State<MenuCategorySettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メニューカテゴリ管理'),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
