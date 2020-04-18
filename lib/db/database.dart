import 'dart:io';

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
  IntColumn get customerId => integer()();
  IntColumn get employeeId => integer()();
  TextColumn get menuIdsString => text()();
}

// [テーブル：売上データ(１アイテム毎)]
class SoldItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  IntColumn get customerId => integer()();
  IntColumn get employeeId => integer()();
  IntColumn get menuId => integer()();

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
  IntColumn get menuCategoryId => integer()();
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
  SoldItems,
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
      into(customers).insert(customer);

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
      into(visitHistories).insert(visitHistory);

  // [取得：すべての来店履歴を取得]
  Future<List<VisitHistory>> get allVisitHistories =>
      select(visitHistories).get();

  // [更新：１件分の来店履歴を更新]
  Future updateVisitHistory(VisitHistory visitHistory) =>
      update(visitHistories).replace(visitHistory);

  // [削除：１件分の来店履歴を削除]
  Future deleteVisitHistory(VisitHistory visitHistory) =>
      (delete(visitHistories)..where((t) => t.id.equals(visitHistory.id))).go();

  //
  //
  // -- SoldItems：売上項目１件毎のデータテーブル -----------------------------------
  //
  //

  // [追加：１件分の売上データを追加]
  Future<int> addSoldItem(SoldItem soldItem) =>
      into(soldItems).insert(soldItem);

  // [追加：複数の売上データを追加]
  Future<void> addAllSoldItems(List<SoldItem> soldItemsList) async {
    batch((batch) {
      batch.insertAll(soldItems, soldItemsList);
    });
  }

  // [取得：すべての売上データを取得]
  Future<List<SoldItem>> get allSoldItems => select(soldItems).get();

  // [取得：指定した日付の売上データを取得]
  Future<List<SoldItem>> getSoldItemsByDay(DateTime date) =>
      (select(soldItems)..where((t) => t.date.equals(date))).get();

  // [取得：指定した顧客データの売上データを取得]
  Future<List<SoldItem>> getSoldItemsByCustomer(Customer customer) =>
      (select(soldItems)..where((t) => t.customerId.equals(customer.id))).get();

  // [取得：指定したメニューの売上データを取得]
  Future<List<SoldItem>> getSoldItemsByMenu(Menu menu) =>
      (select(soldItems)..where((t) => t.menuId.equals(menu.id))).get();

  // [取得：指定した担当者の売上データを取得]
  Future<List<SoldItem>> getSoldItemsByEmployee(Employee employee) =>
      (select(soldItems)..where((t) => t.employeeId.equals(employee.id))).get();

  // [更新：１件分の売上データを更新]
  Future updateSoldItem(SoldItem soldItem) =>
      update(soldItems).replace(soldItem);

  // [削除：１件分の売上データを削除]
  Future deleteSoldItem(SoldItem salesItem) =>
      (delete(soldItems)..where((t) => t.id.equals(salesItem.id))).go();

  //
  //
  // -- MenuCategories：メニューカテゴリ ------------------------------------------
  //
  //

  // [追加：１件分のメニューカテゴリを追加]
  Future<int> addMenuCategory(MenuCategory menuCategory) =>
      into(menuCategories).insert(menuCategory);

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

  // [取得：すべてのスタッフデータを取得]
  Future<List<Employee>> get allEmployees => select(employees).get();

  // [更新：１件分のスタッフデータを更新]
  Future updateEmployee(Employee employee) =>
      update(employees).replace(employee);

  // [削除：１件分のスタッフデータを削除]
  Future deleteEmployee(Employee employee) =>
      (delete(employees)..where((t) => t.id.equals(employee.id))).go();
}
