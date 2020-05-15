import 'package:customermanagementapp/db/database.dart';
import 'package:moor/moor.dart';

part 'visit_reason_dao.g.dart';

@UseDao(tables: [VisitReasons])
class VisitReasonDao extends DatabaseAccessor<MyDatabase>
    with _$VisitReasonDaoMixin {
  VisitReasonDao(MyDatabase db) : super(db);

  //
  // -- アセンブリ処理 --
  //

  // [追加：１件]
  addVisitReason(VisitReason visitReason) =>
      into(visitReasons).insert(visitReason);

  // [追加：複数]
  addAllVisitReasons(List<VisitReason> visitReasonList) {
    batch((batch) {
      batch.insertAll(visitReasons, visitReasonList);
    });
  }

  // [取得：すべて]
  get allVisitReasons => select(visitReasons).get();

  // [削除：１件]
  deleteVisitReason(VisitReason visitReason) =>
      (delete(visitReasons)..where((t) => t.id.equals(visitReason.id))).go();

  //
  // -- トランザクション処理 --
  //

  // [追加：１件追加 -> 全取得]
  addAndGetAllVisitReasons(VisitReason visitReason) {
    return transaction(() async {
      await addVisitReason(visitReason);
      return await allVisitReasons;
    });
  }

  // [追加：複数追加 -> 全取得]
  addAllAndGetAllVisitReasons(List<VisitReason> visitReasonList) {
    return transaction(() async {
      await addAllVisitReasons(visitReasonList);
      return await allVisitReasons;
    });
  }

  // [削除：１件削除 -> 全取得]
  deleteAndGetAllVisitReasons(VisitReason visitReason) {
    return transaction(() async {
      await deleteVisitReason(visitReason);
      return await allVisitReasons;
    });
  }
}
