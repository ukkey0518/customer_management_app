import 'package:customermanagementapp/repositories/customer_repository.dart';
import 'package:customermanagementapp/repositories/employee_repository.dart';
import 'package:customermanagementapp/repositories/global_repository.dart';
import 'package:customermanagementapp/repositories/menus_by_category_repository.dart';
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
  ChangeNotifierProxyProvider<CustomerRepository, CustomerEditViewModel>(
    create: (context) => CustomerEditViewModel(
      cRep: Provider.of<CustomerRepository>(context, listen: false),
    ),
    update: (_, cRep, viewModel) => viewModel..onRepositoryUpdated(cRep),
  ),

  // [VM: 従業員設定画面]
  ChangeNotifierProxyProvider<GlobalRepository, EmployeeSettingViewModel>(
    create: (context) => EmployeeSettingViewModel(
      gRep: Provider.of<GlobalRepository>(context, listen: false),
    ),
    update: (_, gRep, viewModel) => viewModel..onRepositoryUpdated(gRep),
  ),

  // [VM: メニューカテゴリ設定画面]
  ChangeNotifierProxyProvider<MenusByCategoryRepository,
      MenuCategorySettingViewModel>(
    create: (context) => MenuCategorySettingViewModel(
      mbcRep: Provider.of<MenusByCategoryRepository>(context, listen: false),
    ),
    update: (_, mbcRep, viewModel) => viewModel..onRepositoryUpdated(mbcRep),
  ),

  // [VM: メニュー設定画面]
  ChangeNotifierProxyProvider<MenusByCategoryRepository, MenuSettingViewModel>(
    create: (context) => MenuSettingViewModel(
      mbcRep: Provider.of<MenusByCategoryRepository>(context, listen: false),
    ),
    update: (_, mbcRep, viewModel) => viewModel..onRepositoryUpdated(mbcRep),
  ),

  // [VM: メニュー選択画面]
  ChangeNotifierProxyProvider<MenusByCategoryRepository, MenuSelectViewModel>(
    create: (context) => MenuSelectViewModel(
      mbcRep: Provider.of<MenusByCategoryRepository>(context, listen: false),
    ),
    update: (_, mbcRep, viewModel) => viewModel..onRepositoryUpdated(mbcRep),
  ),

  // [VM: 来店履歴リスト画面]
  ChangeNotifierProxyProvider<VisitHistoryRepository,
      VisitHistoryListViewModel>(
    create: (context) => VisitHistoryListViewModel(
      vhRep: Provider.of<VisitHistoryRepository>(context, listen: false),
    ),
    update: (_, vhRep, viewModel) => viewModel..onRepositoryUpdated(vhRep),
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
