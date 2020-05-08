import 'package:customermanagementapp/db/database.dart';
import 'package:moor/moor.dart';

part 'employee_dao.g.dart';

@UseDao(tables: [Employees])
class EmployeeDao extends DatabaseAccessor<MyDatabase> with _$EmployeeDaoMixin {
  EmployeeDao(MyDatabase db) : super(db);

  //
  // -- アセンブリ処理 -----------------------------------------------------------
  //

  // [追加：１件]
  Future<int> addEmployee(Employee employee) =>
      into(employees).insert(employee, mode: InsertMode.replace);

  // [追加：複数]
  Future<void> addAllEmployees(List<Employee> employeesList) async {
    await batch((batch) {
      batch.insertAll(employees, employeesList);
    });
  }

  // [取得：すべて]
  Future<List<Employee>> get allEmployees => select(employees).get();

  // [削除：１件]
  Future deleteEmployee(Employee employee) =>
      (delete(employees)..where((t) => t.id.equals(employee.id))).go();

  //
  // -- トランザクション処理 ------------------------------------------------------
  //

  // [一括処理( 追加 )：１件追加 -> 全取得]
  Future<List<Employee>> addAndGetAllEmployees(Employee employee) {
    return transaction(() async {
      await addEmployee(employee);
      return await allEmployees;
    });
  }

  // [一括処理( 追加 )：複数追加 -> 全取得]
  Future<List<Employee>> addAllAndGetAllEmployees(
      List<Employee> employeesList) {
    return transaction(() async {
      await addAllEmployees(employeesList);
      return await allEmployees;
    });
  }

  // [一括処理( 削除 )：１件削除 -> 全取得]
  Future<List<Employee>> deleteAndGetAllEmployees(Employee employee) {
    return transaction(() async {
      await deleteEmployee(employee);
      return await allEmployees;
    });
  }
}
