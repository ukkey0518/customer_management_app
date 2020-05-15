import 'package:customermanagementapp/di/provider_daos.dart';
import 'package:customermanagementapp/di/provider_db.dart';
import 'package:customermanagementapp/di/provider_repositories.dart';
import 'package:customermanagementapp/di/provider_view_models.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [
  ...dbProviders,
  ...daoProviders,
  ...indepRepProviders,
  ...depRepProviders,
  ...viewModelProviders,
];
