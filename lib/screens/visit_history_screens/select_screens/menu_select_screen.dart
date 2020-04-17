import 'package:flutter/material.dart';

class MenuSelectScreen extends StatefulWidget {
  @override
  _MenuSelectScreenState createState() => _MenuSelectScreenState();
}

class _MenuSelectScreenState extends State<MenuSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メニューの選択'),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
