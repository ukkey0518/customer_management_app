import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/global_repository.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';

class VisitHistoryEditViewModel extends ChangeNotifier {
  VisitHistoryEditViewModel({gRep}) : _gRep = gRep;

  final GlobalRepository _gRep;

  List<Employee> _employeeList = List();

  List<Employee> get employeeList => _employeeList;

  int _id;

  Customer _customer;

  Customer get customer => _customer;

  DateTime _date = DateTime.now();

  DateTime get date => _date;

  Employee _employee;

  Employee get employee => _employee;

  List<Menu> _menus = List();

  List<Menu> get menus => _menus;

  bool _isSaved = false;

  bool get isSaved => _isSaved;

  bool _isReadingMode = false;

  bool get isReadingMode => _isReadingMode;

  String _customerErrorText;

  String get customerErrorText => _customerErrorText;

  String _employeeErrorText;

  String get employeeErrorText => _employeeErrorText;

  String _menusErrorText;

  String get menusErrorText => _menusErrorText;

  reflectVisitHistoryData({VisitHistory visitHistory}) async {
    print('[VM: 来店履歴編集画面] reflectVisitHistoryData');
    await _gRep.getData();
    _employeeList = _gRep.employees;

    if (visitHistory == null) {
      _id = null;
      _date = DateTime.now();
      _customer = null;
      _employee = null;
      _menus = List();
      _isReadingMode = false;
      _isSaved = false;
    } else {
      _id = visitHistory.id;
      _date = visitHistory.date;
      _customer = visitHistory.customerJson.toCustomer();
      _employee = visitHistory.employeeJson.toEmployee();
      _menus = visitHistory.menuListJson.toMenuList();
      _isReadingMode = true;
      _isSaved = true;
    }
  }

  saveVisitHistory() async {
    print('[VM: 来店履歴編集画面] saveVisitHistory');
    _customerErrorText = _customer == null ? '顧客データが選択されていません。' : null;
    _employeeErrorText = _employee == null ? '担当スタッフが選択されていません。' : null;
    _menusErrorText =
        _menus == null || _menus.isEmpty ? 'メニューが選択されていません。' : null;

    if (_customerErrorText != null ||
        _employeeErrorText != null ||
        _menusErrorText != null) {
      notifyListeners();
      return;
    }

    final visitHistory = VisitHistory(
      id: _id,
      date: _date,
      customerJson: _customer.toJsonString(),
      employeeJson: _employee.toJsonString(),
      menuListJson: _menus.toJsonString(),
    );

    await _gRep.addSingleData(visitHistory);

    _isSaved = true;
    _isReadingMode = true;
    notifyListeners();
  }

  onRepositoriesUpdated(GlobalRepository gRep) {
    print('  [VM: 来店履歴編集画面] onRepositoriesUpdated');
    _employeeList = gRep.employees;
    notifyListeners();
  }

  setStatus({
    Customer customer,
    DateTime date,
    Employee employee,
    List<Menu> menus,
    bool isReadingMode,
  }) {
    print('[VM: 来店履歴編集画面] setStatus');
    _customer = customer ?? _customer;
    _date = date ?? _date;
    _employee = employee ?? _employee;
    _menus = menus ?? _menus;
    _isReadingMode = isReadingMode ?? _isReadingMode;

    _isSaved = false;

    notifyListeners();
  }

  @override
  void dispose() {
    _gRep.dispose();
    super.dispose();
  }
}
