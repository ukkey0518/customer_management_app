import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

MyDatabase database;

void main() {
  database = MyDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CustomerManagementApp',
      home: HomeScreen(),
    );
  }
}
