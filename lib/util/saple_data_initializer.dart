import 'package:customermanagementapp/data/visit_reason_data.dart';
import 'package:customermanagementapp/db/dao/customer_dao.dart';
import 'package:customermanagementapp/db/dao/employee_dao.dart';
import 'package:customermanagementapp/db/dao/menu_category_dao.dart';
import 'package:customermanagementapp/db/dao/menu_dao.dart';
import 'package:customermanagementapp/db/dao/visit_history_dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:mock_data/mock_data.dart';
import 'package:moor_ffi/database.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SampleDataInitializer {
  static SampleDataInitializer _instance;

  factory SampleDataInitializer() {
    if (_instance == null) _instance = SampleDataInitializer._internal();
    return _instance;
  }

  SampleDataInitializer._internal();

  // [SharedPreferencesオブジェクト]
  static SharedPreferences prefs;

  static final reasons = visitReasonData.keys.toList();

  // [初期データ：顧客]
  static List<Customer> _initCustomers = List();

  // [初期データ：従業員]
  static List<Employee> _initEmployees = List();

  // [初期データ：メニューカテゴリ]
  static List<MenuCategory> _initMenuCategories = List();

  // [初期データ：メニュー]
  static List<Menu> _initMenus = List();

  // [初期データ：来店履歴]
  static List<VisitHistory> _initVisitHistories = List();

  // [初期化を実行する]
  initialize(
    BuildContext context, {
    int customersLength = 10,
    int employeesLength = 5,
    int menuCategoriesLength = 10,
    int menusLength = 30,
    int visitHistoriesLength = 100,
    DateTime sinceDate,
    DateTime untilDate,
  }) async {
    print('--- sample data init check start ...');
    prefs = await SharedPreferences.getInstance();

    final savedCustomers = prefs.getInt('customer');
    final savedEmployees = prefs.getInt('employee');
    final savedCategories = prefs.getInt('menuCategory');
    final savedMenus = prefs.getInt('menu');
    final savedVisitHistories = prefs.getInt('visitHistory');

    final customerDao = Provider.of<CustomerDao>(context, listen: false);
    final employeeDao = Provider.of<EmployeeDao>(context, listen: false);
    final menuCategoryDao =
        Provider.of<MenuCategoryDao>(context, listen: false);
    final menuDao = Provider.of<MenuDao>(context, listen: false);
    final vhDao = Provider.of<VisitHistoryDao>(context, listen: false);

    try {
      //Customersテーブルの初期化

      print('[CHECK] Customer Data...');
      if (savedCustomers == null || savedCustomers == 0) {
        print('  Empty.');

        print('  init data creating...');
        _initCustomers = _createInitCustomerList(customersLength);
        print('  -> OK.');

        print('  init data adding DB...');
        await customerDao.addAllCustomers(_initCustomers);
        print('  -> OK.');

        print('  setting preference...');
        await prefs.setInt('customer', _initCustomers.length);
        print('  -> OK.');

        print('  ...Customers ${_initCustomers.length} data init.');
      } else {
        print('  Not Empty.');

        print('  ...Customers $savedCustomers data exists.');
      }

      // Employeesテーブルの初期化
      print('[CHECK] Employee Data...');
      if (savedEmployees == null || savedEmployees == 0) {
        print('  Empty.');

        print('  init data creating...');
        _initEmployees = _createInitEmployeeList(employeesLength);
        print('  -> OK.');

        print('  init data adding DB...');
        await employeeDao.addAllEmployees(_initEmployees);
        print('  -> OK.');

        print('  setting preference...');
        await prefs.setInt('employee', _initEmployees.length);
        print('  -> OK.');

        print('  ...Employees ${_initEmployees.length} data init.');
      } else {
        print('  Not Empty.');

        print('  ...Employees: $savedEmployees data exists.');
      }

      // MenuCategoriesテーブルの初期化
      print('[CHECK] MenuCategory Data...');
      if (savedCategories == null || savedCategories == 0) {
        print('  Empty.');

        print('  init data creating...');
        _initMenuCategories = _createInitMenuCategoryList(menuCategoriesLength);
        print('  -> OK.');

        print('  init data adding DB...');
        await menuCategoryDao.addAllMenuCategories(_initMenuCategories);
        print('  -> OK.');

        print('  setting preference...');
        await prefs.setInt('menuCategory', _initMenuCategories.length);
        print('  -> OK.');

        print('  ...MenuCategories: ${_initMenuCategories.length} data init.');
      } else {
        print('  Not Empty.');

        print('  ...MenuCategories: $savedCategories data exists.');
      }

      // Menusテーブルの初期化
      print('[CHECK] Menus Data...');
      if (savedMenus == null || savedMenus == 0) {
        print('  Empty.');

        print('  init data creating...');
        _initMenus = _createInitMenuList(menusLength);
        print('  -> OK.');

        print('  init data adding DB...');
        await menuDao.addAllMenus(_initMenus);
        print('  -> OK.');

        print('  setting preference...');
        await prefs.setInt('menu', _initMenus.length);
        print('  -> OK.');

        print('  ...Menus: ${_initMenus.length} data init.');
      } else {
        print('  Not Empty.');

        print('  ...Menus: $savedMenus data exists.');
      }

      // VisitHistoriesテーブルの初期化
      print('[CHECK] VisitHistory Data...');
      if (savedVisitHistories == null || savedVisitHistories == 0) {
        print('  Empty.');

        print('  init data creating...');
        _initVisitHistories =
            _createInitVhList(visitHistoriesLength, sinceDate, untilDate);
        print('  -> OK.');

        print('  init data adding DB...');
        await vhDao.addAllVisitHistory(_initVisitHistories);
        print('  -> OK.');

        print('  setting preference...');
        await prefs.setInt('visitHistory', _initVisitHistories.length);
        print('  -> OK.');

        print('  ...VisitHistories: ${_initVisitHistories.length} data init.');
      } else {
        print('  Not Empty.');

        print('  ...VisitHistories: $savedVisitHistories data exists.');
      }

      print('--- initialize finished.');
    } on SqliteException catch (e) {
      print('  Empty.');
      print('[!!]sample data init Exception：$e');
    }
  }

  // [データ作成：顧客リスト]
  static List<Customer> _createInitCustomerList(int length) {
    List<Customer> customers = List();

    String randomName;
    bool randomGender;
    DateTime randomBirth;
    int randomVisitReason;

    customers = List<Customer>.generate(length, (index) {
      randomGender = mockInteger(0, 10) % 2 == 0 ? true : false;
      randomName = mockName(randomGender ? 'female' : 'male');
      randomBirth = mockDate(DateTime(1990, 1, 1), DateTime(2000, 1, 1));
      final vrList = visitReasonData.keys.toList();
      randomVisitReason = mockInteger(0, vrList.length - 1);
      final vr = vrList[randomVisitReason];
      return Customer(
        id: index + 1,
        name: randomName,
        nameReading: randomName,
        isGenderFemale: randomGender,
        birth: randomBirth,
        visitReason: vr,
      );
    }).toList();

    return customers;
  }

  // [データ作成：従業員リスト]
  static List<Employee> _createInitEmployeeList(int length) {
    List<Employee> employees = List();

    String randomName;
    bool randomGender;

    employees = List<Employee>.generate(length, (index) {
      randomGender = mockInteger(1, 10) % 2 == 0 ? true : false;
      randomName = mockName(randomGender ? 'female' : 'male');
      return Employee(
        id: index + 1,
        name: randomName,
      );
    }).toList();

    return employees;
  }

  // [データ作成：メニューカテゴリリスト]
  static List<MenuCategory> _createInitMenuCategoryList(int length) {
    List<MenuCategory> categories = List();

    String randomName;
    int randomColor;

    categories = List<MenuCategory>.generate(length, (index) {
      randomName = mockString(10);
      final colorStr = mockColor();
      randomColor = int.parse(
          'ff${colorStr.substring(4, colorStr.length - 1).split(', ').map<String>((str) => int.parse(str).toRadixString(16)).join()}',
          radix: 16);
      return MenuCategory(
        id: index + 1,
        name: randomName,
        color: randomColor,
      );
    }).toList();

    return categories;
  }

  // [データ作成：メニューリスト]
  static List<Menu> _createInitMenuList(int length) {
    List<Menu> menus = List();

    String randomName;
    int randomCategory;
    int randomPrice;

    menus = List<Menu>.generate(length, (index) {
      randomName = mockString(10);
      randomCategory = mockInteger(0, _initMenuCategories.length - 1);
      randomPrice = 1000 + (mockInteger(0, 40) * 1000);
      return Menu(
        id: index + 1,
        name: randomName,
        price: randomPrice,
        menuCategoryJson: _initMenuCategories[randomCategory].toJsonString(),
      );
    }).toList();

    return menus;
  }

  // [データ作成：来店履歴リスト]
  static _createInitVhList(int length, DateTime sinceDate, DateTime untilDate) {
    List<VisitHistory> vhList = List();

    DateTime since = sinceDate ?? DateTime(2019, 1, 1);
    DateTime until = untilDate ?? DateTime.now();

    List<DateTime> dateList = List();
    int randomCustomer;
    int randomEmployee;
    int menuListLength;
    List<Menu> menus;

    dateList = List<DateTime>.generate(length, (index) {
      final date = mockDate(since, until);
      return DateTime(date.year, date.month, date.day);
    }).toList();

    vhList = dateList.map<VisitHistory>((date) {
      randomCustomer = mockInteger(0, _initCustomers.length - 1);
      randomEmployee = mockInteger(0, _initEmployees.length - 1);
      menuListLength = mockInteger(1, 3);

      menus = List<Menu>.generate(menuListLength, (index) {
        return _initMenus[mockInteger(0, _initMenus.length - 1)];
      }).toList();

      return VisitHistory(
        id: null,
        date: date,
        customerJson: _initCustomers[randomCustomer].toJsonString(),
        employeeJson: _initEmployees[randomEmployee].toJsonString(),
        menuListJson: menus.toJsonString(),
      );
    }).toList();

    return vhList;
  }
}
