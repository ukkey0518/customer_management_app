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

  // [更新：VisitReasonリストの変更を反映]
  List<Customer> getUpdate(List<VisitReason> visitReasons) {
    if (this == null || visitReasons == null) return List();

    final newCList = List<Customer>();

    this.forEach(
      (customer) {
        final vrId = customer.visitReasonJson.toVisitReason().id;

        VisitReason vr = visitReasons.getVisitReason(vrId);

        newCList.add(
          Customer(
            id: customer.id,
            name: customer.name,
            nameReading: customer.nameReading,
            isGenderFemale: customer.isGenderFemale,
            birth: customer.birth,
            visitReasonJson: vr.toJsonString(),
          ),
        );
      },
    );
    return newCList;
  }
}
