import 'package:customermanagementapp/db/dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/repository/my_repository.dart';
import 'package:customermanagementapp/viewmodel/employee_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];

List<SingleChildWidget> independentModels = [
  // [データベース]
  Provider<MyDatabase>(
    create: (_) => MyDatabase(),
    dispose: (_, db) => db.close(),
  ),
];

List<SingleChildWidget> dependentModels = [
  // MyDao
  ProxyProvider<MyDatabase, MyDao>(
    update: (_, db, dao) => MyDao(db),
  ),
  // MyRepository
  ChangeNotifierProvider<MyRepository>(
    create: (context) => MyRepository(
      dao: Provider.of<MyDao>(context, listen: false),
    ),
  ),
];

List<SingleChildWidget> viewModels = [
  // EmployeeSettingViewModel
  ChangeNotifierProxyProvider<MyRepository, EmployeeViewModel>(
    create: (context) => EmployeeViewModel(
      repository: Provider.of<MyRepository>(context, listen: false),
    ),
    update: (_, repository, viewModel) =>
        viewModel..onRepositoryUpdated(repository),
  ),
];
