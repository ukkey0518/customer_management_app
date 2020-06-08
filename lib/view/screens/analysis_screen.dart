import 'package:customermanagementapp/data/enums/periodMode.dart';
import 'package:customermanagementapp/data/enums/screen_tag.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/dialogs/period_set_dialog.dart';
import 'package:customermanagementapp/view/components/drowers/my_drawer.dart';
import 'package:customermanagementapp/view/components/indicators/period_mode_indicator.dart';
import 'package:customermanagementapp/view/components/dividers/my_divider.dart';
import 'package:customermanagementapp/view/components/period_select_tile.dart';
import 'package:customermanagementapp/view/components/screen_components/analysis_screen_parts/sales_summary_parts/ssp_total_part.dart';
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

    if (viewModel.allVisitHistories.isEmpty) {
      Future(() {
        viewModel.getVisitHistories();
      });
    }

    return DefaultTabController(
      length: _tabs.length,
      child: Consumer<AnalysisViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('売上分析'),
              centerTitle: true,
              bottom: TabBar(tabs: _tabs),
            ),
            drawer: MyDrawer(currentScreen: ScreenTag.SCREEN_ANALYSIS),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(height: 8),
                              PeriodModeIndicator(mode: vm.periodMode),
                              SizedBox(height: 8),
                              PeriodSelectTile(
                                date: vm.date,
                                mode: vm.periodMode,
                                maxDate: vm.maxDate,
                                minDate: vm.minDate,
                                onBackTap: (mode) => _onBackTap(context, mode),
                                onForwardTap: (mode) =>
                                    _onForwardTap(context, mode),
                                onDateAreaTap: () => _onDateAreaTap(context),
                                forwardText: vm.forwardText,
                                backText: vm.backText,
                              ),
                              MyDivider(height: 16),
                              SSPTotalPart(vhList: vm.vhList),
                              MyDivider(height: 16),
                            ],
                          ),
                          Expanded(
                            child: SalesSummaryPage(
                              allVisitHistories: vm.allVisitHistories,
                              vhList: vm.vhList,
                              menuCategories: vm.menuCategories,
                            ),
                          ),
                        ],
                      ),
                      TransitionGraphPage(
                        allVisitHistories: vm.allVisitHistories,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _onForwardTap(BuildContext context, PeriodMode mode) async {
    final viewModel = Provider.of<AnalysisViewModel>(context, listen: false);

    final date = viewModel.date.increment(mode);
    if (date.isAfter(viewModel.maxDate)) {
      await viewModel.setDate(viewModel.maxDate);
    } else {
      await viewModel.setDate(date);
    }
  }

  _onBackTap(BuildContext context, PeriodMode mode) async {
    final viewModel = Provider.of<AnalysisViewModel>(context, listen: false);

    final date = viewModel.date.decrement(mode);
    if (date.isBefore(viewModel.minDate)) {
      await viewModel.setDate(viewModel.minDate);
    } else {
      await viewModel.setDate(date);
    }
  }

  _onDateAreaTap(BuildContext context) {
    final viewModel = Provider.of<AnalysisViewModel>(context, listen: false);

    showDialog(
      context: context,
      builder: (_) => PeriodSetDialog(
        mode: viewModel.periodMode,
        date: viewModel.date,
        minDate: viewModel.minDate,
        maxDate: viewModel.maxDate,
      ),
    ).then((pair) async {
      if (pair != null) {
        await viewModel.setDate(pair['date']);
        await viewModel.setPeriodMode(pair['mode']);
      }
    });
  }
}
