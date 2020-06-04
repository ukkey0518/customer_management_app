import 'package:customermanagementapp/data/data_classes/customer_list_preferences.dart';
import 'package:customermanagementapp/data/data_classes/customer_narrow_data.dart';
import 'package:customermanagementapp/data/data_classes/customer_sort_data.dart';
import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/data/enums/list_sort_order.dart';
import 'package:customermanagementapp/data/enums/screen_display_mode.dart';
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
  CustomerListPreferences _cPref = CustomerListPreferences(
    narrowData: CustomerNarrowData(),
    sortData: CustomerSortData(),
    searchWord: '',
  );

  CustomerListPreferences get cPref => _cPref;

  // [選択中の並べ替え表示]文字列
  String _selectedSortValue =
      customerSortStateMap[CustomerSortState.LAST_VISIT];

  String get selectedSortValue => _selectedSortValue;

  ListSortOrder _selectedOrder = ListSortOrder.ASCENDING_ORDER;

  ListSortOrder get selectedOrder => _selectedOrder;

  // [検索欄コントローラー]
  TextEditingController _searchNameController = TextEditingController();

  TextEditingController get searchNameController => _searchNameController;

  //
  // --- 処理 -------------------------------------------------------------------
  //

  // [取得：顧客データの取得]
  Future<void> getCustomersList({
    ScreenDisplayMode displayMode,
    CustomerNarrowData narrowData,
    CustomerSortData sortData,
    String searchWord,
  }) async {
    print('[VM: 顧客リスト画面] getCustomersList');

    _displayMode = displayMode ?? _displayMode;

    _cPref = CustomerListPreferences(
      narrowData: narrowData ?? _cPref.narrowData,
      sortData: sortData ?? _cPref.sortData,
      searchWord: searchWord ?? _cPref.searchWord,
    );

    _selectedSortValue = customerSortStateMap[_cPref.sortData.sortState];
    _selectedOrder = _cPref.sortData.order;

    await _gRep.getData(cPref: _cPref);
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

    await _gRep.deleteData(vhbc, pref: _cPref);
  }

  // [更新：CustomerRepositoryの変更があったときに呼ばれる]
  onRepositoryUpdated(GlobalRepository gRep) {
    print('  [VM: 顧客リスト画面] onRepositoryUpdated');

    _visitHistoriesByCustomers = gRep.visitHistoriesByCustomers;
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
