import 'package:customermanagementapp/data/data_classes/customer_list_screen_preferences.dart';
import 'package:customermanagementapp/db/dao/customer_dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/visit_reason_repository.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:flutter/material.dart';

class CustomerRepository extends ChangeNotifier {
  CustomerRepository({dao, vrRep})
      : _dao = dao,
        _vrRep = vrRep;

  final CustomerDao _dao;
  final VisitReasonRepository _vrRep;

  List<VisitReason> _visitReasons = List();

  List<Customer> _customers = List();

  List<Customer> get customers => _customers;

  // [取得：条件一致データ]
  getCustomers({
    CustomerListScreenPreferences preferences,
  }) async {
    print('[Rep: Customer] getCustomers');

    _visitReasons = await _vrRep.getVisitReasons();

    _customers = await _dao.getCustomers(preferences: preferences);
    notifyListeners();
  }

  // [追加：１件]
  addCustomer(
    Customer customer, {
    CustomerListScreenPreferences preferences,
  }) async {
    print('[Rep: Customer] addCustomer');

    _customers =
        await _dao.addAndGetAllCustomers(customer, preferences: preferences);
    notifyListeners();
  }

  // [追加：複数]
  addAllCustomers(
    List<Customer> customerList, {
    CustomerListScreenPreferences preferences,
  }) async {
    print('[Rep: Customer] addAllCustomers');

    _customers = await _dao.addAllAndGetAllCustomers(customerList,
        preferences: preferences);
    notifyListeners();
  }

  // [削除：１件]
  deleteCustomer(
    Customer customer, {
    CustomerListScreenPreferences preferences,
  }) async {
    print('[Rep: Customer] deleteCustomer');

    _customers =
        await _dao.deleteAndGetAllCustomers(customer, preferences: preferences);
    notifyListeners();
  }

  // [Repositoryの更新]
  onRepositoryUpdated(VisitReasonRepository vrRep) {
    print('[Rep: Customer] onRepositoryUpdated');

    _visitReasons = vrRep.visitReasons;
    _customers = _customers.getUpdate(_visitReasons);

    notifyListeners();
  }
}
