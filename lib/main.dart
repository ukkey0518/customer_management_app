import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/di/providers.dart';
import 'package:customermanagementapp/util/saple_data_initializer.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'view/screens/home_screen.dart';

MyDatabase database;
SampleDataInitializer initializer;

void main() {
  initializer = SampleDataInitializer();
  runApp(MultiProvider(
    providers: globalProviders,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // サンプルデータ初期化
      initializer.initialize(context);
      // ロケールの設定
      Intl.defaultLocale = 'ja_JP';
      await initializeDateFormatting('ja_JP');
    });
    return MaterialApp(
      title: 'CustomerManagementApp',
      home: HomeScreen(),
    );
  }
}
