import 'package:customermanagementapp/db/database.dart';

extension ConvertFromVisitReasonList on List<VisitReason> {
  getVisitReason(int id) {
    if (this.isEmpty) return null;
    return this.singleWhere((vr) => vr.id == id);
  }
}
