import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

// [テーブル：顧客データ]
// (依存：VisitReasons)
class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get nameReading => text()();
  BoolColumn get isGenderFemale => boolean()();
  DateTimeColumn get birth => dateTime().nullable()();
  TextColumn get visitReasonJson => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// [テーブル：スタッフデータ]
// (依存：なし)
class Employees extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

// [テーブル：来店動機]
// (依存：なし)
class VisitReasons extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get reason => text()();
}

// [テーブル：メニューカテゴリデータ]
// (依存：なし)
@DataClassName('MenuCategory')
class MenuCategories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get color => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

// [テーブル：メニューデータ]
// (依存：MenuCategories)
class Menus extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get menuCategoryJson => text()();
  TextColumn get name => text()();
  IntColumn get price => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

// [テーブル：来店履歴(１件毎)]
// (依存：Customers, Employees, MenuCategories, Menus)
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

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'customer.db'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [
  Customers,
  Employees,
  VisitReasons,
  MenuCategories,
  Menus,
  VisitHistories,
])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
