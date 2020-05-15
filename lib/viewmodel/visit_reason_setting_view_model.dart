import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/visit_reason_repository.dart';
import 'package:flutter/material.dart';

class VisitReasonSettingViewModel extends ChangeNotifier {
  VisitReasonSettingViewModel({vrRep}) : _vrRep = vrRep;

  final VisitReasonRepository _vrRep;

  List<VisitReason> _visitReasons;
  List<VisitReason> get visitReasons => _visitReasons;

  getVisitReasons() async {
    print('[ViewModel: VisitReason] getVisitReasons');
    _visitReasons = await _vrRep.getVisitReasons();
  }

  addVisitReason(VisitReason visitReason) async {
    print('[ViewModel: VisitReason] addVisitReason');
    _visitReasons = await _vrRep.addVisitReason(visitReason);
  }

  deleteVisitReasons(VisitReason visitReason) async {
    print('[ViewModel: VisitReason] deleteVisitReasons');
    _visitReasons = await _vrRep.deleteVisitReason(visitReason);
  }

  onRepositoryUpdated(VisitReasonRepository vrRep) {
    print('[ViewModel: VisitReason] onRepositoryUpdated');
    _visitReasons = vrRep.visitReasons;
    notifyListeners();
  }

  @override
  void dispose() {
    _vrRep.dispose();
    super.dispose();
  }
}
