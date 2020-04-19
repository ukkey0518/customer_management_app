import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/src/saple_data_initializer.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

MyDatabase database;

void main() {
  database = MyDatabase();
  runApp(MyApp());
  // サンプルデータ初期化
  WidgetsBinding.instance
      .addPostFrameCallback((_) => SampleDataInitializer().initialize());
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
