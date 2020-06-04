import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';

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

  // [変換：出力用文字列を取得]
  String toPrintText({
    bool showId = false,
    bool showName = true,
    bool showNameReading = false,
    bool showGender = false,
    bool showBirth = false,
    bool showVisitReason = false,
  }) {
    final str = List<Customer>.from(this).map<String>(
      (e) {
        return e.toPrintText(
          showId: showId,
          showName: showName,
          showNameReading: showNameReading,
          showGender: showGender,
          showBirth: showBirth,
          showVisitReason: showVisitReason,
        );
      },
    ).join(', ');

    return 'CustomerList{$str}';
  }
}
