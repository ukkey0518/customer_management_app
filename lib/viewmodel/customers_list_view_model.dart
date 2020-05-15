import 'package:customermanagementapp/data/data_classes/customer_list_screen_preferences.dart';
import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/data/drop_down_menu_items.dart';
import 'package:customermanagementapp/data/list_status.dart';
import 'package:customermanagementapp/data/screen_display_mode.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/visit_histories_by_customer_repository.dart';
import 'package:flutter/cupertino.dart';

class CustomersListViewModel extends ChangeNotifier {
  CustomersListViewModel({vhbcRep}) : _vhbcRep = vhbcRep;

  final VisitHistoriesByCustomerRepository _vhbcRep;

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
  CustomerListScreenPreferences _pref = CustomerListScreenPreferences(
    narrowState: CustomerNarrowState.ALL,
    sortState: CustomerSortState.REGISTER_OLD,
    searchWord: '',
  );

  CustomerListScreenPreferences get pref => _pref;

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

    _visitHistoriesByCustomers =
        await _vhbcRep.getVisitHistoriesByCustomers(cPref: _pref);
  }

  // [追加；顧客データを追加]
  addCustomer(Customer customer) async {
    print('[VM: 顧客リスト画面] addCustomer');
    _visitHistoriesByCustomers = await _vhbcRep.addCustomer(customer);
  }

  // [削除：１件の顧客データを削除]
  deleteVHBC(VisitHistoriesByCustomer vhbc) async {
    print('[VM: 顧客リスト画面] deleteVHBC');

    await _vhbcRep.deleteVisitHistoriesByCustomers(vhbc, _pref);
  }

  // [更新：CustomerRepositoryの変更があったときに呼ばれる]
  onRepositoryUpdated(VisitHistoriesByCustomerRepository vhbcRep) {
    print('  [VM: 顧客リスト画面] onRepositoryUpdated');

    _visitHistoriesByCustomers = vhbcRep.visitHistoriesByCustomers;

    notifyListeners();
  }

  setDisplayMode(ScreenDisplayMode displayMode) {
    print('[VM: 顧客リスト画面] setDisplayMode');
    _displayMode = displayMode;
    notifyListeners();
  }

  @override
  void dispose() {
    _vhbcRep.dispose();
    super.dispose();
  }
}
