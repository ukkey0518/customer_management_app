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

  // Create[１件分を追加]
  Future<int> addCustomer(Customer customer) =>
      into(customers).insert(customer);

  // Read[すべてを抽出]
  Future<List<Customer>> get allCustomers => select(customers).get();

  // Read[女性のデータを抽出]
  Future<List<Customer>> get femaleCustomers => (select(customers)
        ..where(
          (t) => t.isGenderFemale,
        ))
      .get();

  // Read[男性のデータを抽出]
  Future<List<Customer>> get maleCustomers => (select(customers)
        ..where(
          (t) => t.isGenderFemale.not(),
        ))
      .get();

  // Read[指定のIDに一致するデータを抽出する]
  Future<Customer> getCustomersById(int id) => (select(customers)
        ..where(
          (t) => t.id.equals(id),
        ))
      .getSingle();

  // Read[指定の名前に一致するデータを抽出する]
  Future<Customer> getCustomersByName(String name) => (select(customers)
        ..where(
          (t) => t.name.equals(name),
        ))
      .getSingle();

  // Update[１件分を更新]
  Future updateCustomer(Customer customer) =>
      update(customers).replace(customer);

  // Delete[１件分を削除]
  Future deleteCustomer(Customer customer) => (delete(customers)
        ..where(
          (t) => t.id.equals(customer.id),
        ))
      .go();

  //---------------------------------------------------------------------------

  // Create[１件分の売上データを追加]
  Future<int> addSalesMenuRecord(SalesMenuRecord salesMenuRecord) =>
      into(salesMenuRecords).insert(salesMenuRecord);

  // Read[すべての売上データを抽出]
  Future<List<SalesMenuRecord>> get allSalesMenuRecords =>
      select(salesMenuRecords).get();

  // Read[指定日の売上データをすべて抽出する]
  Future<List<SalesMenuRecord>> getSalesMenuRecordsByDay(DateTime date) =>
      (select(salesMenuRecords)
            ..where(
              (t) => t.date.equals(date),
            ))
          .get();

  // Read[指定顧客の売上データをすべて抽出する]
  Future<List<SalesMenuRecord>> getSalesMenuRecordsByCustomer(
          Customer customer) =>
      (select(salesMenuRecords)
            ..where(
              (t) => t.customerId.equals(customer.id),
            ))
          .get();

  //TODO Read[指定メニューの売上データをつべて抽出する]
  //TODO Read[指定担当者の売上データをすべて抽出する]

  // Update[１件分の売上データを更新]
  Future updateSalesMenuRecord(SalesMenuRecord salesMenuRecord) =>
      update(salesMenuRecords).replace(salesMenuRecord);

  // Delete[１件分の売上データを削除]
  Future deleteSalesMenuRecord(SalesMenuRecord salesMenuRecord) =>
      (delete(salesMenuRecords)
            ..where(
              (t) => t.id.equals(salesMenuRecord.id),
            ))
          .go();
}
