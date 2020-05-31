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

class SampleDataInitializer {
  static SampleDataInitializer _instance;

  factory SampleDataInitializer() {
    if (_instance == null) _instance = SampleDataInitializer._internal();
    return _instance;
  }

  SampleDataInitializer._internal();

  static final reasons = visitReasonData.keys.toList();

  // [初期データ：顧客]
  static final List<Customer> _initCustomers = _createInitCustomerList(20);

  // [初期データ：従業員]
  static final List<Employee> _initEmployees = _createInitEmployeeList(5);

  // [初期データ：メニューカテゴリ]
  static final List<MenuCategory> _initMenuCategories =
      _createInitMenuCategoryList(10);

  // [初期データ：メニュー]
  static final List<Menu> _initMenus = _createInitMenuList(30);

  // [初期データ：来店履歴]
  static final List<VisitHistory> _initVisitHistories =
      _createInitVhList(300, DateTime(2019, 1, 1), DateTime.now());

  // [初期化を実行する]
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
      print('!!sample data init Exception：$e');
    }
  }

  // [データ作成：顧客リスト]
  static List<Customer> _createInitCustomerList(int length) {
    List<Customer> customers = List();

    String randomName;
    bool randomGender;

    customers = List<Customer>.generate(length, (index) {
      randomGender = mockInteger(0, 10) % 2 == 0 ? true : false;
      randomName = mockName(randomGender ? 'female' : 'male');
      return Customer(
        id: index + 1,
        name: randomName,
        nameReading: randomName,
        isGenderFemale: randomGender,
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
  static _createInitVhList(int length, DateTime since, DateTime until) {
    List<VisitHistory> vhList = List();

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
