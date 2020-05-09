import 'package:customermanagementapp/data/data_classes/screen_preferences.dart';
import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/data/drop_down_menu_items.dart';
import 'package:customermanagementapp/data/list_status.dart';
import 'package:customermanagementapp/util/extensions.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/customer_repository.dart';
import 'package:customermanagementapp/repositories/visit_history_repository.dart';
import 'package:flutter/cupertino.dart';

class CustomersListViewModel extends ChangeNotifier {
  // [コンストラクタ：CustomerRepositoryを受け取る]
  CustomersListViewModel({cRep, vhRep})
      : _cRep = cRep,
        _vhRep = vhRep;

  // [定数フィールド：Repository]
  final CustomerRepository _cRep;
  final VisitHistoryRepository _vhRep;

  // [priフィールド：来店履歴リスト]
  List<VisitHistory> _visitHistories = List();

  // [フィールド：読み込み状態]
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // [フィールド：顧客データリスト]
  List<Customer> _customers = List();
  List<Customer> get customers => _customers;

  // [フィールド：顧客別来店履歴データリスト]
  List<VisitHistoriesByCustomer> _visitHistoriesByCustomers = List();
  List<VisitHistoriesByCustomer> get visitHistoriesByCustomers =>
      _visitHistoriesByCustomers;

  // [フィールド：表示状態]
  CustomerListScreenPreferences _pref = CustomerListScreenPreferences(
    narrowState: CustomerNarrowState.ALL,
    sortState: CustomerSortState.REGISTER_OLD,
    searchWord: '',
  );
  CustomerListScreenPreferences get pref => _pref;

  // [フィールド：選択中の絞り込み表示]
  String _narrowSelectedValue = customerNarrowStateMap[CustomerNarrowState.ALL];
  String get narrowSelectedValue => _narrowSelectedValue;

  // [フィールド：選択中の並べ替え表示]
  String _sortSelectedValue =
      customerSortStateMap[CustomerSortState.REGISTER_OLD];
  String get sortSelectedValue => _sortSelectedValue;

  // [フィールド：検索欄コントローラー]
  TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  // [取得：顧客データの取得]
  Future<void> getCustomersList({
    CustomerNarrowState narrowState,
    CustomerSortState sortState,
    String searchWord,
  }) async {
    print('CustomersListViewModel.getCustomers :');

    _pref.narrowState = narrowState ?? _pref.narrowState;
    _pref.sortState = sortState ?? _pref.sortState;
    _pref.searchWord = searchWord ?? _pref.searchWord;

    _narrowSelectedValue = customerNarrowStateMap[_pref.narrowState];
    _sortSelectedValue = customerSortStateMap[_pref.sortState];

    _customers = await _cRep.getCustomers(preferences: _pref) ?? List();

    _visitHistories = await _vhRep.getVisitHistories() ?? List();

    _visitHistoriesByCustomers =
        ConvertFromVHBCList.vhbcListFrom(_customers, _visitHistories);

    print('  customer : ${_customers?.length}');
    print('  visithistories : ${_visitHistories?.length}');
    print('  vhbc : ${visitHistoriesByCustomers.length}');
  }

  // [削除：１件の顧客データを削除]
  deleteCustomer(Customer customer) async {
    print('CustomersListViewModel.deleteEmployee :');
    print('  customer : [${customer.id}] ${customer.name}');

    //TODO 確認ダイアログ

    _customers = await _cRep.deleteCustomer(customer, preferences: _pref);

    //TODO 削除した顧客の来店履歴をすべて削除する処理
  }

  // [更新：CustomerRepositoryの変更があったときに呼ばれる]
  onRepositoryUpdated(CustomerRepository cRep, VisitHistoryRepository vhRep) {
    print('CustomersListViewModel.onRepositoryUpdated :');
    _customers = cRep.customers;
    _visitHistories = vhRep.visitHistories;
    _visitHistoriesByCustomers =
        ConvertFromVHBCList.vhbcListFrom(_customers, _visitHistories);
    _isLoading = cRep.isLoading && vhRep.isLoading;

    notifyListeners();
  }

  @override
  void dispose() {
    _cRep.dispose();
    _vhRep.dispose();
    super.dispose();
  }
}
