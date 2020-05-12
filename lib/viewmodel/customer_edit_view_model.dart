import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/customer_repository.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:flutter/material.dart';

class CustomerEditViewModel extends ChangeNotifier {
  CustomerEditViewModel({cRep}) : _cRep = cRep;

  final CustomerRepository _cRep;

  List<Customer> _customers;
  int _id;

  Customer _customer;

  Customer get customer => _customer;

  String _title = '';

  String get title => _title;

  TextEditingController _nameController = TextEditingController();

  TextEditingController get nameController => _nameController;

  TextEditingController _nameReadingController = TextEditingController();

  TextEditingController get nameReadingController => _nameReadingController;

  bool _isGenderFemale = true;

  bool get isGenderFemale => _isGenderFemale;

  DateTime _birthDay = DateTime(1980, 1, 1);

  DateTime get birthDay => _birthDay;

  String _nameFieldErrorText;

  String get nameFieldErrorText => _nameFieldErrorText;

  String _nameReadingFieldErrorText;

  String get nameReadingFieldErrorText => _nameReadingFieldErrorText;

  bool _isSaved = false;

  bool get isSaved => _isSaved;

  setCustomer(Customer customer) async {
    _customers = await _cRep.getCustomers();

    if (customer != null) {
      _customer = customer;
      _id = _customer.id;
      _nameController.text = _customer.name;
      _nameReadingController.text = _customer.nameReading;
      _isGenderFemale = _customer.isGenderFemale;
      _birthDay = _customer.birth;
      _title = '顧客データの編集';
    } else {
      _customer = customer;
      _id = null;
      _nameController.text = '';
      _nameReadingController.text = '';
      _isGenderFemale = false;
      _birthDay = null;
      _title = '顧客データの登録';
    }
  }

  setStatus({
    String name,
    String nameReading,
    bool isGenderFemale,
    DateTime birthDay,
  }) {
    _nameController.text = name ?? _nameController.text;
    _nameReadingController.text = nameReading ?? _nameReadingController.text;
    _isGenderFemale = isGenderFemale ?? _isGenderFemale;
    _birthDay = birthDay ?? _birthDay;

    _isSaved = false;
  }

  saveCustomer() async {
    // 未入力チェック
    _nameFieldErrorText = _nameController.text.isEmpty ? '必須入力です' : null;
    _nameReadingFieldErrorText =
        _nameReadingController.text.isEmpty ? '必須入力です' : null;

    //重複チェック
    _nameFieldErrorText = _customers.isNameDuplicated(_id, _nameController.text)
        ? '同名の顧客データが存在しています。'
        : _nameFieldErrorText;

    if (_nameFieldErrorText != null || _nameReadingFieldErrorText != null) {
      return false;
    }

    final newCustomer = Customer(
      id: _id,
      name: _nameController.text,
      nameReading: _nameReadingController.text,
      isGenderFemale: _isGenderFemale,
      birth: _birthDay,
    );

    await _cRep.addCustomer(newCustomer);
    _isSaved = true;

    return true;
  }

  onRepositoryUpdated(CustomerRepository cRep) {
    _customers = cRep.customers;
    notifyListeners();
  }
}
