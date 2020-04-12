import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get nameReading => text()();
  BoolColumn get isGenderFemale => boolean()();
  DateTimeColumn get birth => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class SalesMenuRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  IntColumn get customerId => integer()();
  IntColumn get menuId => integer()();
  IntColumn get stuffId => integer()();
  IntColumn get discountId => integer()();
  IntColumn get price => integer()();

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

@UseMoor(tables: [Customers, SalesMenuRecords])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  //
  //
  // -- Customer：顧客データ -----------------------------------------------------
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
  // -- SalesMenuRecord：売上項目１件分のデータ -----------------------------------
  //
  //

  // [追加：１件分の売上データを追加]
  Future<int> addSalesMenuRecord(SalesMenuRecord salesMenuRecord) =>
      into(salesMenuRecords).insert(salesMenuRecord);

  // [取得：すべての売上データを取得]
  Future<List<SalesMenuRecord>> get allSalesMenuRecords =>
      select(salesMenuRecords).get();

  // [取得：指定した日付の売上データを取得]
  Future<List<SalesMenuRecord>> getSalesMenuRecordsByDay(DateTime date) =>
      (select(salesMenuRecords)..where((t) => t.date.equals(date))).get();

  // [取得：指定した顧客データの売上データを取得]
  Future<List<SalesMenuRecord>> getSalesMenuRecordsByCustomer(
          Customer customer) =>
      (select(salesMenuRecords)..where((t) => t.customerId.equals(customer.id)))
          .get();

  //TODO Read[指定メニューの売上データをつべて抽出する]
  //TODO Read[指定担当者の売上データをすべて抽出する]

  // [更新：１件分の売上データを更新]
  Future updateSalesMenuRecord(SalesMenuRecord salesMenuRecord) =>
      update(salesMenuRecords).replace(salesMenuRecord);

  // [削除：１件分の売上データを削除]
  Future deleteSalesMenuRecord(SalesMenuRecord salesMenuRecord) =>
      (delete(salesMenuRecords)..where((t) => t.id.equals(salesMenuRecord.id)))
          .go();
}
