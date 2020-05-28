import 'package:customermanagementapp/data/enums/periodMode.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/global_repository.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:flutter/material.dart';

class AnalysisViewModel extends ChangeNotifier {
  AnalysisViewModel({gRep}) : _gRep = gRep;

  final GlobalRepository _gRep;

  List<VisitHistory> _allVisitHistories = List();

  List<VisitHistory> get allVisitHistories => _allVisitHistories;

  List<VisitHistory> _vhList = List();

  List<VisitHistory> get vhList => _vhList;

  List<MenuCategory> _menuCategories = List();

  List<MenuCategory> get menuCategories => _menuCategories;

  PeriodMode _periodMode = PeriodMode.MONTH;

  PeriodMode get periodMode => _periodMode;

  DateTime _date = DateTime.now();

  DateTime get date => _date;

  DateTime _minDate;

  DateTime get minDate => _minDate;

  DateTime _maxDate;

  DateTime get maxDate => _maxDate;

  String _forwardText = '';

  String get forwardText => _forwardText;

  String _backText = '';

  String get backText => _backText;

  getVisitHistories() async {
    print('[VM: 分析画面] getVisitHistories');

    await _gRep.getData();

    _allVisitHistories = _gRep.visitHistories;
    _menuCategories = _gRep.menuCategories;

    _date = _allVisitHistories?.getLastVisitHistory()?.date;
    _minDate = _allVisitHistories?.getFirstVisitHistory()?.date;
    _maxDate = _allVisitHistories?.getLastVisitHistory()?.date;
  }

  setPeriodMode(PeriodMode mode) {
    print('[VM: 分析画面] setPeriodMode');

    _periodMode = mode;

    reloadList();
  }

  setDate(DateTime date) {
    print('[VM: 分析画面] setDate');

    _date = date;

    reloadList();
  }

  reloadList() {
    print('[VM: 分析画面] reloadList');

    _vhList = _allVisitHistories.getByPeriod(_date, _periodMode);

    switch (_periodMode) {
      case PeriodMode.YEAR:
        _backText = '前年';
        _forwardText = '翌年';
        break;
      case PeriodMode.MONTH:
        _backText = '前月';
        _forwardText = '翌月';
        break;
      case PeriodMode.DAY:
        _backText = '前日';
        _forwardText = '翌日';
        break;
    }

    notifyListeners();
  }

  onRepositoryUpdated(GlobalRepository gRep) {
    print('[VM: 分析画面] onRepositoryUpdated');

    _allVisitHistories = gRep.visitHistories;
    _menuCategories = gRep.menuCategories;

    _date = _allVisitHistories?.getLastVisitHistory()?.date;
    _minDate = _allVisitHistories?.getFirstVisitHistory()?.date;
    _maxDate = _allVisitHistories?.getLastVisitHistory()?.date;

    reloadList();

    notifyListeners();
  }

  @override
  void dispose() {
    _gRep.dispose();
    super.dispose();
  }
}
