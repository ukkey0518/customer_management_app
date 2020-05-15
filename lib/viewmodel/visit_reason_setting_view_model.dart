import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/visit_reason_repository.dart';
import 'package:flutter/material.dart';

class VisitReasonSettingViewModel extends ChangeNotifier {
  VisitReasonSettingViewModel({vrRep}) : _vrRep = vrRep;

  final VisitReasonRepository _vrRep;

  List<VisitReason> _visitReasons = List();

  List<VisitReason> get visitReasons => _visitReasons;

  getVisitReasons() async {
    print('[VM: 来店動機設定画面] getVisitReasons');
    _visitReasons = await _vrRep.getVisitReasons();
  }

  addVisitReason(VisitReason visitReason) async {
    print('[VM: 来店動機設定画面] addVisitReason');
    _visitReasons = await _vrRep.addVisitReason(visitReason);
  }

  deleteVisitReasons(VisitReason visitReason) async {
    print('[VM: 来店動機設定画面] deleteVisitReasons');
    _visitReasons = await _vrRep.deleteVisitReason(visitReason);
  }

  onRepositoryUpdated(VisitReasonRepository vrRep) {
    print('  [VM: 来店動機設定画面] onRepositoryUpdated');
    _visitReasons = vrRep.visitReasons;
    notifyListeners();
  }

  @override
  void dispose() {
    _vrRep.dispose();
    super.dispose();
  }
}
