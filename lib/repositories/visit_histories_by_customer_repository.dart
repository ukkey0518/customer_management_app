import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/db/dao/customer_dao.dart';
import 'package:customermanagementapp/db/dao/visit_history_dao.dart';
import 'package:customermanagementapp/repositories/customer_repository.dart';
import 'package:customermanagementapp/repositories/visit_history_repository.dart';
import 'package:customermanagementapp/util/extensions.dart';
import 'package:flutter/material.dart';

class VisitHistoriesByCustomerRepository extends ChangeNotifier {
  VisitHistoriesByCustomerRepository({cRep, vhRep})
      : _customerRepository = cRep,
        _visitHistoryRepository = vhRep;

  final CustomerRepository _customerRepository;
  final VisitHistoryRepository _visitHistoryRepository;

  // [フィールド：読み込みステータス]
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // [フィールド：メニューカテゴリリスト]
  List<VisitHistoriesByCustomer> _visitHistoriesByCustomers = List();
  List<VisitHistoriesByCustomer> get visitHistoriesByCustomers =>
      _visitHistoriesByCustomers;

  // [取得：顧客別の来店履歴をすべて取得]
  getAllVisitHistoriesByCustomers() async {
    print(
        'VisitHistoriesByCustomerRepository.getAllVisitHistoriesByCustomers :');

    final customers = await _customerRepository.getCustomers();
    final visitHistories = await _visitHistoryRepository.getVisitHistories();
    final visitHistoriesByCustomers = List<VisitHistoriesByCustomer>();

    customers.forEach((customer) {
      final historiesByCustomer = visitHistories.where((history) {
        final customerOfVisitHistory = history.customerJson.toCustomer();
        return customerOfVisitHistory.id == customer.id;
      }).toList();
      visitHistoriesByCustomers.add(
        VisitHistoriesByCustomer(
          customer: customer,
          histories: historiesByCustomer,
        ),
      );
    });

    _visitHistoriesByCustomers = visitHistoriesByCustomers;
  }

  // [更新：どちらかのRepositoryが更新された時]
  onRepositoryUpdated(
      CustomerRepository cRep, VisitHistoryRepository vhRep) async {
    print('VisitHistoriesByCustomerRepository.onRepositoryUpdated :');
    final customers = await _customerRepository.getCustomers();
    final visitHistories = await _visitHistoryRepository.getVisitHistories();
    final visitHistoriesByCustomers = List<VisitHistoriesByCustomer>();

    customers.forEach((customer) {
      final historiesByCustomer = visitHistories.where((history) {
        final customerOfVisitHistory = history.customerJson.toCustomer();
        return customerOfVisitHistory.id == customer.id;
      }).toList();
      visitHistoriesByCustomers.add(
        VisitHistoriesByCustomer(
          customer: customer,
          histories: historiesByCustomer,
        ),
      );
    });

    _visitHistoriesByCustomers = visitHistoriesByCustomers;
    notifyListeners();
  }
}
