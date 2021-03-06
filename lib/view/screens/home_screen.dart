import 'package:customermanagementapp/data/enums/screen_tag.dart';
import 'package:customermanagementapp/view/components/drowers/my_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ホーム'),
        centerTitle: true,
      ),
      drawer: MyDrawer(currentScreen: ScreenTag.SCREEN_HOME),
      body: Center(
        child: const Text('ホーム画面'),
      ),
    );
  }
}
