import 'package:customermanagementapp/db/dao/customer_dao.dart';
import 'package:customermanagementapp/db/dao/employee_dao.dart';
import 'package:customermanagementapp/db/dao/menu_category_dao.dart';
import 'package:customermanagementapp/db/dao/menu_dao.dart';
import 'package:customermanagementapp/db/dao/visit_history_dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repositories/customer_repository.dart';
import 'package:customermanagementapp/repositories/employee_repository.dart';
import 'package:customermanagementapp/repositories/menu_category_repository.dart';
import 'package:customermanagementapp/repositories/menu_repository.dart';
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

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...daos,
  ...repositories,
  ...viewModels,
];

List<SingleChildWidget> independentModels = [
  // [データベース]
  Provider<MyDatabase>(
    create: (_) {
      print('database provider create.');
      return MyDatabase();
    },
    dispose: (_, db) => db.close(),
  ),
];

List<SingleChildWidget> daos = [
  // CustomerDao
  ProxyProvider<MyDatabase, CustomerDao>(
    update: (_, db, dao) => CustomerDao(db),
  ),
  // EmployeeDao
  ProxyProvider<MyDatabase, EmployeeDao>(
    update: (_, db, dao) => EmployeeDao(db),
  ),
  // MenuCategoryDao
  ProxyProvider<MyDatabase, MenuCategoryDao>(
    update: (_, db, dao) => MenuCategoryDao(db),
  ),
  // MenuDao
  ProxyProvider<MyDatabase, MenuDao>(
    update: (_, db, dao) => MenuDao(db),
  ),
  // VisitHistoryDao
  ProxyProvider<MyDatabase, VisitHistoryDao>(
    update: (_, db, dao) => VisitHistoryDao(db),
  ),
];

List<SingleChildWidget> repositories = [
  // CustomerRepository
  ChangeNotifierProvider<CustomerRepository>(
    create: (context) {
      print('CusotmerRepository provider create.');
      return CustomerRepository(
        dao: Provider.of<CustomerDao>(context, listen: false),
      );
    },
  ),
  // EmployeeRepository
  ChangeNotifierProvider<EmployeeRepository>(
    create: (context) {
      print('EmployeeRepository provider create.');
      return EmployeeRepository(
        dao: Provider.of<EmployeeDao>(context, listen: false),
      );
    },
  ),
  // MenuCategoryRepository
  ChangeNotifierProvider<MenuCategoryRepository>(
    create: (context) {
      print('MenuCategoryRepository provider create.');
      return MenuCategoryRepository(
        dao: Provider.of<MenuCategoryDao>(context, listen: false),
      );
    },
  ),
  // MenuRepository
  ChangeNotifierProvider<MenuRepository>(
    create: (context) {
      print('MenuRepository provider create.');
      return MenuRepository(
        dao: Provider.of<MenuDao>(context, listen: false),
      );
    },
  ),
  // VisitHistoryRepository
  ChangeNotifierProxyProvider4<VisitHistoryDao, CustomerRepository,
      EmployeeRepository, MenuRepository, VisitHistoryRepository>(
    create: (context) {
      print('VisitHistoryRepository provider create.');
      return VisitHistoryRepository(
        dao: Provider.of<VisitHistoryDao>(context, listen: false),
        cRep: Provider.of<CustomerRepository>(context, listen: false),
        eRep: Provider.of<EmployeeRepository>(context, listen: false),
        mRep: Provider.of<MenuRepository>(context, listen: false),
      );
    },
    update: (_, dao, cRep, eRep, mRep, vhRep) =>
        vhRep..onRepositoryUpdated(cRep, eRep, mRep),
  ),
  // VisitHistoriesByCustomerRepository
  ChangeNotifierProxyProvider2<CustomerRepository, VisitHistoryRepository,
      VisitHistoriesByCustomerRepository>(
    create: (context) {
      print('VisitHistoriesByCustomerRepository Repository provider create.');
      return VisitHistoriesByCustomerRepository(
        cRep: Provider.of<CustomerRepository>(context, listen: false),
        vhRep: Provider.of<VisitHistoryRepository>(context, listen: false),
      );
    },
    update: (_, cRep, vhRep, viewModel) =>
        viewModel..onRepositoriesUpdated(cRep, vhRep),
  ),
  ChangeNotifierProxyProvider2<MenuRepository, MenuCategoryRepository,
      MenusByCategoryRepository>(
    create: (context) {
      print('MenusByCategoryRepository Repository provider create.');
      return MenusByCategoryRepository(
        mRep: Provider.of<MenuRepository>(context, listen: false),
        mcRep: Provider.of<MenuCategoryRepository>(context, listen: false),
      );
    },
    update: (_, mRep, mcRep, viewModel) =>
        viewModel..onRepositoriesUpdated(mRep, mcRep),
  ),
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProxyProvider<VisitHistoriesByCustomerRepository,
      CustomersListViewModel>(
    create: (context) {
      print('CustomersListViewModel Repository provider create.');
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
      print('CustomerInformationViewModel Repository provider create.');
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
      print('MenuCategorySettingViewModel Repository provider create.');
      return MenuCategorySettingViewModel(
        mbcRep: Provider.of<MenusByCategoryRepository>(context, listen: false),
      );
    },
    update: (_, mbcRep, viewModel) => viewModel..onRepositoryUpdated(mbcRep),
  ),
  ChangeNotifierProxyProvider<MenusByCategoryRepository, MenuSettingViewModel>(
    create: (context) {
      print('MenuSettingViewModel Repository provider create.');
      return MenuSettingViewModel(
        mbcRep: Provider.of<MenusByCategoryRepository>(context, listen: false),
      );
    },
    update: (_, mbcRep, viewModel) => viewModel..onRepositoryUpdated(mbcRep),
  ),
  ChangeNotifierProxyProvider<MenusByCategoryRepository, MenuSelectViewModel>(
    create: (context) {
      print('MenuSelectViewModel Repository provider create.');
      return MenuSelectViewModel(
        mbcRep: Provider.of<MenusByCategoryRepository>(context, listen: false),
      );
    },
    update: (_, mbcRep, viewModel) => viewModel..onRepositoryUpdated(mbcRep),
  ),
  ChangeNotifierProxyProvider<CustomerRepository, CustomerEditViewModel>(
    create: (context) {
      print('CustomerEditViewModel provider create.');
      return CustomerEditViewModel(
        cRep: Provider.of<CustomerRepository>(context, listen: false),
      );
    },
    update: (_, cRep, viewModel) => viewModel..onRepositoryUpdated(cRep),
  ),
  // EmployeeViewModel
  ChangeNotifierProxyProvider<EmployeeRepository, EmployeeViewModel>(
    create: (context) {
      print('EmployeeViewModel provider create.');
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
      print('VisitHistoryListViewModel Repository provider create.');
      return VisitHistoryListViewModel(
        vhRep: Provider.of<VisitHistoryRepository>(context, listen: false),
      );
    },
    update: (_, vhRep, viewModel) => viewModel..onRepositoryUpdated(vhRep),
  ),
  ChangeNotifierProxyProvider2<VisitHistoryRepository, EmployeeRepository,
      VisitHistoryEditViewModel>(
    create: (context) {
      print('VisitHistoryEditViewModel Repository provider create.');
      return VisitHistoryEditViewModel(
        vhRep: Provider.of<VisitHistoryRepository>(context, listen: false),
        eRep: Provider.of<EmployeeRepository>(context, listen: false),
      );
    },
    update: (_, vhRep, eRep, viewModel) =>
        viewModel..onRepositoriesUpdated(vhRep, eRep),
  ),
];
