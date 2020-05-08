import 'package:customermanagementapp/db/database.dart';
import 'package:moor/moor.dart';

part 'menu_category_dao.g.dart';

@UseDao(tables: [MenuCategories])
class MenuCategoryDao extends DatabaseAccessor<MyDatabase>
    with _$MenuCategoryDaoMixin {
  MenuCategoryDao(MyDatabase db) : super(db);

  //
  // -- アセンブリ処理 -----------------------------------------------------------
  //

  // [追加：１件]
  Future<int> addMenuCategory(MenuCategory menuCategory) =>
      into(menuCategories).insert(menuCategory, mode: InsertMode.replace);

  // [追加：複数]
  Future<void> addAllMenuCategories(
      List<MenuCategory> menuCategoriesList) async {
    await batch((batch) {
      batch.insertAll(menuCategories, menuCategoriesList);
    });
  }

  // [取得：すべて]
  Future<List<MenuCategory>> get allMenuCategories =>
      select(menuCategories).get();

  // [削除：１件]
  Future deleteMenuCategory(MenuCategory menuCategory) =>
      (delete(menuCategories)..where((t) => t.id.equals(menuCategory.id))).go();

  //
  // -- トランザクション処理 ------------------------------------------------------
  //

  // 一括処理( 追加 )：１件追加 -> 全取得]
  Future<List<MenuCategory>> addAndGetAllMenuCategories(
      MenuCategory menuCategory) {
    return transaction(() async {
      await addMenuCategory(menuCategory);
      return await allMenuCategories;
    });
  }

  // 一括処理( 追加 )：複数追加 -> 全取得]
  Future<List<MenuCategory>> addAllAndGetAllMenuCategories(
      List<MenuCategory> menuCategoryList) {
    return transaction(() async {
      await addAllMenuCategories(menuCategoryList);
      return await allMenuCategories;
    });
  }

  // 一括処理( 削除 )：１件削除 -> 全取得]
  Future<List<MenuCategory>> deleteAndGetAllMenuCategory(
      MenuCategory menuCategory) {
    return transaction(() async {
      await deleteMenuCategory(menuCategory);
      return await allMenuCategories;
    });
  }
}
