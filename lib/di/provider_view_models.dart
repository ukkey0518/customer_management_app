import 'package:customermanagementapp/repositories/customer_repository.dart';
import 'package:customermanagementapp/repositories/employee_repository.dart';
import 'package:customermanagementapp/repositories/menus_by_category_repository.dart';
import 'package:customermanagementapp/repositories/visit_histories_by_customer_repository.dart';
import 'package:customermanagementapp/repositories/visit_history_repository.dart';
import 'package:customermanagementapp/viewmodel/customer_edit_view_model.dart';
import 'package:customermanagementapp/viewmodel/customer_information_view_model.dart';
import 'package:customermanagementapp/viewmodel/customers_list_view_model.dart';
import 'package:customermanagementapp/viewmodel/employee_view_model.dart';
import 'package:customermanagementapp/viewmodel/menu_category_setting_view_model.dart';
import 'package:customermanagementapp/viewmodel/menu_select_view_model.dart';
import 'package:customermanagementapp/viewmodel/menu_setting_view_model.dart';
import 'package:customermanagementapp/viewmodel/visit_history_edit_view_model.dart';
import 'package:customermanagementapp/viewmodel/visit_history_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> viewModels = [
  ChangeNotifierProxyProvider<VisitHistoriesByCustomerRepository,
      CustomersListViewModel>(
    create: (context) {
      return CustomersListViewModel(
        vhbcRep: Provider.of<VisitHistoriesByCustomerRepository>(context,
            listen: false),
      );
    },
    update: (_, vhbcRep, viewModel) => viewModel..onRepositoryUpdated(vhbcRep),
  ),
  ChangeNotifierProxyProvider<VisitHistoriesByCustomerRepository,
      CustomerInformationViewModel>(
    create: (context) {
      return CustomerInformationViewModel(
        vhbcRep: Provider.of<VisitHistoriesByCustomerRepository>(context,
            listen: false),
      );
    },
    update: (_, vhbcRep, viewModel) => viewModel..onRepositoryUpdated(vhbcRep),
  ),
  ChangeNotifierProxyProvider<MenusByCategoryRepository,
      MenuCategorySettingViewModel>(
    create: (context) {
      return MenuCategorySettingViewModel(
        mbcRep: Provider.of<MenusByCategoryRepository>(context, listen: false),
      );
    },
    update: (_, mbcRep, viewModel) => viewModel..onRepositoryUpdated(mbcRep),
  ),
  ChangeNotifierProxyProvider<MenusByCategoryRepository, MenuSettingViewModel>(
    create: (context) {
      return MenuSettingViewModel(
        mbcRep: Provider.of<MenusByCategoryRepository>(context, listen: false),
      );
    },
    update: (_, mbcRep, viewModel) => viewModel..onRepositoryUpdated(mbcRep),
  ),
  ChangeNotifierProxyProvider<MenusByCategoryRepository, MenuSelectViewModel>(
    create: (context) {
      return MenuSelectViewModel(
        mbcRep: Provider.of<MenusByCategoryRepository>(context, listen: false),
      );
    },
    update: (_, mbcRep, viewModel) => viewModel..onRepositoryUpdated(mbcRep),
  ),
  ChangeNotifierProxyProvider<CustomerRepository, CustomerEditViewModel>(
    create: (context) {
      return CustomerEditViewModel(
        cRep: Provider.of<CustomerRepository>(context, listen: false),
      );
    },
    update: (_, cRep, viewModel) => viewModel..onRepositoryUpdated(cRep),
  ),
  // EmployeeViewModel
  ChangeNotifierProxyProvider<EmployeeRepository, EmployeeViewModel>(
    create: (context) {
      return EmployeeViewModel(
        repository: Provider.of<EmployeeRepository>(context, listen: false),
      );
    },
    update: (_, repository, viewModel) =>
        viewModel..onRepositoryUpdated(repository),
  ),
  ChangeNotifierProxyProvider<VisitHistoryRepository,
      VisitHistoryListViewModel>(
    create: (context) {
      return VisitHistoryListViewModel(
        vhRep: Provider.of<VisitHistoryRepository>(context, listen: false),
      );
    },
    update: (_, vhRep, viewModel) => viewModel..onRepositoryUpdated(vhRep),
  ),
  ChangeNotifierProxyProvider2<VisitHistoryRepository, EmployeeRepository,
      VisitHistoryEditViewModel>(
    create: (context) {
      return VisitHistoryEditViewModel(
        vhRep: Provider.of<VisitHistoryRepository>(context, listen: false),
        eRep: Provider.of<EmployeeRepository>(context, listen: false),
      );
    },
    update: (_, vhRep, eRep, viewModel) =>
        viewModel..onRepositoriesUpdated(vhRep, eRep),
  ),
];
