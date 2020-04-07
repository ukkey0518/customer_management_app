import 'package:moor/moor.dart';

class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get nameReading => text()();
  TextColumn get sex => text()();

  @override
  Set<Column> get primaryKey => {id};
}
