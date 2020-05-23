import 'package:customermanagementapp/db/database.dart';

extension ConvertFromVHDataMap on Map<String, List<VisitHistory>> {
  // [変換：集約してすべての来店履歴を取得する]
  List<VisitHistory> toAllVisitHistories() {
    List<VisitHistory> allData = List();

    if (this.isNotEmpty) {
      final map = Map<String, List<VisitHistory>>();
      this.forEach((key, value) {
        map[key] = List<VisitHistory>()..addAll(value);
      });

      allData = map.values.reduce((v, e) {
        return e.isNotEmpty ? (v..addAll(e)) : v;
      }).toList();
    }

    return allData;
  }
}
