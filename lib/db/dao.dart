import 'package:customermanagementapp/data/visit_history_sort_state.dart';
import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/data/data_classes/visit_history_narrow_state.dart';
import 'package:moor/moor.dart';

import 'package:customermanagementapp/util/extensions.dart';
import '../data/list_status.dart';
import 'database.dart';
part 'dao.g.dart';

@UseDao(tables: [
  Customers,
  Employees,
  MenuCategories,
  Menus,
  VisitHistories,
])
class MyDao extends DatabaseAccessor<MyDatabase> with _$MyDaoMixin {
  MyDao(MyDatabase db) : super(db);

  //
  //
  // -- Customer：顧客データテーブル -----------------------------------------------------
  //
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
  Future<List<Customer>> getCustomers({
    CustomerNarrowState narrowState = CustomerNarrowState.ALL,
    CustomerSortState sortState = CustomerSortState.REGISTER_OLD,
  }) async {
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
            (t) =>
                OrderingTerm(expression: t.nameReading, mode: OrderingMode.asc),
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
    return statement.get();
  }

  // [削除：１件]
  Future deleteCustomer(Customer customer) => (delete(customers)
        ..where(
          (t) => t.id.equals(customer.id),
        ))
      .go();

  // [一括処理( 追加 )：１件追加 -> 全取得]
  Future<List<Customer>> addAndGetAllCustomers(
    Customer customer, {
    CustomerNarrowState narrowState,
    CustomerSortState sortState,
  }) {
    return transaction(() async {
      await addCustomer(customer);
      return await getCustomers(
        narrowState: narrowState,
        sortState: sortState,
      );
    });
  }

  // [一括処理( 追加 ) : 複数追加 -> 全取得]
  Future<List<Customer>> addAllAndGetAllCustomers(List<Customer> customersList,
      {CustomerNarrowState narrowState, CustomerSortState sortState}) {
    return transaction(() async {
      await addAllCustomers(customersList);
      return await getCustomers(narrowState: narrowState, sortState: sortState);
    });
  }

  // [一括処理( 削除 )：１件削除 -> 全取得]
  Future<List<Customer>> deleteAndGetAllCustomers(Customer customer,
      {CustomerNarrowState narrowState, CustomerSortState sortState}) {
    return transaction(() async {
      await deleteCustomer(customer);
      return await getCustomers(narrowState: narrowState, sortState: sortState);
    });
  }

  //
  //
  // -- Employees：スタッフデータ ------------------------------------------
  //
  //

  // [追加：１件]
  Future<int> addEmployee(Employee employee) =>
      into(employees).insert(employee, mode: InsertMode.replace);

  // [追加：複数]
  Future<void> addAllEmployees(List<Employee> employeesList) async {
    await batch((batch) {
      batch.insertAll(employees, employeesList);
    });
  }

  // [取得：すべて]
  Future<List<Employee>> get allEmployees => select(employees).get();

  // [削除：１件]
  Future deleteEmployee(Employee employee) =>
      (delete(employees)..where((t) => t.id.equals(employee.id))).go();

  // [一括処理( 追加 )：１件追加 -> 全取得]
  Future<List<Employee>> addAndGetAllEmployees(Employee employee) {
    return transaction(() async {
      await addEmployee(employee);
      return await allEmployees;
    });
  }

  // [一括処理( 追加 )：複数追加 -> 全取得]
  Future<List<Employee>> addAllAndGetAllEmployees(
      List<Employee> employeesList) {
    return transaction(() async {
      await addAllEmployees(employeesList);
      return await allEmployees;
    });
  }

  // [一括処理( 削除 )：１件削除 -> 全取得]
  Future<List<Employee>> deleteAndGetAllEmployees(Employee employee) {
    return transaction(() async {
      await deleteEmployee(employee);
      return await allEmployees;
    });
  }

  //
  //
  // -- MenuCategories：メニューカテゴリ ------------------------------------------
  //
  //

  // [追加：１件]
  Future<int> addMenuCategory(MenuCategory menuCategory) =>
      into(menuCategories).insert(menuCategory, mode: InsertMode.replace);

  // [追加：複数]
  Future<void> addAllMenuCategories(
      List<MenuCategory> menuCategoriesList) async {
    await batch((batch) {
      batch.insertAll(menuCategories, menuCategoriesList);
    });
  }

  // [取得：すべて]
  Future<List<MenuCategory>> get allMenuCategories =>
      select(menuCategories).get();

  // [削除：１件]
  Future deleteMenuCategory(MenuCategory menuCategory) =>
      (delete(menuCategories)..where((t) => t.id.equals(menuCategory.id))).go();

  // 一括処理( 追加 )：１件追加 -> 全取得]
  Future<List<MenuCategory>> addAndGetAllMenuCategories(
      MenuCategory menuCategory) {
    return transaction(() async {
      await addMenuCategory(menuCategory);
      return await allMenuCategories;
    });
  }

  // 一括処理( 追加 )：複数追加 -> 全取得]
  Future<List<MenuCategory>> addAllAndGetAllMenuCategories(
      List<MenuCategory> menuCategoryList) {
    return transaction(() async {
      await addAllMenuCategories(menuCategoryList);
      return await allMenuCategories;
    });
  }

  // 一括処理( 削除 )：１件削除 -> 全取得]
  Future<List<MenuCategory>> deleteAndGetAllMenuCategories(
      MenuCategory menuCategory) {
    return transaction(() async {
      await deleteMenuCategory(menuCategory);
      return await allMenuCategories;
    });
  }

  //
  //
  // -- Menus：メニューデータ ------------------------------------------
  //
  //

  // [追加：１件分のメニューを追加]
  Future<int> addMenu(Menu menu) =>
      into(menus).insert(menu, mode: InsertMode.replace);

  // [追加：渡されたデータをすべて追加]
  Future<void> addAllMenus(List<Menu> menusList) async {
    await batch((batch) {
      batch.insertAll(menus, menusList);
    });
  }

  // [取得：すべてのメニューを取得]
  Future<List<Menu>> get allMenus => select(menus).get();

  // [更新：１件分のメニューを更新]
  Future updateMenu(Menu menu) => update(menus).replace(menu);

  // [削除：１件分のメニューを削除]
  Future deleteMenu(Menu menu) =>
      (delete(menus)..where((t) => t.id.equals(menu.id))).go();

  //
  //
  // -- VisitHistories：来店履歴１件毎のデータテーブル -----------------------------------
  //
  //

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
    return transaction(() async {
      final customers = await getCustomers();
      final visitHistories = await getVisitHistories();
      List<VisitHistoriesByCustomer> visitHistoriesByCustomers = List();

      customers.forEach((customer) {
        final historiesByCustomer = visitHistories.where((history) {
          final customerOfVisitHistory = history.customerJson.toCustomer();
          return customerOfVisitHistory.id == customer.id;
        }).toList();
        visitHistoriesByCustomers.add(VisitHistoriesByCustomer(
          customer: customer,
          histories: historiesByCustomer,
        ));
      });

      return Future.value(visitHistoriesByCustomers);
    });
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
