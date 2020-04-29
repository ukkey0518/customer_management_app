import 'package:moor/moor.dart';

import 'database.dart';
part 'dao.g.dart';

@UseDao(tables: [Customers])
class MyDao extends DatabaseAccessor<MyDatabase> with _$MyDaoMixin {
  MyDao(MyDatabase db) : super(db);

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
}
