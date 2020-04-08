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
  TextColumn get gender => text()();

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

@UseMoor(tables: [Customers])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Create[１件分を追加]
  Future<int> addCustomer(Customer customer) =>
      into(customers).insert(customer);

  // Read[すべてを抽出]
  Future<List<Customer>> get allCustomers => select(customers).get();

  // Read[性別毎のデータを抽出]
  Stream<List<Customer>> maleCustomers(String gender) => (select(customers)
        ..where(
          (t) => t.gender.equals(gender),
        ))
      .watch();

  // Read[指定の名前に一致するデータを抽出する]
  Future<Customer> getCustomers(String name) => (select(customers)
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
}
