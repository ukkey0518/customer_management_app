import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/global_repository.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';

class CustomerInformationViewModel extends ChangeNotifier {
  CustomerInformationViewModel({gRep}) : _gRep = gRep;

  final GlobalRepository _gRep;

  List<VisitHistoriesByCustomer> _allVHBC = List();

  int _customerId;

  List<Customer> _customers = List();

  List<Customer> get customers => _customers;

  VisitHistoriesByCustomer _vhbc;

  VisitHistoriesByCustomer get vhbc => _vhbc;

  getVHBC({int id}) async {
    print('[VM: 顧客情報画面] getVHBC');

    _customerId = id;

    await _gRep.getData();
    _allVHBC = _gRep.visitHistoriesByCustomers;

    _customers = _allVHBC.toCustomers();
    _vhbc = _allVHBC.getVHBC(_customers.getCustomer(_customerId));
  }

  addCustomer(Customer customer) async {
    print('[VM: 顧客情報画面] addCustomer');

    _allVHBC = await _gRep.addSingleData(customer);
    _customers = _allVHBC.toCustomers();

    _vhbc = _allVHBC.getVHBC(_customers.getCustomer(_customerId));
  }

  onRepositoryUpdated(GlobalRepository gRep) {
    print('  [VM: 顧客情報画面] onRepositoryUpdated');

    _allVHBC = gRep.visitHistoriesByCustomers;
    _customers = _allVHBC.toCustomers();

    _vhbc = _allVHBC.getVHBC(_customers.getCustomer(_customerId));

    notifyListeners();
  }

  @override
  void dispose() {
    _gRep.dispose();
    super.dispose();
  }
}
