import 'package:customermanagementapp/db/dao/customer_dao.dart';
import 'package:customermanagementapp/db/dao/employee_dao.dart';
import 'package:customermanagementapp/db/dao/menu_category_dao.dart';
import 'package:customermanagementapp/db/dao/menu_dao.dart';
import 'package:customermanagementapp/db/dao/visit_history_dao.dart';
import 'package:customermanagementapp/db/dao/visit_reason_dao.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> daoProviders = [
  // [DAO: CustomerDao]
  ProxyProvider<MyDatabase, CustomerDao>(
    update: (_, db, dao) => CustomerDao(db),
  ),

  // [DAO: EmployeeDao]
  ProxyProvider<MyDatabase, EmployeeDao>(
    update: (_, db, dao) => EmployeeDao(db),
  ),

  // [DAO: VisitReasonDao]
  ProxyProvider<MyDatabase, VisitReasonDao>(
    update: (_, db, dao) => VisitReasonDao(db),
  ),

  // [DAO: MenuCategoryDao]
  ProxyProvider<MyDatabase, MenuCategoryDao>(
    update: (_, db, dao) => MenuCategoryDao(db),
  ),

  // [DAO: MenuDao]
  ProxyProvider<MyDatabase, MenuDao>(
    update: (_, db, dao) => MenuDao(db),
  ),

  // [DAO: VisitHistoryDao]
  ProxyProvider<MyDatabase, VisitHistoryDao>(
    update: (_, db, dao) => VisitHistoryDao(db),
  ),
];
