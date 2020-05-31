import 'package:customermanagementapp/data/data_classes/visit_history_list_preferences.dart';
import 'package:customermanagementapp/data/data_classes/visit_history_narrow_data.dart';
import 'package:customermanagementapp/data/list_search_state/visit_history_sort_state.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/convert_from_visit_history_list.dart';
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
      into(visitHistories).insert(visitHistory, mode: InsertMode.replace);

  // [追加：複数の来店履歴]
  Future<void> addAllVisitHistory(List<VisitHistory> visitHistoryList) {
    return batch((batch) {
      batch.insertAll(visitHistories, visitHistoryList);
      print('  [DAO] VisitHistories saved: ${visitHistoryList.length}');
    });
  }

  // [取得：条件に一致した来店履歴を取得]
  Future<List<VisitHistory>> getVisitHistories({
    VisitHistoryListPreferences vhPref,
  }) {
    final narrow = vhPref?.narrowData ?? VisitHistoryNarrowData();
    final sort = vhPref?.sortState ?? VisitHistorySortState.REGISTER_NEW;
    final name = vhPref?.searchCustomerName ?? '';

    return transaction(() async {
      var allVisitHistory = await select(visitHistories).get();
      var result = allVisitHistory
        ..applyNarrowData(narrow)
        ..applySortState(sort)
        ..applySearchCustomerName(name);
      return result;
    });
  }

  // [取得：指定した日付の来店履歴を取得]
  Future<List<VisitHistory>> getVisitHistoriesByDay(DateTime date) =>
      (select(visitHistories)..where((t) => t.date.equals(date))).get();

  // [削除：１件分の来店履歴を削除]
  Future deleteVisitHistory(VisitHistory visitHistory) =>
      (delete(visitHistories)..where((t) => t.id.equals(visitHistory.id))).go();

  // [削除：すべての来店履歴を削除]
  Future deleteAllVisitHistories() => delete(visitHistories).go();

  //
  // -- トランザクション処理 ------------------------------------------------------
  //

  // [一括処理( 追加 )：１件追加 -> 全取得]
  Future<List<VisitHistory>> addAndGetAllVisitHistories(
      VisitHistory visitHistory,
      {VisitHistoryListPreferences vhPref}) {
    return transaction(() async {
      await addVisitHistory(visitHistory);
      return await getVisitHistories(vhPref: vhPref);
    });
  }

  // [一括処理( 追加 )：複数追加 -> 全取得]
  Future<List<VisitHistory>> addAllAndGetAllVisitHistories(
    List<VisitHistory> visitHistoryList, {
    VisitHistoryListPreferences vhPref,
  }) {
    return transaction(() async {
      await addAllVisitHistory(visitHistoryList);
      return await getVisitHistories(vhPref: vhPref);
    });
  }

  // [一括処理( 削除 )：１件削除 -> 全取得]
  Future<List<VisitHistory>> deleteAndGetAllVisitHistories(
    VisitHistory visitHistory, {
    VisitHistoryListPreferences vhPref,
  }) {
    return transaction(() async {
      await deleteVisitHistory(visitHistory);
      return await getVisitHistories(vhPref: vhPref);
    });
  }

// [一括処理( 削除 )：複数の来店履歴を削除]
  Future deleteMultipleVisitHistories(List<VisitHistory> visitHistoryList) {
    return transaction(() async {
      final vhList = await getVisitHistories();
      visitHistoryList.forEach((dVh) {
        vhList.removeWhere((cVh) => cVh.id == dVh.id);
      });
      await deleteAllVisitHistories();
      await addAllVisitHistory(vhList);
    });
  }

  // [一括処理( 更新 )：全件削除 -> 全件追加 -> 全件取得]
  Future refresh(List<VisitHistory> visitHistoryList) {
    return transaction(() async {
      await deleteAllVisitHistories();
      return await addAllAndGetAllVisitHistories(visitHistoryList);
    });
  }
}
