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
  Future<void> addAllMenus(List<Menu> menuList) async {
    await batch((batch) {
      batch.insertAll(menus, menuList);
    });
  }

  // [取得：すべてのメニューを取得]
  Future<List<Menu>> get allMenus => select(menus).get();

  // [削除：１件分のメニューを削除]
  Future deleteMenu(Menu menu) =>
      (delete(menus)..where((t) => t.id.equals(menu.id))).go();

  //
  // -- トランザクション処理 ------------------------------------------------------
  //

  // [一括処理：１件追加 -> 全取得]
  Future<List<Menu>> addAndGetAllMenus(Menu menu) {
    return transaction(() async {
      await addMenu(menu);
      return allMenus;
    });
  }

  // [一括処理：複数追加 -> 全取得]
  Future<List<Menu>> addAllAndGetAllMenus(List<Menu> menuList) {
    return transaction(() async {
      await addAllMenus(menuList);
      return await allMenus;
    });
  }

  // [一括処理：１件削除 -> 全取得]
  Future<List<Menu>> deleteAndGetAllMenus(Menu menu) {
    return transaction(() async {
      await deleteMenu(menu);
      return await allMenus;
    });
  }
}
