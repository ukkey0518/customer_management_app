import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/dialogs/visit_reason_edit_dialog.dart';
import 'package:customermanagementapp/view/components/list_items/visit_reason_list_item.dart';
import 'package:customermanagementapp/viewmodel/visit_reason_setting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class VisitReasonSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<VisitReasonSettingViewModel>(context, listen: false);

    Future(
      () => viewModel.getVisitReasons(),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('スタッフ管理'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showEditVisitReasonDialog(context),
      ),
      body: Consumer<VisitReasonSettingViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            itemCount: viewModel.visitReasons.length,
            itemBuilder: (context, index) {
              return VisitReasonListItem(
                visitReason: viewModel.visitReasons[index],
                onTap: (visitReason) =>
                    _showEditVisitReasonDialog(context, visitReason),
                onLongPress: (visitReason) =>
                    _deleteVisitReason(context, visitReason),
              );
            },
          );
        },
      ),
    );
  }

  _showEditVisitReasonDialog(BuildContext context, [VisitReason visitReason]) {
    var viewModel =
        Provider.of<VisitReasonSettingViewModel>(context, listen: false);

    showDialog(
      context: context,
      builder: (_) => VisitReasonEditDialog(visitReason: visitReason),
    ).then(
      (visitReason) async {
        if (visitReason != null) {
          await viewModel.addVisitReason(visitReason);
        }
      },
    );
  }

  _deleteVisitReason(BuildContext context, VisitReason visitReason) async {
    var viewModel =
        Provider.of<VisitReasonSettingViewModel>(context, listen: false);
    await viewModel.deleteVisitReasons(visitReason);
    Toast.show('削除しました。', context);
  }
}
