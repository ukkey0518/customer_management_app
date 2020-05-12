import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/data/data_classes/visit_history_list_screen_preferences.dart';
import 'package:customermanagementapp/data/data_classes/visit_history_narrow_data.dart';
import 'package:customermanagementapp/data/drop_down_menu_items.dart';
import 'package:customermanagementapp/data/visit_history_sort_state.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/dialogs/visit_history_narrow_set_dialog.dart';
import 'package:customermanagementapp/view/components/list_items/visit_history_list_item.dart';
import 'package:customermanagementapp/view/components/narrow_switch_button.dart';
import 'package:customermanagementapp/view/components/search_bar.dart';
import 'package:customermanagementapp/view/screens/visit_history_screens/visit_history_edit_screen.dart';
import 'package:flutter/material.dart';

class VisitRecordPage extends StatefulWidget {
  VisitRecordPage({this.vhbc});

  final VisitHistoriesByCustomer vhbc;

  @override
  _VisitRecordPageState createState() => _VisitRecordPageState();
}

class _VisitRecordPageState extends State<VisitRecordPage> {
  List<VisitHistory> _visitHistories = List();
  VisitHistoryListScreenPreferences _vhPref =
      VisitHistoryListScreenPreferences();
  String _selectedSortValue =
      visitHistorySortStateMap[VisitHistorySortState.REGISTER_OLD];

  @override
  void initState() {
    print(widget.vhbc?.histories);
    if (widget.vhbc != null) {
      _visitHistories = widget.vhbc.histories;
      _vhPref = VisitHistoryListScreenPreferences(
        narrowData: VisitHistoryNarrowData(),
        sortState: VisitHistorySortState.REGISTER_OLD,
        searchCustomerName: '',
      );
      _selectedSortValue =
          visitHistorySortStateMap[VisitHistorySortState.REGISTER_OLD];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SearchBar(
          numberOfItems: _visitHistories.length,
          narrowMenu: NarrowSwitchButton(
            isSetAnyNarrowData: _vhPref.narrowData.isSetAny(),
            onPressed: () => _showNarrowSetDialog(context),
          ),
          sortMenu: SortDropDownMenu(
            items: visitHistorySortStateMap.values.toList(),
            selectedValue: _selectedSortValue,
            onSelected: (value) => _setSortState(value),
          ),
        ),
        Divider(),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return VisitHistoryListItem(
                visitHistory: _visitHistories[index],
                onTap: () => _editVisitHistory(context, _visitHistories[index]),
                onLongPress: null,
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: _visitHistories.length,
          ),
        ),
      ],
    );
  }

  _editVisitHistory(BuildContext context, VisitHistory visitHistory) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) =>
                VisitHistoryEditScreen(visitHistory: visitHistory),
          ),
        )
        .then((value) => setState(() {
              _visitHistories = widget.vhbc.histories;
            }));
  }

  _showNarrowSetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return VisitHistoryNarrowSetDialog(
          narrowData: _vhPref.narrowData,
        );
      },
    ).then((narrowData) {
      setState(() {
        _vhPref.narrowData = narrowData;
        _visitHistories = List.from(widget.vhbc.histories)
          ..applyNarrowData(_vhPref.narrowData);
        print(_vhPref);
      });
    });
  }

  _setSortState(String value) {
    final sortState = visitHistorySortStateMap.getKeyFromValue(value);

    setState(() {
      _vhPref.sortState = sortState;
      _visitHistories.applySortState(_vhPref.sortState);
      print(_vhPref);
    });
  }
}
