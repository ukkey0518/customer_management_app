import 'package:customermanagementapp/db/database.dart';

extension ConvertFromEmployeeList on List<Employee> {
  getEmployee(int id) {
    if (this.isEmpty) return null;
    return this.singleWhere((em) => em.id == id);
  }
}
