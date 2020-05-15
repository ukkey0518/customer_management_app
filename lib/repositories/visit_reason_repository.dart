import 'package:customermanagementapp/db/dao/visit_reason_dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';

class VisitReasonRepository extends ChangeNotifier {
  VisitReasonRepository({dao}) : _dao = dao;

  final VisitReasonDao _dao;

  List<VisitReason> _visitReasons;

  List<VisitReason> get visitReasons => _visitReasons;

  // [取得：すべて]
  getVisitReasons() async {
    print('[Rep: VisitReason] getVisitReasons');
    _visitReasons = await _dao.allVisitReasons;
    notifyListeners();
  }

  // [追加：１件]
  addVisitReason(VisitReason visitReason) async {
    print('[Rep: VisitReason] addVisitReason');
    _visitReasons = await _dao.addAndGetAllVisitReasons(visitReason);
    notifyListeners();
  }

  // [追加：複数]
  addAllVisitReasons(List<VisitReason> visitReasonList) async {
    print('[Rep: VisitReason] addAllVisitReasons');
    _visitReasons = await _dao.addAllAndGetAllVisitReasons(visitReasonList);
    notifyListeners();
  }

  // [削除：１件]
  deleteVisitReason(VisitReason visitReason) async {
    print('[Rep: VisitReason] deleteVisitReason');
    _visitReasons = await _dao.deleteAndGetAllVisitReasons(visitReason);
    notifyListeners();
  }
}
