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
      print('  [DAO] Customer saved: ${customersList.length}');
    });
  }

  // [取得：条件付き]
  Future<List<Customer>> getCustomers() => select(customers).get();

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
  Future<List<Customer>> addAndGetAllCustomers(Customer customer) {
    return transaction(() async {
      await addCustomer(customer);
      return await getCustomers();
    });
  }

  // [一括処理( 追加 ) : 複数追加 -> 全取得]
  Future<List<Customer>> addAllAndGetAllCustomers(
      List<Customer> customersList) {
    return transaction(() async {
      await addAllCustomers(customersList);
      return await getCustomers();
    });
  }

  // [一括処理( 削除 )：１件削除 -> 全取得]
  Future<List<Customer>> deleteAndGetAllCustomers(Customer customer) {
    return transaction(() async {
      await deleteCustomer(customer);
      return await getCustomers();
    });
  }
}
