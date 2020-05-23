import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/global_repository.dart';
import 'package:flutter/material.dart';

class AnalysisViewModel extends ChangeNotifier {
  AnalysisViewModel({gRep}) : _gRep = gRep;

  final GlobalRepository _gRep;

  List<VisitHistory> _visitHistories = List();

  List<VisitHistory> get visitHistories => _visitHistories;

  List<MenuCategory> _menuCategories = List();
  List<MenuCategory> get menuCategories => _menuCategories;

  getVisitHistories() async {
    print('[VM: 分析画面] getVisitHistories');

    await _gRep.getData();

    _visitHistories = _gRep.visitHistories;
    _menuCategories = _gRep.menuCategories;
  }

  onRepositoryUpdated(GlobalRepository gRep) {
    print('[VM: 分析画面] onRepositoryUpdated');

    _visitHistories = gRep.visitHistories;
    _menuCategories = gRep.menuCategories;
    notifyListeners();
  }

  @override
  void dispose() {
    _gRep.dispose();
    super.dispose();
  }
}
