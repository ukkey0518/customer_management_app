import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/menu_expansion_panel_list.dart';
import 'package:customermanagementapp/view/components/selected_menu_list.dart';
import 'package:customermanagementapp/viewmodel/menu_select_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class MenuSelectScreen extends StatelessWidget {
  MenuSelectScreen({this.selectedMenus});

  final List<Menu> selectedMenus;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MenuSelectViewModel>(context, listen: false);

    Future(() {
      viewModel.getMBCList(selectedMenus);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('メニューの選択'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => _saveMenuListsAndFinish(context),
          ),
        ],
      ),
      body: Consumer<MenuSelectViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: SelectedMenuList(
                  selectedMenus: viewModel.selectedMenus,
                  onItemTap: (menu) => _onItemSelect(context, menu),
                ),
              ),
              SizedBox(height: 30),
              Expanded(
                flex: 7,
                child: SingleChildScrollView(
                  child: Container(
                    child: MenuExpansionPanelList(
                      menuByCategories: viewModel.mbcList,
                      expansionCallback: (index, isExpanded) =>
                          _setExpanded(context, index, isExpanded),
                      onItemPanelTap: (_, menu) => _onItemSelect(context, menu),
                      onItemPanelLongPress: null,
                      onAddPanelTap: null,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // [コールバック：メニューリストパネルタップ時]
  _onItemSelect(BuildContext context, Menu menu) async {
    final viewModel = Provider.of<MenuSelectViewModel>(context, listen: false);

    await viewModel.setMenu(menu);

    Toast.show(viewModel.whenSetMessage, context);
  }

  _setExpanded(BuildContext context, int index, bool isExpanded) async {
    final viewModel = Provider.of<MenuSelectViewModel>(context, listen: false);

    await viewModel.setExpanded(index, !isExpanded);
  }

  // [コールバック：保存ボタンタップ時]
  _saveMenuListsAndFinish(BuildContext context) {
    final viewModel = Provider.of<MenuSelectViewModel>(context, listen: false);

    Navigator.of(context).pop(viewModel.selectedMenus);
  }
}
