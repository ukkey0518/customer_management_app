import 'dart:io';

import 'package:customermanagementapp/util/inter_converter.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

// [テーブル：顧客データ]
class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get nameReading => text()();
  BoolColumn get isGenderFemale => boolean()();
  DateTimeColumn get birth => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// [テーブル：来店履歴(１件毎)]
@DataClassName('VisitHistory')
class VisitHistories extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  TextColumn get customerJson => text()();
  TextColumn get employeeJson => text()();
  TextColumn get menuListJson => text()();

  @override
  Set<Column> get primaryKey => {id};
}

// [テーブル：メニューカテゴリデータ]
@DataClassName('MenuCategory')
class MenuCategories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get color => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

// [テーブル：メニューデータ]
class Menus extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get menuCategoryJson => text()();
  TextColumn get name => text()();
  IntColumn get price => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

// [テーブル：スタッフデータ]
class Employees extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'customer.db'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [
  Customers,
  VisitHistories,
  MenuCategories,
  Menus,
  Employees,
])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  //
  //
  // -- Customer：顧客データテーブル -----------------------------------------------------
  //
  //

  // [追加：１件追加]
  Future<int> addCustomer(Customer customer) =>
      into(customers).insert(customer, orReplace: true);

  // [追加：渡されたデータをすべて追加]
  Future<void> addAllCustomers(List<Customer> customersList) async {
    await batch((batch) {
      batch.insertAll(customers, customersList);
    });
  }

  // [取得：すべての顧客情報を取得]
  Future<List<Customer>> get allCustomers => select(customers).get();

  // [取得：女性顧客データを取得]
  Future<List<Customer>> get femaleCustomers =>
      (select(customers)..where((t) => t.isGenderFemale)).get();

  // [取得：男性顧客データを取得]
  Future<List<Customer>> get maleCustomers =>
      (select(customers)..where((t) => t.isGenderFemale.not())).get();

  // [取得：指定した顧客IDに一致する顧客データを取得]
  Future<Customer> getCustomersById(int id) =>
      (select(customers)..where((t) => t.id.equals(id))).getSingle();

  // [取得：指定した名前に一致する顧客データを取得]
  Future<Customer> getCustomersByName(String name) =>
      (select(customers)..where((t) => t.name.equals(name))).getSingle();

  // [更新：１件分の顧客データを更新]
  Future updateCustomer(Customer customer) =>
      update(customers).replace(customer);

  // [削除：１件分の顧客データを削除]
  Future deleteCustomer(Customer customer) =>
      (delete(customers)..where((t) => t.id.equals(customer.id))).go();

  //
  //
  // -- VisitHistories：来店履歴１件毎のデータテーブル -----------------------------------
  //
  //

  // [追加：１件分の来店履歴]
  Future<int> addVisitHistory(VisitHistory visitHistory) =>
      into(visitHistories).insert(visitHistory, orReplace: true);

  // [取得：すべての来店履歴を取得]
  Future<List<VisitHistory>> get allVisitHistories =>
      select(visitHistories).get();

  // [取得：指定した顧客の来店履歴を取得]
  Future<List<VisitHistory>> getVisitHistoriesByCustomer(Customer customer) {
    return (select(visitHistories)
          ..where(
            (t) => t.customerJson.equals(
              InterConverter.customerToJson(customer),
            ),
          ))
        .get();
  }

  // [取得：指定した日付の来店履歴を取得]
  Future<List<VisitHistory>> getVisitHistoriesByDay(DateTime date) =>
      (select(visitHistories)..where((t) => t.date.equals(date))).get();

  // [更新：１件分の来店履歴を更新]
  Future updateVisitHistory(VisitHistory visitHistory) =>
      update(visitHistories).replace(visitHistory);

  // [削除：１件分の来店履歴を削除]
  Future deleteVisitHistory(VisitHistory visitHistory) =>
      (delete(visitHistories)..where((t) => t.id.equals(visitHistory.id))).go();

  //
  //
  // -- MenuCategories：メニューカテゴリ ------------------------------------------
  //
  //

  // [追加：１件分のメニューカテゴリを追加]
  Future<int> addMenuCategory(MenuCategory menuCategory) =>
      into(menuCategories).insert(menuCategory);

  // [追加：渡されたデータをすべて追加]
  Future<void> addAllMenuCategories(
      List<MenuCategory> menuCategoriesList) async {
    await batch((batch) {
      batch.insertAll(menuCategories, menuCategoriesList);
    });
  }

  // [取得：すべてのメニューカテゴリを取得]
  Future<List<MenuCategory>> get allMenuCategories =>
      select(menuCategories).get();

  // [更新：１件分のメニューカテゴリを更新]
  Future updateMenuCategory(MenuCategory menuCategory) =>
      update(menuCategories).replace(menuCategory);

  // [削除：１件分のメニューカテゴリを削除]
  Future deleteMenuCategory(MenuCategory menuCategory) =>
      (delete(menuCategories)..where((t) => t.name.equals(menuCategory.name)))
          .go();

  //
  //
  // -- Menus：メニューデータ ------------------------------------------
  //
  //

  // [追加：１件分のメニューを追加]
  Future<int> addMenu(Menu menu) => into(menus).insert(menu);

  // [追加：渡されたデータをすべて追加]
  Future<void> addAllMenus(List<Menu> menusList) async {
    await batch((batch) {
      batch.insertAll(menus, menusList);
    });
  }

  // [取得：すべてのメニューを取得]
  Future<List<Menu>> get allMenus => select(menus).get();

  // [更新：１件分のメニューを更新]
  Future updateMenu(Menu menu) => update(menus).replace(menu);

  // [削除：１件分のメニューを削除]
  Future deleteMenu(Menu menu) =>
      (delete(menus)..where((t) => t.id.equals(menu.id))).go();

  //
  //
  // -- Employees：スタッフデータ ------------------------------------------
  //
  //

  // [追加：１件分のスタッフデータを追加]
  Future<int> addEmployee(Employee employee) =>
      into(employees).insert(employee);

  // [追加：渡されたデータをすべて追加]
  Future<void> addAllEmployees(List<Employee> employeesList) async {
    await batch((batch) {
      batch.insertAll(employees, employeesList);
    });
  }

  // [取得：すべてのスタッフデータを取得]
  Future<List<Employee>> get allEmployees => select(employees).get();

  // [取得：IDからスタッフデータを取得]
  Future<Employee> getEmployeeById(int employeeId) {
    return (select(employees)..where((t) => t.id.equals(employeeId)))
        .getSingle();
  }

  // [更新：１件分のスタッフデータを更新]
  Future updateEmployee(Employee employee) =>
      update(employees).replace(employee);

  // [削除：１件分のスタッフデータを削除]
  Future deleteEmployee(Employee employee) =>
      (delete(employees)..where((t) => t.id.equals(employee.id))).go();
}
