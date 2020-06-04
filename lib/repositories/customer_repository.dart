import 'package:customermanagementapp/data/data_classes/customer_list_preferences.dart';
import 'package:customermanagementapp/db/dao/customer_dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';

class CustomerRepository extends ChangeNotifier {
  CustomerRepository({dao, vrRep}) : _dao = dao;

  final CustomerDao _dao;

  List<Customer> _customers = List();

  List<Customer> get customers => _customers;

  // [取得：条件一致データ]
  getCustomers() async {
    print('[Rep: Customer] getCustomers');

    _customers = await _dao.getCustomers();
    notifyListeners();
  }

  // [追加：１件]
  addCustomer(Customer customer) async {
    print('[Rep: Customer] addCustomer');

    _customers = await _dao.addAndGetAllCustomers(customer);
    notifyListeners();
  }

  // [追加：複数]
  addAllCustomers(List<Customer> customerList) async {
    print('[Rep: Customer] addAllCustomers');

    _customers = await _dao.addAllAndGetAllCustomers(customerList);
    notifyListeners();
  }

  // [削除：１件]
  deleteCustomer(Customer customer) async {
    print('[Rep: Customer] deleteCustomer');

    _customers = await _dao.deleteAndGetAllCustomers(customer);
    notifyListeners();
  }
}
