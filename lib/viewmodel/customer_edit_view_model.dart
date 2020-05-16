import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/global_repository.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:flutter/material.dart';

class CustomerEditViewModel extends ChangeNotifier {
  CustomerEditViewModel({gRep}) : _gRep = gRep;

  final GlobalRepository _gRep;

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

  String _selectedVisitReason;

  String get selectedVisitReason => _selectedVisitReason;

  String _nameFieldErrorText;

  String get nameFieldErrorText => _nameFieldErrorText;

  String _nameReadingFieldErrorText;

  String get nameReadingFieldErrorText => _nameReadingFieldErrorText;

  bool _isSaved = false;

  bool get isSaved => _isSaved;

  // 画面生成時にフィールドを初期化する処理
  setCustomer(Customer customer) async {
    print('[VM: 顧客データ編集画面] setCustomer');
    await _gRep.getData();
    _customers = _gRep.customers;

    if (customer != null) {
      _customer = customer;
      _id = _customer.id;
      _nameController.text = _customer.name;
      _nameReadingController.text = _customer.nameReading;
      _isGenderFemale = _customer.isGenderFemale;
      _birthDay = _customer.birth;
      _selectedVisitReason = _customer.visitReason;
      _title = '顧客データの編集';
      _isSaved = true;
    } else {
      _customer = customer;
      _id = null;
      _nameController.text = '';
      _nameReadingController.text = '';
      _isGenderFemale = false;
      _birthDay = null;
      _selectedVisitReason = null;
      _title = '顧客データの登録';
      _isSaved = false;
    }

    _nameFieldErrorText = null;
    _nameReadingFieldErrorText = null;
  }

  // 入力欄変更処理
  onInputFieldChanged() {
    print('[VM: 顧客データ編集画面] onInputFieldChanged');
    _isSaved = false;
  }

  // 性別変更処理
  onGenderChanged(bool isGenderFemale) {
    print('[VM: 顧客データ編集画面] onGenderChanged');
    _isGenderFemale = isGenderFemale ?? _isGenderFemale;

    _isSaved = false;
    notifyListeners();
  }

  // 生年月日変更処理
  onBirthdayChanged(DateTime birthDay) {
    print('[VM: 顧客データ編集画面] onBirthdayChanged');
    _birthDay = birthDay;

    _isSaved = false;
    notifyListeners();
  }

  onVisitReasonChanged(String visitReason) {
    print('[VM: 顧客データ編集画面] onVisitReasonChanged');
    _selectedVisitReason = visitReason;

    _isSaved = false;
    notifyListeners();
  }

  // 保存処理
  saveCustomer() async {
    print('[VM: 顧客データ編集画面] saveCustomer');
    // 未入力チェック
    _nameFieldErrorText = _nameController.text.isEmpty ? '必須入力です' : null;
    _nameReadingFieldErrorText =
        _nameReadingController.text.isEmpty ? '必須入力です' : null;

    //重複チェック
    _nameFieldErrorText = _customers.isNameDuplicated(_id, _nameController.text)
        ? '同名の顧客データが存在しています。'
        : _nameFieldErrorText;

    if (_nameFieldErrorText != null || _nameReadingFieldErrorText != null) {
      notifyListeners();
      return false;
    }

    final newCustomer = Customer(
      id: _id,
      name: _nameController.text,
      nameReading: _nameReadingController.text,
      isGenderFemale: _isGenderFemale,
      birth: _birthDay,
      visitReason: _selectedVisitReason,
    );

    await _gRep.addSingleData(newCustomer);

    _nameFieldErrorText = null;
    _nameReadingFieldErrorText = null;
    _isSaved = true;

    notifyListeners();
    return true;
  }

  // Repository更新時に呼ばれる
  onRepositoryUpdated(GlobalRepository gRep) {
    print('  [VM: 顧客データ編集画面] onRepositoryUpdated');

    _customers = gRep.customers;
    notifyListeners();
  }

  @override
  void dispose() {
    _gRep.dispose();
    super.dispose();
  }
}
