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
import 'package:customermanagementapp/repositories/visit_histories_by_customer_repository.dart';
import 'package:customermanagementapp/repositories/visit_history_repository.dart';
import 'package:customermanagementapp/viewmodel/employee_view_model.dart';
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
    create: (_) => MyDatabase(),
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
    create: (context) => CustomerRepository(
      dao: Provider.of<CustomerDao>(context, listen: false),
    ),
  ),
  // EmployeeRepository
  ChangeNotifierProvider<EmployeeRepository>(
    create: (context) => EmployeeRepository(
      dao: Provider.of<EmployeeDao>(context, listen: false),
    ),
  ),
  // MenuCategoryRepository
  ChangeNotifierProvider<MenuCategoryRepository>(
    create: (context) => MenuCategoryRepository(
      dao: Provider.of<MenuCategoryDao>(context, listen: false),
    ),
  ),
  // MenuRepository
  ChangeNotifierProvider<MenuRepository>(
    create: (context) => MenuRepository(
      dao: Provider.of<MenuDao>(context, listen: false),
    ),
  ),
  // VisitHistoryRepository
  ChangeNotifierProvider<VisitHistoryRepository>(
    create: (context) => VisitHistoryRepository(
      dao: Provider.of<VisitHistoryDao>(context, listen: false),
    ),
  ),
  // VisitHistoriesByCustomerRepository
  ChangeNotifierProxyProvider2<CustomerRepository, VisitHistoryRepository,
      VisitHistoriesByCustomerRepository>(
    create: (context) => VisitHistoriesByCustomerRepository(
      cRep: Provider.of<CustomerRepository>(context, listen: false),
      vhRep: Provider.of<VisitHistoryRepository>(context, listen: false),
    ),
    update: (_, cRep, vhRep, repository) =>
        repository.onRepositoryUpdated(cRep, vhRep),
  ),
];

List<SingleChildWidget> viewModels = [
  // EmployeeViewModel
  ChangeNotifierProxyProvider<EmployeeRepository, EmployeeViewModel>(
    create: (context) => EmployeeViewModel(
      repository: Provider.of<EmployeeRepository>(context, listen: false),
    ),
    update: (_, repository, viewModel) =>
        viewModel..onRepositoryUpdated(repository),
  ),
];
