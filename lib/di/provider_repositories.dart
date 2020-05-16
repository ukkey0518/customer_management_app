import 'package:customermanagementapp/db/dao/customer_dao.dart';
import 'package:customermanagementapp/db/dao/employee_dao.dart';
import 'package:customermanagementapp/db/dao/menu_category_dao.dart';
import 'package:customermanagementapp/db/dao/menu_dao.dart';
import 'package:customermanagementapp/db/dao/visit_history_dao.dart';
import 'package:customermanagementapp/repositories/customer_repository.dart';
import 'package:customermanagementapp/repositories/employee_repository.dart';
import 'package:customermanagementapp/repositories/global_repository.dart';
import 'package:customermanagementapp/repositories/menu_category_repository.dart';
import 'package:customermanagementapp/repositories/menu_repository.dart';
import 'package:customermanagementapp/repositories/menus_by_category_repository.dart';
import 'package:customermanagementapp/repositories/visit_histories_by_customer_repository.dart';
import 'package:customermanagementapp/repositories/visit_history_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> indepRepProviders = [
  // [Rep: CustomerRepository]
  ChangeNotifierProvider<CustomerRepository>(
    create: (context) => CustomerRepository(
      dao: Provider.of<CustomerDao>(context, listen: false),
    ),
  ),

  // [Rep: EmployeeRepository]
  ChangeNotifierProvider<EmployeeRepository>(
    create: (context) => EmployeeRepository(
      dao: Provider.of<EmployeeDao>(context, listen: false),
    ),
  ),

  // [Rep: MenuCategoryRepository]
  ChangeNotifierProvider<MenuCategoryRepository>(
    create: (context) => MenuCategoryRepository(
      dao: Provider.of<MenuCategoryDao>(context, listen: false),
    ),
  ),

  // [Rep: MenuRepository]
  ChangeNotifierProvider<MenuRepository>(
    create: (context) => MenuRepository(
      dao: Provider.of<MenuDao>(context, listen: false),
    ),
  ),
];

List<SingleChildWidget> depRepProviders = [
  // [Rep: VisitHistoryRepository]
  // (依存) CustomerRepository, EmployeeRepository, MenuRepository
  ChangeNotifierProxyProvider4<VisitHistoryDao, CustomerRepository,
      EmployeeRepository, MenuRepository, VisitHistoryRepository>(
    create: (context) => VisitHistoryRepository(
      dao: Provider.of<VisitHistoryDao>(context, listen: false),
      cRep: Provider.of<CustomerRepository>(context, listen: false),
      eRep: Provider.of<EmployeeRepository>(context, listen: false),
      mRep: Provider.of<MenuRepository>(context, listen: false),
    ),
    update: (_, dao, cRep, eRep, mRep, vhRep) =>
        vhRep..onRepositoryUpdated(cRep, eRep, mRep),
  ),

  // [Rep: VisitHistoriesByCustomerRepository]
  // (依存) CustomerRepository, VisitHistoryRepository
  ChangeNotifierProxyProvider2<CustomerRepository, VisitHistoryRepository,
      VisitHistoriesByCustomerRepository>(
    create: (context) => VisitHistoriesByCustomerRepository(
      cRep: Provider.of<CustomerRepository>(context, listen: false),
      vhRep: Provider.of<VisitHistoryRepository>(context, listen: false),
    ),
    update: (_, cRep, vhRep, vhbcRep) =>
        vhbcRep..onRepositoriesUpdated(cRep, vhRep),
  ),

  // [Rep: MenusByCategoryRepository]
  // (依存) MenuRepository, MenuCategoryRepository
  ChangeNotifierProxyProvider2<MenuRepository, MenuCategoryRepository,
      MenusByCategoryRepository>(
    create: (context) => MenusByCategoryRepository(
      mRep: Provider.of<MenuRepository>(context, listen: false),
      mcRep: Provider.of<MenuCategoryRepository>(context, listen: false),
    ),
    update: (_, mRep, mcRep, mbcRep) =>
        mbcRep..onRepositoriesUpdated(mRep, mcRep),
  ),
  // [Rep: GlobalRepository]
  // (依存) CustomerRepository, EmployeeRepository, MenuRepository, MenuCategoryRepository, VisitHistoryRepository
  ChangeNotifierProxyProvider5<
      CustomerRepository,
      EmployeeRepository,
      MenuCategoryRepository,
      MenuRepository,
      VisitHistoryRepository,
      GlobalRepository>(
    create: (context) => GlobalRepository(
      cRep: Provider.of<CustomerRepository>(context, listen: false),
      eRep: Provider.of<EmployeeRepository>(context, listen: false),
      mcRep: Provider.of<MenuCategoryRepository>(context, listen: false),
      mRep: Provider.of<MenuRepository>(context, listen: false),
      vhRep: Provider.of<VisitHistoryRepository>(context, listen: false),
    ),
    update: (_, cRep, eRep, mcRep, mRep, vhRep, globalRep) =>
        globalRep..onRepositoriesUpdated(cRep, eRep, mcRep, mRep, vhRep),
  ),
];
