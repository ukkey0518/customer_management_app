import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/data/data_classes/visit_history_narrow_state.dart';
import 'package:customermanagementapp/data/visit_history_sort_state.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions.dart';
import 'package:moor/moor.dart';

part 'visit_history_dao.g.dart';

@UseDao(tables: [VisitHistories])
class VisitHistoryDao extends DatabaseAccessor<MyDatabase>
    with _$VisitHistoryDaoMixin {
  VisitHistoryDao(MyDatabase db) : super(db);

  //
  // -- アセンブリ処理 -----------------------------------------------------------
  //

  // [追加：１件分の来店履歴]
  Future<int> addVisitHistory(VisitHistory visitHistory) =>
      into(visitHistories).insert(visitHistory, orReplace: true);

  // [追加：複数の来店履歴]
  Future<int> addAllVisitHistory(List<VisitHistory> visitHistoryList) {
    return batch((batch) {
      batch.insertAll(visitHistories, visitHistoryList);
    });
  }

  // [取得：条件に一致した来店履歴を取得]
  Future<List<VisitHistory>> getVisitHistories({
    VisitHistoryNarrowData narrowData,
    VisitHistorySortState sortState,
  }) {
    final narrow = narrowData ?? VisitHistoryNarrowData();
    final sort = sortState ?? VisitHistorySortState.REGISTER_NEW;

    return transaction(() async {
      var allVisitHistory = await select(visitHistories).get();
      var result = allVisitHistory
        ..applyNarrowData(narrow)
        ..applySortState(sort);
      return result;
    });
  }

  // [取得：指定した日付の来店履歴を取得]
  Future<List<VisitHistory>> getVisitHistoriesByDay(DateTime date) =>
      (select(visitHistories)..where((t) => t.date.equals(date))).get();

  // [削除：１件分の来店履歴を削除]
  Future deleteVisitHistory(VisitHistory visitHistory) =>
      (delete(visitHistories)..where((t) => t.id.equals(visitHistory.id))).go();

  //
  // -- トランザクション処理 ------------------------------------------------------
  //

  // [一括処理( 追加 )：１件追加 -> 全取得]
  Future<List<VisitHistory>> addAndGetAllVisitHistories(
    VisitHistory visitHistory, {
    VisitHistoryNarrowData narrowData,
    VisitHistorySortState sortState,
  }) {
    return transaction(() async {
      await addVisitHistory(visitHistory);
      return await getVisitHistories(
          narrowData: narrowData, sortState: sortState);
    });
  }

  // [一括処理( 追加 )：複数追加 -> 全取得]
  Future<List<VisitHistory>> addAllAndGetAllVisitHistories(
    List<VisitHistory> visitHistoryList, {
    VisitHistoryNarrowData narrowData,
    VisitHistorySortState sortState,
  }) {
    return transaction(() async {
      await addAllVisitHistory(visitHistoryList);
      return await getVisitHistories(
          narrowData: narrowData, sortState: sortState);
    });
  }

  // [一括処理( 削除 )：１件削除 -> 全取得]
  Future<List<VisitHistory>> deleteAndGetAllVisitHistories(
    VisitHistory visitHistory, {
    VisitHistoryNarrowData narrowData,
    VisitHistorySortState sortState,
  }) {
    return transaction(() async {
      await deleteVisitHistory(visitHistory);
      return await getVisitHistories(
          narrowData: narrowData, sortState: sortState);
    });
  }
}
