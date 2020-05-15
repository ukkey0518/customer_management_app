import 'package:customermanagementapp/data/list_search_state/customer_narrow_state.dart';
import 'package:customermanagementapp/data/data_classes/customer_list_screen_preferences.dart';
import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/data/list_search_state/customer_sort_state.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/customer_repository.dart';
import 'package:customermanagementapp/repositories/visit_history_repository.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:flutter/material.dart';

class VisitHistoriesByCustomerRepository extends ChangeNotifier {
  VisitHistoriesByCustomerRepository({cRep, vhRep})
      : _cRep = cRep,
        _vhRep = vhRep;

  final CustomerRepository _cRep;
  final VisitHistoryRepository _vhRep;

  List<Customer> _customers = List();
  List<VisitHistory> _visitHistories = List();

  List<VisitHistoriesByCustomer> _visitHistoriesByCustomers = List();

  List<VisitHistoriesByCustomer> get visitHistoriesByCustomers =>
      _visitHistoriesByCustomers;

  CustomerListScreenPreferences _cPref = CustomerListScreenPreferences(
    narrowState: CustomerNarrowState.ALL,
    sortState: CustomerSortState.REGISTER_OLD,
    searchWord: '',
  );

  CustomerListScreenPreferences get cPref => _cPref;

  // [取得：すべてのVHBC]
  getVisitHistoriesByCustomers({
    CustomerListScreenPreferences cPref,
  }) async {
    print('[Rep: VisitHistoriesByCustomer] getVisitHistoriesByCustomers');

    _cPref = cPref;

    _customers = await _cRep.getCustomers(preferences: _cPref) ?? List();
    _visitHistories = await _vhRep.getVisitHistories() ?? List();

    _visitHistoriesByCustomers =
        ConvertFromVHBCList.vhbcListFrom(_customers, _visitHistories);
  }

  // [追加：１件の顧客データ]
  addCustomer(
    Customer customer,
  ) async {
    print('[Rep: VisitHistoriesByCustomer] addCustomer');

    _customers = await _cRep.addCustomer(customer, preferences: _cPref);

    _visitHistoriesByCustomers =
        ConvertFromVHBCList.vhbcListFrom(_customers, _visitHistories);
  }

  // [削除：１件のVHBC]
  deleteVisitHistoriesByCustomers(
    VisitHistoriesByCustomer vhbc,
    CustomerListScreenPreferences cPref,
  ) async {
    print('[Rep: VisitHistoriesByCustomer] deleteVisitHistoriesByCustomers');

    final customer = vhbc.customer;
    final visitHistories = vhbc.histories;

    _customers = await _cRep.deleteCustomer(customer, preferences: cPref);
    _visitHistories = await _vhRep.deleteMultipleVisitHistories(visitHistories);
  }

  // [Repository更新]
  onRepositoriesUpdated(
    CustomerRepository cRep,
    VisitHistoryRepository vhRep,
  ) {
    print('  [Rep: VisitHistoriesByCustomer] onRepositoriesUpdated');

    _customers = cRep.customers;
    _visitHistories = vhRep.visitHistories;

    _visitHistoriesByCustomers =
        ConvertFromVHBCList.vhbcListFrom(_customers, _visitHistories);

    notifyListeners();
  }

  @override
  void dispose() {
    _cRep.dispose();
    _vhRep.dispose();
    super.dispose();
  }
}
