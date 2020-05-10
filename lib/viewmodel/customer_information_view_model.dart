import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/visit_histories_by_customer_repository.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';

class CustomerInformationViewModel extends ChangeNotifier {
  CustomerInformationViewModel({vhbcRep}) : _vhbcRep = vhbcRep;

  final VisitHistoriesByCustomerRepository _vhbcRep;

  List<VisitHistoriesByCustomer> _allVHBC = List();

  int _customerId;

  List<Customer> _customers = List();
  List<Customer> get customers => _customers;

  VisitHistoriesByCustomer _vhbc;
  VisitHistoriesByCustomer get vhbc => _vhbc;

  getVHBC({int id}) async {
    print('CustomerInformationViewModel.getVHBC :');

    _customerId = id;

    _allVHBC = await _vhbcRep.getVisitHistoriesByCustomers();
    _customers = _allVHBC.toCustomers();

    _vhbc = _allVHBC.getVHBC(_customers.getCustomer(_customerId));
  }

  addCustomer(Customer customer) async {
    print('CustomerInformationViewModel.onRepositoryUpdated :');

    _allVHBC = await _vhbcRep.addCustomer(customer);
    _customers = _allVHBC.toCustomers();

    _vhbc = _allVHBC.getVHBC(_customers.getCustomer(_customerId));
  }

  onRepositoryUpdated(VisitHistoriesByCustomerRepository vhbcRep) {
    print('CustomerInformationViewModel.onRepositoryUpdated :');

    _allVHBC = _vhbcRep.visitHistoriesByCustomers;
    _customers = _allVHBC.toCustomers();

    _vhbc = _allVHBC.getVHBC(_customers.getCustomer(_customerId));
  }

  @override
  void dispose() {
    _vhbcRep.dispose();
    super.dispose();
  }
}
