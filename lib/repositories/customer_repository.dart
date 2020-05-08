import 'package:customermanagementapp/data/data_classes/screen_preferences.dart';
import 'package:customermanagementapp/db/dao/customer_dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';

class CustomerRepository extends ChangeNotifier {
  CustomerRepository({dao}) : _dao = dao;

  final CustomerDao _dao;

  // [フィールド：読み込みステータス]
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // [フィールド：顧客リスト]
  List<Customer> _customers = List();
  List<Customer> get customers => _customers;

  // [取得：条件付きで顧客データを取得]
  getCustomers({CustomerListScreenPreferences preferences}) async {
    print('CustomerRepository.getCustomers :');
    _isLoading = true;
    notifyListeners();

    _customers = await _dao.getCustomers(preferences: preferences);

    _isLoading = false;
    notifyListeners();
  }

  // [追加：１つの顧客データを追加]
  addCustomer(Customer customer,
      {CustomerListScreenPreferences preferences}) async {
    print('CustomerRepository.addCustomer :');
    _isLoading = true;
    notifyListeners();

    _customers =
        await _dao.addAndGetAllCustomers(customer, preferences: preferences);

    _isLoading = false;
    notifyListeners();
  }

  // [追加：複数の顧客データを追加]
  addAllCustomers(List<Customer> customerList,
      {CustomerListScreenPreferences preferences}) async {
    print('CustomerRepository.addAllCustomer :');
    _isLoading = true;
    notifyListeners();

    _customers = await _dao.addAllAndGetAllCustomers(customerList,
        preferences: preferences);

    _isLoading = false;
    notifyListeners();
  }

  // [削除：１つの顧客データを削除]
  deleteCustomer(Customer customer,
      {CustomerListScreenPreferences preferences}) async {
    print('CustomerRepository.deleteCustomer :');
    _isLoading = true;
    notifyListeners();

    _customers =
        await _dao.deleteAndGetAllCustomers(customer, preferences: preferences);

    _isLoading = false;
    notifyListeners();
  }
}
