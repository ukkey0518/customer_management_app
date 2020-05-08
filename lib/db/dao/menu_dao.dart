import 'package:customermanagementapp/db/database.dart';
import 'package:moor/moor.dart';

part 'menu_dao.g.dart';

@UseDao(tables: [Menus])
class MenuDao extends DatabaseAccessor<MyDatabase> with _$MenuDaoMixin {
  MenuDao(MyDatabase db) : super(db);

  //
  // -- アセンブリ処理 -----------------------------------------------------------
  //

  // [追加：１件分のメニューを追加]
  Future<int> addMenu(Menu menu) =>
      into(menus).insert(menu, mode: InsertMode.replace);

  // [追加：渡されたデータをすべて追加]
  Future<void> addAllMenus(List<Menu> menusList) async {
    await batch((batch) {
      batch.insertAll(menus, menusList);
    });
  }

  // [取得：すべてのメニューを取得]
  Future<List<Menu>> get allMenus => select(menus).get();

  // [更新：１件分のメニューを更新]
  Future updateMenu(Menu menu) => update(menus).replace(menu);

  // [削除：１件分のメニューを削除]
  Future deleteMenu(Menu menu) =>
      (delete(menus)..where((t) => t.id.equals(menu.id))).go();

  //
  // -- トランザクション処理 ------------------------------------------------------
  //
}
