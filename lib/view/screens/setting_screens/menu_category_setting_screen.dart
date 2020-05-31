import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/dialogs/delete_confirm_dialog.dart';
import 'package:customermanagementapp/view/components/dialogs/menu_category_edit_dialog.dart';
import 'package:customermanagementapp/view/components/list_items/menu_category_list_item.dart';
import 'package:customermanagementapp/viewmodel/menu_category_setting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class MenuCategorySettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<MenuCategorySettingViewModel>(context, listen: false);

    if (viewModel.mbcList.isEmpty) {
      Future(() {
        viewModel.getMBCList();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('メニューカテゴリ管理'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showEditDialog(context),
      ),
      body: Consumer<MenuCategorySettingViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            itemCount: viewModel.mbcList.length,
            itemBuilder: (context, index) {
              return MenuCategoryListItem(
                menuCategory: viewModel.mbcList[index].menuCategory,
                onTap: (category) => _showEditDialog(context, category),
                onLongPress: (category) => _deleteMenuCategory(context, index),
              );
            },
          );
        },
      ),
    );
  }

  // [コールバック：リストアイテムをタップ時]
  _showEditDialog(BuildContext context, [MenuCategory menuCategory]) {
    final viewModel =
        Provider.of<MenuCategorySettingViewModel>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return MenuCategoryEditDialog(category: menuCategory);
      },
    ).then(
      (category) async {
        if (category != null) {
          await viewModel.addMenuCategory(category);
        }
      },
    );
  }

  // [コールバック：リストアイテム長押し時]
  _deleteMenuCategory(BuildContext context, int index) async {
    final viewModel =
        Provider.of<MenuCategorySettingViewModel>(context, listen: false);

    var deleteMBC = viewModel.mbcList[index];

    // カテゴリ内にメニューがある場合は削除できない
    if (deleteMBC.menus.isNotEmpty) {
      Toast.show('カテゴリ内にメニューが存在するため削除できません。', context,
          duration: Toast.LENGTH_LONG);
    } else {
      showDialog(
        context: context,
        builder: (_) => DeleteConfirmDialog(
          deleteValue: deleteMBC.menuCategory.name,
        ),
      ).then((flag) async {
        if (flag) {
          await viewModel.deleteMenuCategory(deleteMBC.menuCategory);
          Toast.show('削除しました', context);
        }
      });
    }
  }
}
