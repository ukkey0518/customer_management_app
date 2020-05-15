import 'package:customermanagementapp/db/database.dart';

extension ConvertFromCustomerList on List<Customer> {
  // [判定：名前の重複を確認]
  bool isNameDuplicated(int id, String name) {
    var customersExcludingSelf = List();
    customersExcludingSelf.addAll(this);
    if (id != null) {
      customersExcludingSelf.removeWhere((c) => c.id == id);
    }
    var nameList = customersExcludingSelf.map((c) => c.name);
    return nameList.contains(name);
  }

  // [取得：IDから顧客を取得]
  Customer getCustomer(int id) {
    if (this == null || id == null) return null;
    return this.singleWhere((customer) => customer.id == id);
  }
}
