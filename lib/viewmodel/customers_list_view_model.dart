import 'package:customermanagementapp/data/data_classes/customer_list_preferences.dart';
import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/data/enums/screen_display_mode.dart';
import 'package:customermanagementapp/data/list_search_state/customer_narrow_state.dart';
import 'package:customermanagementapp/data/list_search_state/customer_sort_state.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/global_repository.dart';
import 'package:flutter/cupertino.dart';

class CustomersListViewModel extends ChangeNotifier {
  CustomersListViewModel({gRep}) : _gRep = gRep;

  final GlobalRepository _gRep;

  //
  // --- フィールド --------------------------------------------------------------
  //

  ScreenDisplayMode _displayMode = ScreenDisplayMode.EDITABLE;

  ScreenDisplayMode get displayMode => _displayMode;

  // [顧客別来店履歴データリスト]
  List<VisitHistoriesByCustomer> _visitHistoriesByCustomers = List();

  List<VisitHistoriesByCustomer> get visitHistoriesByCustomers =>
      _visitHistoriesByCustomers;

  // [表示設定]
  CustomerListPreferences _pref = CustomerListPreferences(
    narrowState: CustomerNarrowState.ALL,
    sortState: CustomerSortState.REGISTER_OLD,
    searchWord: '',
  );

  CustomerListPreferences get pref => _pref;

  // [選択中の絞り込み表示文字列]
  String _narrowSelectedValue = customerNarrowStateMap[CustomerNarrowState.ALL];

  String get narrowSelectedValue => _narrowSelectedValue;

  // [選択中の並べ替え表示]文字列
  String _sortSelectedValue =
      customerSortStateMap[CustomerSortState.REGISTER_OLD];

  String get sortSelectedValue => _sortSelectedValue;

  // [検索欄コントローラー]
  TextEditingController _searchController = TextEditingController();

  TextEditingController get searchController => _searchController;

  //
  // --- 処理 -------------------------------------------------------------------
  //

  // [取得：顧客データの取得]
  Future<void> getCustomersList({
    ScreenDisplayMode displayMode,
    CustomerNarrowState narrowState,
    CustomerSortState sortState,
    String searchWord,
  }) async {
    print('[VM: 顧客リスト画面] getCustomersList');

    _displayMode = displayMode ?? _displayMode;

    _pref.narrowState = narrowState ?? _pref.narrowState;
    _pref.sortState = sortState ?? _pref.sortState;
    _pref.searchWord = searchWord ?? _pref.searchWord;

    _narrowSelectedValue = customerNarrowStateMap[_pref.narrowState];
    _sortSelectedValue = customerSortStateMap[_pref.sortState];

    await _gRep.getData(cPref: _pref);
    _visitHistoriesByCustomers = _gRep.visitHistoriesByCustomers;
  }

  // [追加；顧客データを追加]
  addCustomer(Customer customer) async {
    print('[VM: 顧客リスト画面] addCustomer');
    _visitHistoriesByCustomers = await _gRep.addSingleData(customer);
  }

  // [削除：１件の顧客データを削除]
  deleteVHBC(VisitHistoriesByCustomer vhbc) async {
    print('[VM: 顧客リスト画面] deleteVHBC');

    await _gRep.deleteData(vhbc, pref: _pref);
  }

  // [更新：CustomerRepositoryの変更があったときに呼ばれる]
  onRepositoryUpdated(GlobalRepository gRep) {
    print('  [VM: 顧客リスト画面] onRepositoryUpdated');

    _visitHistoriesByCustomers = gRep.visitHistoriesByCustomers;
    print(gRep.customers.length);
    notifyListeners();
  }

  setDisplayMode(ScreenDisplayMode displayMode) {
    print('[VM: 顧客リスト画面] setDisplayMode');
    _displayMode = displayMode;
    notifyListeners();
  }

  @override
  void dispose() {
    _gRep.dispose();
    super.dispose();
  }
}
