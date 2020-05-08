import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/dialogs/employee_edit_dialog.dart';
import 'package:customermanagementapp/view/components/list_items/employee_list_item.dart';
import 'package:customermanagementapp/viewmodel/employee_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class EmployeeSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EmployeeViewModel>(context, listen: false);

    Future(
      () => viewModel.getEmployees(),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('スタッフ管理'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showEditEmployeeDialog(context),
      ),
      body: Consumer<EmployeeViewModel>(
        builder: (context, viewModel, child) {
          return viewModel.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: viewModel.employees.length,
                  itemBuilder: (context, index) {
                    return EmployeeListItem(
                      employee: viewModel.employees[index],
                      onTap: (employee) =>
                          _showEditEmployeeDialog(context, employee),
                      onLongPress: (employee) =>
                          _deleteEmployee(context, employee),
                    );
                  },
                );
        },
      ),
    );
  }

// [コールバック：FAB・リストアイテムタップ時]
  _showEditEmployeeDialog(BuildContext context, [Employee employee]) {
    var viewModel = Provider.of<EmployeeViewModel>(context, listen: false);

    showDialog(
      context: context,
      builder: (_) => EmployeeEditDialog(employee: employee),
    ).then(
      (employee) async {
        if (employee != null) {
          await viewModel.addEmployee(employee);
        }
      },
    );
  }

// [コールバック：リストアイテム長押し時]
// ・従業員データを削除する
  _deleteEmployee(BuildContext context, Employee employee) async {
    var viewModel = Provider.of<EmployeeViewModel>(context, listen: false);
    await viewModel.deleteEmployee(employee);
    Toast.show('削除しました。', context);
  }
}
