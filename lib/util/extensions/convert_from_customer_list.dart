import 'package:customermanagementapp/db/database.dart';

extension ConvertFromCustomerList on List<Customer> {
  // [判定：名前の重複を確認]
  bool isNameDuplicated(String name) {
    var nameList = this.map((c) => c.name);
    return nameList.contains(name);
  }
}
