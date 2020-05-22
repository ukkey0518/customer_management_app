import 'package:customermanagementapp/data/visit_reason_data.dart';
import 'package:customermanagementapp/db/dao/customer_dao.dart';
import 'package:customermanagementapp/db/dao/employee_dao.dart';
import 'package:customermanagementapp/db/dao/menu_category_dao.dart';
import 'package:customermanagementapp/db/dao/menu_dao.dart';
import 'package:customermanagementapp/db/dao/visit_history_dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:moor_ffi/database.dart';
import 'package:provider/provider.dart';

class SampleDataInitializer {
  static SampleDataInitializer _instance;

  factory SampleDataInitializer() {
    if (_instance == null) _instance = SampleDataInitializer._internal();
    return _instance;
  }

  SampleDataInitializer._internal();

  static final reasons = visitReasonData.keys.toList();

  // [初期データ：顧客]
  static final List<Customer> _initCustomers = [
    Customer(
      id: 1,
      name: 'カスタマーA',
      nameReading: 'かすたまーA',
      isGenderFemale: true,
      birth: DateTime(1996, 5, 18),
      visitReason: reasons[0],
    ),
    Customer(
      id: 2,
      name: 'カスタマーB',
      nameReading: 'かすたまーB',
      isGenderFemale: false,
      birth: DateTime(1990, 1, 1),
      visitReason: reasons[5],
    ),
    Customer(
      id: 3,
      name: 'カスタマーC',
      nameReading: 'かすたまーC',
      isGenderFemale: true,
      birth: DateTime(1989, 10, 26),
      visitReason: reasons[3],
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
      menuCategoryJson: _initMenuCategories[0].toJsonString(),
    ),
    Menu(
      id: 2,
      name: 'メニュー2',
      price: 2000,
      menuCategoryJson: _initMenuCategories[0].toJsonString(),
    ),
    Menu(
      id: 3,
      name: 'メニュー3',
      price: 3000,
      menuCategoryJson: _initMenuCategories[0].toJsonString(),
    ),
    Menu(
      id: 4,
      name: 'メニュー4',
      price: 4000,
      menuCategoryJson: _initMenuCategories[1].toJsonString(),
    ),
    Menu(
      id: 5,
      name: 'メニュー5',
      price: 5000,
      menuCategoryJson: _initMenuCategories[1].toJsonString(),
    ),
    Menu(
      id: 6,
      name: 'メニュー6',
      price: 6000,
      menuCategoryJson: _initMenuCategories[1].toJsonString(),
    ),
    Menu(
      id: 7,
      name: 'メニュー7',
      price: 7000,
      menuCategoryJson: _initMenuCategories[2].toJsonString(),
    ),
    Menu(
      id: 8,
      name: 'メニュー8',
      price: 8000,
      menuCategoryJson: _initMenuCategories[2].toJsonString(),
    ),
    Menu(
      id: 9,
      name: 'メニュー9',
      price: 9000,
      menuCategoryJson: _initMenuCategories[2].toJsonString(),
    ),
    Menu(
      id: 10,
      name: 'メニュー10',
      price: 10000,
      menuCategoryJson: _initMenuCategories[3].toJsonString(),
    ),
    Menu(
      id: 11,
      name: 'メニュー11',
      price: 11000,
      menuCategoryJson: _initMenuCategories[4].toJsonString(),
    ),
    Menu(
      id: 12,
      name: 'メニュー12',
      price: 12000,
      menuCategoryJson: _initMenuCategories[5].toJsonString(),
    ),
  ];

  static final List<VisitHistory> _initVisitHistories = [
    VisitHistory(
      id: 1,
      date: DateTime(2020, 4, 1),
      customerJson: _initCustomers[0].toJsonString(),
      employeeJson: _initEmployees[0].toJsonString(),
      menuListJson: [
        _initMenus[0],
      ].toJsonString(),
    ),
    VisitHistory(
      id: 2,
      date: DateTime(2020, 4, 1),
      customerJson: _initCustomers[1].toJsonString(),
      employeeJson: _initEmployees[1].toJsonString(),
      menuListJson: [
        _initMenus[2],
        _initMenus[6],
      ].toJsonString(),
    ),
    VisitHistory(
      id: 3,
      date: DateTime(2020, 4, 6),
      customerJson: _initCustomers[2].toJsonString(),
      employeeJson: _initEmployees[2].toJsonString(),
      menuListJson: [
        _initMenus[3],
        _initMenus[9],
      ].toJsonString(),
    ),
    VisitHistory(
      id: 4,
      date: DateTime(2020, 4, 8),
      customerJson: _initCustomers[1].toJsonString(),
      employeeJson: _initEmployees[1].toJsonString(),
      menuListJson: [
        _initMenus[10],
      ].toJsonString(),
    ),
    VisitHistory(
      id: 5,
      date: DateTime(2020, 4, 12),
      customerJson: _initCustomers[2].toJsonString(),
      employeeJson: _initEmployees[2].toJsonString(),
      menuListJson: [
        _initMenus[7],
        _initMenus[11],
      ].toJsonString(),
    ),
    VisitHistory(
      id: 6,
      date: DateTime(2020, 4, 15),
      customerJson: _initCustomers[0].toJsonString(),
      employeeJson: _initEmployees[0].toJsonString(),
      menuListJson: [
        _initMenus[2],
        _initMenus[5],
      ].toJsonString(),
    ),
    VisitHistory(
      id: 7,
      date: DateTime(2020, 4, 19),
      customerJson: _initCustomers[0].toJsonString(),
      employeeJson: _initEmployees[0].toJsonString(),
      menuListJson: [
        _initMenus[3],
        _initMenus[5],
      ].toJsonString(),
    ),
    VisitHistory(
      id: 8,
      date: DateTime(2020, 4, 22),
      customerJson: _initCustomers[1].toJsonString(),
      employeeJson: _initEmployees[1].toJsonString(),
      menuListJson: [
        _initMenus[3],
        _initMenus[5],
      ].toJsonString(),
    ),
    VisitHistory(
      id: 9,
      date: DateTime(2020, 4, 28),
      customerJson: _initCustomers[0].toJsonString(),
      employeeJson: _initEmployees[0].toJsonString(),
      menuListJson: [
        _initMenus[3],
        _initMenus[5],
      ].toJsonString(),
    ),
    VisitHistory(
      id: 10,
      date: DateTime(2020, 4, 28),
      customerJson: _initCustomers[2].toJsonString(),
      employeeJson: _initEmployees[2].toJsonString(),
      menuListJson: [
        _initMenus[4],
        _initMenus[5],
      ].toJsonString(),
    ),
    VisitHistory(
      id: 11,
      date: DateTime(2020, 4, 29),
      customerJson: _initCustomers[1].toJsonString(),
      employeeJson: _initEmployees[1].toJsonString(),
      menuListJson: [
        _initMenus[3],
      ].toJsonString(),
    ),
    VisitHistory(
      id: 12,
      date: DateTime(2020, 4, 30),
      customerJson: _initCustomers[2].toJsonString(),
      employeeJson: _initEmployees[2].toJsonString(),
      menuListJson: [
        _initMenus[6],
      ].toJsonString(),
    ),
  ];

  // [初期化メソッド]
  initialize(BuildContext context) async {
    print('--- sample data init start ...');

    final customerDao = Provider.of<CustomerDao>(context, listen: false);
    final employeeDao = Provider.of<EmployeeDao>(context, listen: false);
    final menuCategoryDao =
        Provider.of<MenuCategoryDao>(context, listen: false);
    final menuDao = Provider.of<MenuDao>(context, listen: false);
    final vhDao = Provider.of<VisitHistoryDao>(context, listen: false);

    try {
      //Customersテーブルの初期化
      if ((await customerDao.getCustomers()).isEmpty) {
        await customerDao.addAllCustomers(_initCustomers);
        print('  ...Customers init ok. : ${_initCustomers.length} data');
      } else {
        print(
            '  ...Customers not empty. : exists ${_initCustomers.length} data');
      }

      // Employeesテーブルの初期化
      if ((await employeeDao.allEmployees).isEmpty) {
        await employeeDao.addAllEmployees(_initEmployees);
        print('  ...Employees init ok. : ${_initEmployees.length} data');
      } else {
        print(
            '  ...Employees not empty. : exists ${_initEmployees.length} data');
      }

      // MenuCategoriesテーブルの初期化
      if ((await menuCategoryDao.allMenuCategories).isEmpty) {
        await menuCategoryDao.addAllMenuCategories(_initMenuCategories);
        print(
            '  ...MenuCategories init ok. : ${_initMenuCategories.length} data');
      } else {
        print(
            '  ...MenuCategories not empty. : exists ${_initMenuCategories.length} data');
      }

      // Menusテーブルの初期化
      if ((await menuDao.allMenus).isEmpty) {
        await menuDao.addAllMenus(_initMenus);
        print('  ...Menus init ok. : ${_initMenus.length} data');
      } else {
        print('  ...Menus not empty. : exists ${_initMenus.length} data');
      }

      // VisitHistoriesテーブルの初期化
      if ((await vhDao.getVisitHistories()).isEmpty) {
        await vhDao.addAllVisitHistory(_initVisitHistories);
        print(
            '  ...VisitHistories init ok. : ${_initVisitHistories.length} data');
      } else {
        print(
            '  ...VisitHistories not empty. : exists ${_initVisitHistories.length} data');
      }

      print('--- initialize finished.');
    } on SqliteException catch (e) {
      print('!!sample data init Exeption：$e');
    }
  }
}
