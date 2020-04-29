import 'package:customermanagementapp/db/dao.dart';
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
  static final List<Customer> _initialCustomers = [
    Customer(
      id: 1,
      name: 'カスタマーA',
      nameReading: 'かすたまーA',
      isGenderFemale: true,
      birth: DateTime(1996, 5, 18),
    ),
    Customer(
      id: 2,
      name: 'カスタマーB',
      nameReading: 'かすたまーB',
      isGenderFemale: false,
      birth: DateTime(1990, 1, 1),
    ),
    Customer(
      id: 3,
      name: 'カスタマーC',
      nameReading: 'かすたまーC',
      isGenderFemale: true,
      birth: DateTime(1989, 10, 26),
    ),
  ];

  // [初期データ：従業員]
  static final List<Employee> _initialEmployees = [
    Employee(id: 1, name: 'スタッフA'),
    Employee(id: 2, name: 'スタッフB'),
    Employee(id: 3, name: 'スタッフC'),
  ];

  // [初期データ：メニューカテゴリ]
  static final List<MenuCategory> _initialMenuCategories = [
    MenuCategory(id: 1, name: 'カテゴリA', color: Colors.red.value),
    MenuCategory(id: 2, name: 'カテゴリB', color: Colors.blue.value),
    MenuCategory(id: 3, name: 'カテゴリC', color: Colors.green.value),
    MenuCategory(id: 4, name: 'カテゴリD', color: Colors.amber.value),
    MenuCategory(id: 5, name: 'カテゴリE', color: Colors.deepPurpleAccent.value),
    MenuCategory(id: 6, name: 'カテゴリF', color: Colors.tealAccent.value),
  ];

  // [初期データ：メニュー]
  static final List<Menu> _initialMenus = [
    Menu(
      id: 1,
      name: 'メニュー1',
      price: 1000,
      menuCategoryJson:
          MenuCategory(id: 1, name: 'カテゴリA', color: Colors.red.value)
              .toJsonString(),
    ),
    Menu(
      id: 2,
      name: 'メニュー2',
      price: 2000,
      menuCategoryJson:
          MenuCategory(id: 1, name: 'カテゴリA', color: Colors.red.value)
              .toJsonString(),
    ),
    Menu(
      id: 3,
      name: 'メニュー3',
      price: 3000,
      menuCategoryJson:
          MenuCategory(id: 1, name: 'カテゴリA', color: Colors.red.value)
              .toJsonString(),
    ),
    Menu(
      id: 4,
      name: 'メニュー4',
      price: 4000,
      menuCategoryJson:
          MenuCategory(id: 2, name: 'カテゴリB', color: Colors.blue.value)
              .toJsonString(),
    ),
    Menu(
      id: 5,
      name: 'メニュー5',
      price: 5000,
      menuCategoryJson:
          MenuCategory(id: 2, name: 'カテゴリB', color: Colors.blue.value)
              .toJsonString(),
    ),
    Menu(
      id: 6,
      name: 'メニュー6',
      price: 6000,
      menuCategoryJson:
          MenuCategory(id: 2, name: 'カテゴリB', color: Colors.blue.value)
              .toJsonString(),
    ),
    Menu(
      id: 7,
      name: 'メニュー7',
      price: 7000,
      menuCategoryJson:
          MenuCategory(id: 3, name: 'カテゴリC', color: Colors.green.value)
              .toJsonString(),
    ),
    Menu(
      id: 8,
      name: 'メニュー8',
      price: 8000,
      menuCategoryJson:
          MenuCategory(id: 3, name: 'カテゴリC', color: Colors.green.value)
              .toJsonString(),
    ),
    Menu(
      id: 9,
      name: 'メニュー9',
      price: 9000,
      menuCategoryJson:
          MenuCategory(id: 3, name: 'カテゴリC', color: Colors.green.value)
              .toJsonString(),
    ),
    Menu(
      id: 10,
      name: 'メニュー10',
      price: 10000,
      menuCategoryJson:
          MenuCategory(id: 4, name: 'カテゴリD', color: Colors.amber.value)
              .toJsonString(),
    ),
    Menu(
      id: 11,
      name: 'メニュー11',
      price: 11000,
      menuCategoryJson: MenuCategory(
              id: 5, name: 'カテゴリE', color: Colors.deepPurpleAccent.value)
          .toJsonString(),
    ),
    Menu(
      id: 12,
      name: 'メニュー12',
      price: 12000,
      menuCategoryJson:
          MenuCategory(id: 6, name: 'カテゴリF', color: Colors.tealAccent.value)
              .toJsonString(),
    ),
  ];

  // [初期化メソッド]
  initialize() async {
    print('--- sample data init start ...');

    final dao = MyDao(database);

    try {
      // [Customersテーブルの初期化]
      var nowCustomersData = await dao.allCustomers;
      if (nowCustomersData.isEmpty) {
        print('  ...Customers is Empty.');
        await dao.addAllCustomers(_initialCustomers);
        print('  ...Customers init ok.');
      } else {
        print('  ...Customers is Not Empty.');
        print(
            '  current Customers state : [${nowCustomersData.length}] data exist.');
      }

      // [Employeesテーブルの初期化]
      var nowEmployeesData = await dao.allEmployees;
      if (nowEmployeesData.isEmpty) {
        print('  ...Employees is Empty.');
        await dao.addAllEmployees(_initialEmployees);
        print('  ...Employees init ok.');
      } else {
        print('  ...Employees is Not Empty.');
        print(
            '  current Employees state : [${nowEmployeesData.length}] data exist.');
      }

      // [MenuCategoriesテーブルの初期化]
      var nowMenuCategoriesData = await dao.allMenuCategories;
      if (nowMenuCategoriesData.isEmpty) {
        print('  ...MenuCategories is Empty.');
        await dao.addAllMenuCategories(_initialMenuCategories);
        print('  ...MenuCategories init ok.');

        // [Menusテーブルの初期化]
        // (カテゴリIDの重複を避けるためカテゴリメニュー初期化実行時のみ実行)
        var nowMenusData = await database.allMenus;
        if (nowMenusData.isEmpty) {
          print('  ...Menus is Empty.');
          await database.addAllMenus(_initialMenus);
          print('  ...Menus init ok.');
        } else {
          print('  ...Menus is Not Empty.');
          print('  current Menus state : [${nowMenusData.length}] data exist.');
        }
      } else {
        print('  ...MenuCategories is Not Empty.');
        print(
            '  current MenuCategories state : [${nowMenuCategoriesData.length}] data exist.');
        print('  ...Menus init canceled.');
      }

      print('--- sample data init completed.');
    } on SqliteException catch (e) {
      print('!!sample data init Exeption：$e');
    }
  }
}
