import 'package:customermanagementapp/db/dao.dart';
import 'package:customermanagementapp/db/database.dart';
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
  // DAO
  ProxyProvider<MyDatabase, MyDao>(
    update: (_, db, dao) => MyDao(db),
  ),
];

List<SingleChildWidget> viewModels = [];
