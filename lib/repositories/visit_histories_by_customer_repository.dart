import 'package:customermanagementapp/data/data_classes/screen_preferences.dart';
import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/data/list_status.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/customer_repository.dart';
import 'package:customermanagementapp/repositories/visit_history_repository.dart';
import 'package:customermanagementapp/util/extensions.dart';
import 'package:flutter/material.dart';

class VisitHistoriesByCustomerRepository extends ChangeNotifier {
  VisitHistoriesByCustomerRepository({cRep, vhRep})
      : _cRep = cRep,
        _vhRep = vhRep;

  final CustomerRepository _cRep;
  final VisitHistoryRepository _vhRep;

  //
  // --- Privateフィールド ------------------------------------------------------
  //

  // [顧客リスト]
  List<Customer> _customers = List();

  // [来店履歴リスト]
  List<VisitHistory> _visitHistories = List();

  //
  // --- フィールド --------------------------------------------------------------
  //

  // [読み込みステータス]
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // [メニューカテゴリリスト]
  List<VisitHistoriesByCustomer> _visitHistoriesByCustomers = List();
  List<VisitHistoriesByCustomer> get visitHistoriesByCustomers =>
      _visitHistoriesByCustomers;

  // [表示状態]
  CustomerListScreenPreferences _cPref = CustomerListScreenPreferences(
    narrowState: CustomerNarrowState.ALL,
    sortState: CustomerSortState.REGISTER_OLD,
    searchWord: '',
  );
  CustomerListScreenPreferences get cPref => _cPref;

  //
  // --- 処理 -------------------------------------------------------------------
  //

  // [取得：顧客別の来店履歴をすべて取得]
  getVisitHistoriesByCustomers({CustomerListScreenPreferences cPref}) async {
    print(
        'VisitHistoriesByCustomerRepository.getAllVisitHistoriesByCustomers :');

    _cPref = cPref;

    _customers = await _cRep.getCustomers(preferences: _cPref) ?? List();

    _visitHistories = await _vhRep.getVisitHistories() ?? List();

    _visitHistoriesByCustomers =
        ConvertFromVHBCList.vhbcListFrom(_customers, _visitHistories);
  }

  // [削除：顧客別来店履歴を削除]
  deleteVisitHistoriesByCustomers(VisitHistoriesByCustomer vhbc,
      CustomerListScreenPreferences cPref) async {
    print(
        'VisitHistoriesByCustomerRepository.deleteVisitHistoriesByCustomers :');
    final customer = vhbc.customer;
    final visitHistories = vhbc.histories;

    _customers = await _cRep.deleteCustomer(customer, preferences: cPref);
    _visitHistories = await _vhRep.deleteMultipleVisitHistories(visitHistories);
  }

  // [更新：どちらかのRepositoryが更新された時]
  onRepositoryUpdated(CustomerRepository cRep, VisitHistoryRepository vhRep) {
    print('VisitHistoriesByCustomerRepository.onRepositoryUpdated :');
    _customers = cRep.customers;
    _visitHistories = vhRep.visitHistories;
    _isLoading = cRep.isLoading && vhRep.isLoading;

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
