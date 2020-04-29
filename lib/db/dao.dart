import 'package:moor/moor.dart';

import 'database.dart';
part 'dao.g.dart';

@UseDao(tables: [
  Customers,
  Employees,
  MenuCategories,
])
class MyDao extends DatabaseAccessor<MyDatabase> with _$MyDaoMixin {
  MyDao(MyDatabase db) : super(db);

  //
  //
  // -- Customer：顧客データテーブル -----------------------------------------------------
  //
  //

  // [追加：１件追加]
  Future<int> addCustomer(Customer customer) =>
      into(customers).insert(customer, orReplace: true);

  // [追加：渡されたデータをすべて追加]
  Future<void> addAllCustomers(List<Customer> customersList) async {
    await batch((batch) {
      batch.insertAll(customers, customersList);
    });
  }

  // [取得：すべての顧客情報を取得]
  Future<List<Customer>> get allCustomers => select(customers).get();

  // [取得：女性顧客データを取得]
  Future<List<Customer>> get femaleCustomers =>
      (select(customers)..where((t) => t.isGenderFemale)).get();

  // [取得：男性顧客データを取得]
  Future<List<Customer>> get maleCustomers =>
      (select(customers)..where((t) => t.isGenderFemale.not())).get();

  // [取得：指定した顧客IDに一致する顧客データを取得]
  Future<Customer> getCustomersById(int id) =>
      (select(customers)..where((t) => t.id.equals(id))).getSingle();

  // [取得：指定した名前に一致する顧客データを取得]
  Future<Customer> getCustomersByName(String name) =>
      (select(customers)..where((t) => t.name.equals(name))).getSingle();

  // [更新：１件分の顧客データを更新]
  Future updateCustomer(Customer customer) =>
      update(customers).replace(customer);

  // [削除：１件分の顧客データを削除]
  Future deleteCustomer(Customer customer) =>
      (delete(customers)..where((t) => t.id.equals(customer.id))).go();

  //
  //
  // -- Employees：スタッフデータ ------------------------------------------
  //
  //

  // [追加：１件分のスタッフデータを追加]
  Future<int> addEmployee(Employee employee) =>
      into(employees).insert(employee);

  // [追加：渡されたデータをすべて追加]
  Future<void> addAllEmployees(List<Employee> employeesList) async {
    await batch((batch) {
      batch.insertAll(employees, employeesList);
    });
  }

  // [取得：すべてのスタッフデータを取得]
  Future<List<Employee>> get allEmployees => select(employees).get();

  // [取得：IDからスタッフデータを取得]
  Future<Employee> getEmployeeById(int employeeId) {
    return (select(employees)..where((t) => t.id.equals(employeeId)))
        .getSingle();
  }

  // [更新：１件分のスタッフデータを更新]
  Future updateEmployee(Employee employee) =>
      update(employees).replace(employee);

  // [削除：１件分のスタッフデータを削除]
  Future deleteEmployee(Employee employee) =>
      (delete(employees)..where((t) => t.id.equals(employee.id))).go();

  //
  //
  // -- MenuCategories：メニューカテゴリ ------------------------------------------
  //
  //

  // [追加：１件分のメニューカテゴリを追加]
  Future<int> addMenuCategory(MenuCategory menuCategory) =>
      into(menuCategories).insert(menuCategory);

  // [追加：渡されたデータをすべて追加]
  Future<void> addAllMenuCategories(
      List<MenuCategory> menuCategoriesList) async {
    await batch((batch) {
      batch.insertAll(menuCategories, menuCategoriesList);
    });
  }

  // [取得：すべてのメニューカテゴリを取得]
  Future<List<MenuCategory>> get allMenuCategories =>
      select(menuCategories).get();

  // [更新：１件分のメニューカテゴリを更新]
  Future updateMenuCategory(MenuCategory menuCategory) =>
      update(menuCategories).replace(menuCategory);

  // [削除：１件分のメニューカテゴリを削除]
  Future deleteMenuCategory(MenuCategory menuCategory) =>
      (delete(menuCategories)..where((t) => t.name.equals(menuCategory.name)))
          .go();
}
