import 'package:customermanagementapp/view/components/my_drawer.dart';
import 'package:customermanagementapp/view/screens/analysis_pages/sales_summary_page.dart';
import 'package:customermanagementapp/view/screens/analysis_pages/transition_graph_page.dart';
import 'package:customermanagementapp/viewmodel/analysis_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnalysisScreen extends StatelessWidget {
  final _tabs = <Tab>[
    Tab(text: '売上集計', icon: Icon(Icons.description)),
    Tab(text: '推移グラフ', icon: Icon(Icons.timeline)),
  ];

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AnalysisViewModel>(context, listen: false);

    Future(() {
      viewModel.getVisitHistories();
    });

    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('売上分析'),
          centerTitle: true,
          bottom: TabBar(tabs: _tabs),
        ),
        drawer: MyDrawer(),
        body: Consumer<AnalysisViewModel>(
          builder: (context, vm, child) {
            return TabBarView(
              children: <Widget>[
                SalesSummaryPage(
                  visitHistories: vm.visitHistories,
                ),
                TransitionGraphPage(
                  visitHistories: vm.visitHistories,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
