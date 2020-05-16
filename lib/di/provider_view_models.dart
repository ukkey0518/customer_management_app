import 'package:customermanagementapp/repositories/employee_repository.dart';
import 'package:customermanagementapp/repositories/global_repository.dart';
import 'package:customermanagementapp/repositories/visit_history_repository.dart';
import 'package:customermanagementapp/viewmodel/customer_edit_view_model.dart';
import 'package:customermanagementapp/viewmodel/customer_information_view_model.dart';
import 'package:customermanagementapp/viewmodel/customers_list_view_model.dart';
import 'package:customermanagementapp/viewmodel/employee_setting_view_model.dart';
import 'package:customermanagementapp/viewmodel/menu_category_setting_view_model.dart';
import 'package:customermanagementapp/viewmodel/menu_select_view_model.dart';
import 'package:customermanagementapp/viewmodel/menu_setting_view_model.dart';
import 'package:customermanagementapp/viewmodel/visit_history_edit_view_model.dart';
import 'package:customermanagementapp/viewmodel/visit_history_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> viewModelProviders = [
  // [VM: 顧客リスト画面]
  ChangeNotifierProxyProvider<GlobalRepository, CustomersListViewModel>(
    create: (context) => CustomersListViewModel(
      gRep: Provider.of<GlobalRepository>(context, listen: false),
    ),
    update: (_, gRep, viewModel) => viewModel..onRepositoryUpdated(gRep),
  ),

  // [VM: 顧客情報表示画面]
  ChangeNotifierProxyProvider<GlobalRepository, CustomerInformationViewModel>(
    create: (context) => CustomerInformationViewModel(
      gRep: Provider.of<GlobalRepository>(context, listen: false),
    ),
    update: (_, gRep, viewModel) => viewModel..onRepositoryUpdated(gRep),
  ),

  // [VM: 顧客情報編集画面]
  ChangeNotifierProxyProvider<GlobalRepository, CustomerEditViewModel>(
    create: (context) => CustomerEditViewModel(
      gRep: Provider.of<GlobalRepository>(context, listen: false),
    ),
    update: (_, gRep, viewModel) => viewModel..onRepositoryUpdated(gRep),
  ),

  // [VM: 従業員設定画面]
  ChangeNotifierProxyProvider<GlobalRepository, EmployeeSettingViewModel>(
    create: (context) => EmployeeSettingViewModel(
      gRep: Provider.of<GlobalRepository>(context, listen: false),
    ),
    update: (_, gRep, viewModel) => viewModel..onRepositoryUpdated(gRep),
  ),

  // [VM: メニューカテゴリ設定画面]
  ChangeNotifierProxyProvider<GlobalRepository, MenuCategorySettingViewModel>(
    create: (context) => MenuCategorySettingViewModel(
      gRep: Provider.of<GlobalRepository>(context, listen: false),
    ),
    update: (_, gRep, viewModel) => viewModel..onRepositoryUpdated(gRep),
  ),

  // [VM: メニュー設定画面]
  ChangeNotifierProxyProvider<GlobalRepository, MenuSettingViewModel>(
    create: (context) => MenuSettingViewModel(
      gRep: Provider.of<GlobalRepository>(context, listen: false),
    ),
    update: (_, gRep, viewModel) => viewModel..onRepositoryUpdated(gRep),
  ),

  // [VM: メニュー選択画面]
  ChangeNotifierProxyProvider<GlobalRepository, MenuSelectViewModel>(
    create: (context) => MenuSelectViewModel(
      gRep: Provider.of<GlobalRepository>(context, listen: false),
    ),
    update: (_, gRep, viewModel) => viewModel..onRepositoryUpdated(gRep),
  ),

  // [VM: 来店履歴リスト画面]
  ChangeNotifierProxyProvider<GlobalRepository, VisitHistoryListViewModel>(
    create: (context) => VisitHistoryListViewModel(
      gRep: Provider.of<GlobalRepository>(context, listen: false),
    ),
    update: (_, gRep, viewModel) => viewModel..onRepositoryUpdated(gRep),
  ),

  // [VM: 来店履歴編集画面]
  ChangeNotifierProxyProvider2<VisitHistoryRepository, EmployeeRepository,
      VisitHistoryEditViewModel>(
    create: (context) => VisitHistoryEditViewModel(
      vhRep: Provider.of<VisitHistoryRepository>(context, listen: false),
      eRep: Provider.of<EmployeeRepository>(context, listen: false),
    ),
    update: (_, vhRep, eRep, viewModel) =>
        viewModel..onRepositoriesUpdated(vhRep, eRep),
  ),
];
