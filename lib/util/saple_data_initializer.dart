import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/viewmodel/employee_view_model.dart';
import 'package:flutter/material.dart';
import 'package:moor_ffi/database.dart';
import 'package:provider/provider.dart';

class SampleDataInitializer {
  static bool _isInitialized = false;
  static SampleDataInitializer _instance;

  factory SampleDataInitializer() {
    if (_instance == null) _instance = SampleDataInitializer._internal();
    return _instance;
  }

  SampleDataInitializer._internal();

  // [初期データ：顧客]
  static final List<Customer> _initCustomers = [
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
  static final List<Employee> _initEmployees = [
    Employee(id: 1, name: 'スタッフA'),
    Employee(id: 2, name: 'スタッフB'),
    Employee(id: 3, name: 'スタッフC'),
  ];

  // [初期データ：メニューカテゴリ]
  static final List<MenuCategory> _initMenuCategories = [
    MenuCategory(id: 1, name: 'カテゴリA', color: Colors.red.value),
    MenuCategory(id: 2, name: 'カテゴリB', color: Colors.blue.value),
    MenuCategory(id: 3, name: 'カテゴリC', color: Colors.green.value),
    MenuCategory(id: 4, name: 'カテゴリD', color: Colors.amber.value),
    MenuCategory(id: 5, name: 'カテゴリE', color: Colors.deepPurpleAccent.value),
    MenuCategory(id: 6, name: 'カテゴリF', color: Colors.tealAccent.value),
  ];

  // [初期データ：メニュー]
  static final List<Menu> _initMenus = [
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
  initialize(BuildContext context) async {
    print('--- sample data init start ...');

    if (_isInitialized) {
      print('--- already initialized.');
      return;
    }

    //TODO 顧客ViewModelの取得

    // 従業員ViewModelの取得
    final employeeViewModel =
        Provider.of<EmployeeViewModel>(context, listen: false);

    //TODO メニューカテゴリViewModelの取得

    //TODO メニューViewModelの取得

    try {
      //TODO [Customersテーブルの初期化]

      // [Employeesテーブルの初期化]
      await employeeViewModel.addAllEmployee(_initEmployees);
      print('  ...Employees init ok. : ${_initEmployees.length} data');

      //TODO [MenuCategoriesテーブルの初期化]

      //TODO [Menusテーブルの初期化]

      _isInitialized = true;

      print('  [not init] Customers: ${_initCustomers.length} data');
      print('  [not init] MenuCategories: ${_initMenuCategories.length} data');
      print('  [not init] Menus: ${_initMenus.length} data');
      print('--- initialize finished.');
    } on SqliteException catch (e) {
      print('!!sample data init Exeption：$e');
    }
  }
}
