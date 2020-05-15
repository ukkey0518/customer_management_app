import 'package:customermanagementapp/data/drop_down_menu_items/customer_narrow_state.dart';
import 'package:customermanagementapp/data/data_classes/customer_list_screen_preferences.dart';
import 'package:customermanagementapp/data/drop_down_menu_items/customer_sort_state.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:moor/moor.dart';

part 'customer_dao.g.dart';

@UseDao(tables: [
  Customers,
])
class CustomerDao extends DatabaseAccessor<MyDatabase> with _$CustomerDaoMixin {
  CustomerDao(MyDatabase db) : super(db);

  //
  // -- アセンブリ処理 -----------------------------------------------------------
  //

  // [追加：１件]
  Future<int> addCustomer(Customer customer) =>
      into(customers).insert(customer, mode: InsertMode.replace);

  // [追加：複数]
  Future<void> addAllCustomers(List<Customer> customersList) {
    return batch((batch) {
      batch.insertAll(customers, customersList, mode: InsertMode.replace);
    });
  }

  // [取得：条件付き]
  Future<List<Customer>> getCustomers(
      {CustomerListScreenPreferences preferences}) async {
    return transaction(() async {
      final narrowState = preferences?.narrowState ?? CustomerNarrowState.ALL;
      final sortState =
          preferences?.sortState ?? CustomerSortState.REGISTER_OLD;
      final searchWord = preferences?.searchWord ?? '';

      // 全取得ステートメント
      var statement = select(customers);

      // 絞り込み条件追加
      switch (narrowState) {
        case CustomerNarrowState.FEMALE:
          statement..where((t) => t.isGenderFemale);
          break;
        case CustomerNarrowState.MALE:
          statement..where((t) => t.isGenderFemale.not());
          break;
        case CustomerNarrowState.ALL:
          break;
      }

      // 並べ替え条件追加
      switch (sortState) {
        case CustomerSortState.REGISTER_OLD:
          statement
            ..orderBy([
              (t) => OrderingTerm(expression: t.id, mode: OrderingMode.asc),
            ]);
          break;
        case CustomerSortState.REGISTER_NEW:
          statement
            ..orderBy([
              (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc),
            ]);
          break;
        case CustomerSortState.NAME_FORWARD:
          statement
            ..orderBy([
              (t) => OrderingTerm(
                  expression: t.nameReading, mode: OrderingMode.asc),
            ]);
          break;
        case CustomerSortState.NAME_REVERSE:
          statement
            ..orderBy([
              (t) => OrderingTerm(
                  expression: t.nameReading, mode: OrderingMode.desc),
            ]);
          break;
      }
      // 設定された条件で取得
      final list = await statement.get();

      if (searchWord != null && searchWord.isNotEmpty) {
        list.removeWhere((customer) {
          return !(customer.name.contains(searchWord) ||
              customer.nameReading.contains(searchWord));
        });
      }

      return Future.value(list);
    });
  }

  // [削除：１件]
  Future deleteCustomer(Customer customer) => (delete(customers)
        ..where(
          (t) => t.id.equals(customer.id),
        ))
      .go();

  //
  // -- トランザクション処理 ------------------------------------------------------
  //

  // [一括処理( 追加 )：１件追加 -> 全取得]
  Future<List<Customer>> addAndGetAllCustomers(Customer customer,
      {CustomerListScreenPreferences preferences}) {
    return transaction(() async {
      await addCustomer(customer);
      return await getCustomers(preferences: preferences);
    });
  }

  // [一括処理( 追加 ) : 複数追加 -> 全取得]
  Future<List<Customer>> addAllAndGetAllCustomers(List<Customer> customersList,
      {CustomerListScreenPreferences preferences}) {
    return transaction(() async {
      await addAllCustomers(customersList);
      return await getCustomers(preferences: preferences);
    });
  }

  // [一括処理( 削除 )：１件削除 -> 全取得]
  Future<List<Customer>> deleteAndGetAllCustomers(Customer customer,
      {CustomerListScreenPreferences preferences}) {
    return transaction(() async {
      await deleteCustomer(customer);
      return await getCustomers(preferences: preferences);
    });
  }
}
