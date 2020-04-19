import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';
import 'package:moor_ffi/database.dart';

import '../main.dart';

class SampleDataInitializer {
  static SampleDataInitializer _instance;

  factory SampleDataInitializer() {
    if (_instance == null) _instance = SampleDataInitializer._internal();
    return _instance;
  }

  SampleDataInitializer._internal();

  // [初期データ：顧客]
  final List<Customer> _initialCustomers = [
    Customer(
      id: null,
      name: 'カスタマーA',
      nameReading: 'かすたまーA',
      isGenderFemale: true,
      birth: DateTime(1996, 5, 18),
    ),
    Customer(
      id: null,
      name: 'カスタマーB',
      nameReading: 'かすたまーB',
      isGenderFemale: false,
      birth: DateTime(1990, 1, 1),
    ),
    Customer(
      id: null,
      name: 'カスタマーC',
      nameReading: 'かすたまーC',
      isGenderFemale: true,
      birth: DateTime(1989, 10, 26),
    ),
  ];

  // [初期データ：従業員]
  final List<Employee> _initialEmployees = [
    Employee(id: null, name: 'スタッフA'),
    Employee(id: null, name: 'スタッフB'),
    Employee(id: null, name: 'スタッフC'),
  ];

  // [初期データ：メニューカテゴリ]
  final List<MenuCategory> _initialMenuCategories = [
    MenuCategory(id: null, name: 'カテゴリA', color: Colors.red.value),
    MenuCategory(id: null, name: 'カテゴリB', color: Colors.blue.value),
    MenuCategory(id: null, name: 'カテゴリC', color: Colors.green.value),
  ];

  // [初期データ：メニュー]
  final List<Menu> _initialMenus = [
    Menu(id: null, name: 'メニュー1', price: 1000, menuCategoryId: 1),
    Menu(id: null, name: 'メニュー2', price: 2000, menuCategoryId: 1),
    Menu(id: null, name: 'メニュー3', price: 3000, menuCategoryId: 1),
    Menu(id: null, name: 'メニュー4', price: 4000, menuCategoryId: 2),
    Menu(id: null, name: 'メニュー5', price: 5000, menuCategoryId: 2),
    Menu(id: null, name: 'メニュー6', price: 6000, menuCategoryId: 2),
    Menu(id: null, name: 'メニュー7', price: 7000, menuCategoryId: 3),
    Menu(id: null, name: 'メニュー8', price: 8000, menuCategoryId: 3),
    Menu(id: null, name: 'メニュー9', price: 9000, menuCategoryId: 3),
  ];

  // [初期化メソッド]
  initialize() async {
    try {
//      await database.addAllCustomers();
//      await database.addAllEmployees();
//      await database.addAllMenuCategories();
//      await database.addAllMenus();
    } on SqliteException catch (e) {
      print('サンプルデータ初期化時のエラー：$e');
    }
  }
}
