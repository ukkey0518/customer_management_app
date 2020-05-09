import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/customer_repository.dart';
import 'package:flutter/material.dart';

class CustomerEditViewModel extends ChangeNotifier {
  CustomerEditViewModel({cRep}) : _cRep = cRep;

  final CustomerRepository _cRep;

  //
  // --- Privateフィールド -------------------------------------------------------
  //

  //
  // --- フィールド --------------------------------------------------------------
  //

  // [読み込み状態]
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // [顧客データリスト]
  List<Customer> _customers = List();
  List<Customer> get customers => _customers;

  // [タイトル]
  String _title = '';
  String get title => _title;

  // [完了時メッセージ]
  String _completeMessage = '';
  String get completeMessage => _completeMessage;

  // [エラーメッセージ：名前入力欄]
  String _nameErrorText;
  String get nameErrorText => _nameErrorText;

  // [エラーメッセージ：よみがな入力欄]
  String _nameReadingErrorText;
  String get nameReadingErrorText => _nameReadingErrorText;

  // [編集中の顧客]
  Customer _editingCustomer;
  Customer get editingCustomer => _editingCustomer;

  // [コントローラ：名前入力欄]
  TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  // [コントローラ：よみがな入力欄]
  TextEditingController _nameReadingController = TextEditingController();
  TextEditingController get nameReadingController => _nameReadingController;

  // [性別]
  bool _isGenderFemale = false;
  bool get isGenderFemale => _isGenderFemale;

  // [生年月日]
  DateTime _birthDay;
  DateTime get birthDay => _birthDay;

  //
  // --- 処理 -------------------------------------------------------------------
  //

  // [更新：Repository更新時]
  onRepositoryUpdated(CustomerRepository cRep) {
    print('CustomerEditViewModel.onRepositoryUpdated :');
    _customers = cRep.customers;
    _isLoading = cRep.isLoading;

    notifyListeners();
  }
}
