import 'package:customermanagementapp/db/dao/customer_dao.dart';
import 'package:customermanagementapp/db/dao/employee_dao.dart';
import 'package:customermanagementapp/db/dao/menu_category_dao.dart';
import 'package:customermanagementapp/db/dao/menu_dao.dart';
import 'package:customermanagementapp/db/dao/visit_history_dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repository/my_repository.dart';
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
  // MyRepository
  ChangeNotifierProvider<MyRepository>(
    create: (context) => MyRepository(
      dao: Provider.of<CustomerDao>(context, listen: false),
    ),
  ),
];

List<SingleChildWidget> viewModels = [
  // EmployeeViewModel
  ChangeNotifierProxyProvider<MyRepository, EmployeeViewModel>(
    create: (context) => EmployeeViewModel(
      repository: Provider.of<MyRepository>(context, listen: false),
    ),
    update: (_, repository, viewModel) =>
        viewModel..onRepositoryUpdated(repository),
  ),
];
