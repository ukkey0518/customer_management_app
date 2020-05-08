import 'package:customermanagementapp/data/list_status.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repository/my_repository.dart';
import 'package:flutter/material.dart';

class CustomerViewModel extends ChangeNotifier {
  CustomerViewModel({repository}) : _repository = repository;

  final MyRepository _repository;

  List<Customer> _customers = List();
  List<Customer> get customer => _customers;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // [取得：すべて取得]
  getCustomers({
    CustomerNarrowState narrowState,
    CustomerSortState sortState,
  }) async {
    print('CustomerViewModel.getCustomers :');
    print('  narrowState -> $narrowState');
    print('  sortState -> $sortState');

    _customers = await _repository.getCustomers(
        narrowState: narrowState, sortState: sortState);
  }

  // [追加：１件追加]
  addCustomer(
    Customer customer, {
    CustomerNarrowState narrowState,
    CustomerSortState sortState,
  }) async {
    print('CustomerViewModel.addCustomers :');
    print('  customer -> [${customer.id}]${customer.name}');
    print('  narrowState -> $narrowState');
    print('  sortState -> $sortState');

    _customers = await _repository.addCustomer(customer,
        narrowState: narrowState, sortState: sortState);
  }

  // [追加：１件追加]
  addAllCustomers(
    List<Customer> customers, {
    CustomerNarrowState narrowState,
    CustomerSortState sortState,
  }) async {
    print('CustomerViewModel.addAllCustomers :');
    print('  customers -> ${customers.length} data');
    print('  narrowState -> $narrowState');
    print('  sortState -> $sortState');

    _customers = await _repository.addAllCustomer(customers,
        narrowState: narrowState, sortState: sortState);
  }

  // [削除：１件削除]
  deleteCustomers(
    Customer customer, {
    CustomerNarrowState narrowState,
    CustomerSortState sortState,
  }) async {
    print('CustomerViewModel.deleteCustomers :');
    print('  customer -> [${customer.id}]${customer.name}');
    print('  narrowState -> $narrowState');
    print('  sortState -> $sortState');

    _customers = await _repository.deleteCustomer(customer,
        narrowState: narrowState, sortState: sortState);
  }

  // [更新：MyRepository更新時]
  onRepositoryUpdated(MyRepository repository) {
    print('CustomerViewModel.onRepositoryUpdated :');
    _customers = repository.customers;
    _isLoading = repository.isLoading;

    notifyListeners();
  }
}
