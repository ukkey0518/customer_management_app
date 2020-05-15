import 'package:customermanagementapp/db/database.dart';
import 'package:moor/moor.dart';

part 'visit_reason_dao.g.dart';

@UseDao(tables: [VisitReasons])
class VisitReasonDao extends DatabaseAccessor<MyDatabase> with _$VisitReasonDaoMixin{
  VisitReasonDao(MyDatabase db) : super(db);
}
