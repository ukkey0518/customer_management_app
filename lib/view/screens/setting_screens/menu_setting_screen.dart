import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/dialogs/delete_confirm_dialog.dart';
import 'package:customermanagementapp/view/components/dialogs/menu_edit_dialog.dart';
import 'package:customermanagementapp/view/components/menu_expansion_panel_list.dart';
import 'package:customermanagementapp/view/screens/setting_screens/menu_category_setting_screen.dart';
import 'package:customermanagementapp/viewmodel/menu_setting_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class MenuSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MenuSettingViewModel>(context, listen: false);

    if (viewModel.mbcList.isEmpty) {
      Future(() {
        viewModel.getMBCList();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('メニュー管理'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _startMenuCategorySettingScreen(context),
        icon: Icon(Icons.category),
        label: const Text('カテゴリの編集'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Consumer<MenuSettingViewModel>(
        builder: (context, viewModel, child) {
          return SingleChildScrollView(
            child: Container(
              child: MenuExpansionPanelList(
                menuByCategories: viewModel.mbcList,
                expansionCallback: (index, isExpanded) =>
                    _setExpended(context, index, isExpanded),
                onItemPanelTap: (category, menu) =>
                    _showEditMenuDialog(context, category, menu),
                onItemPanelLongPress: (menu) => _deleteMenuTile(context, menu),
                onAddPanelTap: (category) =>
                    _showEditMenuDialog(context, category),
              ),
            ),
          );
        },
      ),
    );
  }

  _setExpended(BuildContext context, int index, bool isExpanded) async {
    final viewModel = Provider.of<MenuSettingViewModel>(context, listen: false);

    await viewModel.setExpanded(index, !isExpanded);
  }

  // [コールバック：メニューリストパネルタップ時]
  _showEditMenuDialog(BuildContext context, MenuCategory category,
      [Menu menu]) {
    final viewModel = Provider.of<MenuSettingViewModel>(context, listen: false);

    showDialog(
      context: context,
      builder: (_) {
        return MenuEditDialog(
          category: category,
          menu: menu,
        );
      },
    ).then(
      (menu) async {
        if (menu != null) {
          await viewModel.addMenu(menu);
        }
      },
    );
  }

  // [コールバック：メニューリストパネル長押し時]
  _deleteMenuTile(BuildContext context, Menu menu) async {
    final viewModel = Provider.of<MenuSettingViewModel>(context, listen: false);
    showDialog(
      context: context,
      builder: (_) => DeleteConfirmDialog(
        deleteValue: menu.name,
      ),
    ).then((flag) async {
      if (flag) {
        await viewModel.deleteMenu(menu);
        Toast.show('削除しました', context);
      }
    });
  }

  // [コールバック：FABタップ時]
  // ・カテゴリ編集画面へ遷移する
  _startMenuCategorySettingScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MenuCategorySettingScreen(),
        fullscreenDialog: true,
      ),
    );
  }
}
