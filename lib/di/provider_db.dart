import 'package:customermanagementapp/db/database.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

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
