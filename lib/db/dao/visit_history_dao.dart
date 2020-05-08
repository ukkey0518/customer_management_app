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

  // [追加：１件分の来店履歴]
  Future<int> addVisitHistory(VisitHistory visitHistory) =>
      into(visitHistories).insert(visitHistory, orReplace: true);

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

  // [取得：指定した顧客の来店履歴を取得]
  Future<VisitHistoriesByCustomer> getVisitHistoriesByCustomer(
      Customer customer) {
    return transaction(() async {
      final histories = await (select(visitHistories)
            ..where(
              (t) => t.customerJson.equals(
                customer.toJsonString(),
              ),
            ))
          .get();
      return VisitHistoriesByCustomer(customer: customer, histories: histories);
    });
  }

  // [取得：顧客別の来店履歴をすべて取得]
  Future<List<VisitHistoriesByCustomer>> getAllVisitHistoriesByCustomers() {
//    return transaction(() async {
//      final customers = await getCustomers();
//      final visitHistories = await getVisitHistories();
//      List<VisitHistoriesByCustomer> visitHistoriesByCustomers = List();
//
//      customers.forEach((customer) {
//        final historiesByCustomer = visitHistories.where((history) {
//          final customerOfVisitHistory = history.customerJson.toCustomer();
//          return customerOfVisitHistory.id == customer.id;
//        }).toList();
//        visitHistoriesByCustomers.add(VisitHistoriesByCustomer(
//          customer: customer,
//          histories: historiesByCustomer,
//        ));
//      });
//
//      return Future.value(visitHistoriesByCustomers);
//    });
  }

  // [取得：指定した日付の来店履歴を取得]
  Future<List<VisitHistory>> getVisitHistoriesByDay(DateTime date) =>
      (select(visitHistories)..where((t) => t.date.equals(date))).get();

  // [更新：１件分の来店履歴を更新]
  Future updateVisitHistory(VisitHistory visitHistory) =>
      update(visitHistories).replace(visitHistory);

  // [削除：１件分の来店履歴を削除]
  Future deleteVisitHistory(VisitHistory visitHistory) =>
      (delete(visitHistories)..where((t) => t.id.equals(visitHistory.id))).go();
}
