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
              customer.toJsonString(),
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
}
