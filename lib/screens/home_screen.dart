import 'package:customermanagementapp/parts/my_drawer.dart';
import 'package:customermanagementapp/screens/customers_list_screens/customers_list_screen.dart';
import 'package:customermanagementapp/src/my_custom_route.dart';
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
      drawer: MyDrawer(),
      body: Center(
        child: const Text('ホーム画面'),
      ),
    );
  }
}
