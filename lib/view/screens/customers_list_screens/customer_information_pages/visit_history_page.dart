import 'package:customermanagementapp/data/data_classes/visit_histories_by_customer.dart';
import 'package:customermanagementapp/data/data_classes/visit_history_list_preferences.dart';
import 'package:customermanagementapp/data/data_classes/visit_history_narrow_data.dart';
import 'package:customermanagementapp/data/data_classes/visit_history_sort_data.dart';
import 'package:customermanagementapp/data/list_search_state/visit_history_sort_state.dart';
import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';
import 'package:customermanagementapp/view/components/dialogs/visit_history_narrow_set_dialog.dart';
import 'package:customermanagementapp/view/components/list_items/visit_history_list_item.dart';
import 'package:customermanagementapp/view/components/buttons/on_off_switch_button.dart';
import 'package:customermanagementapp/view/components/search_bar.dart';
import 'package:customermanagementapp/view/components/search_bar_items/sort_dropdown_menu.dart';
import 'package:customermanagementapp/view/screens/visit_history_screens/visit_history_edit_screen.dart';
import 'package:flutter/material.dart';

class VisitHistoryPage extends StatefulWidget {
  VisitHistoryPage({this.vhbc});

  final VisitHistoriesByCustomer vhbc;

  @override
  _VisitHistoryPageState createState() => _VisitHistoryPageState();
}

class _VisitHistoryPageState extends State<VisitHistoryPage> {
  List<VisitHistory> _visitHistories = List();
  VisitHistoryListPreferences _vhPref = VisitHistoryListPreferences();
  String _selectedSortValue =
      visitHistorySortStateMap[VisitHistorySortState.REGISTER_DATE];

  bool setStateFlag = false;

  @override
  void initState() {
    if (widget.vhbc != null) {
      _visitHistories = widget.vhbc.histories;
      _vhPref = VisitHistoryListPreferences(
        narrowData: VisitHistoryNarrowData(),
        sortData: VisitHistorySortData(),
        searchCustomerName: '',
      );
      _selectedSortValue =
          visitHistorySortStateMap[VisitHistorySortState.REGISTER_DATE];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (setStateFlag) setStateFlag = false;
    });
    if (!setStateFlag) {
      _visitHistories = widget.vhbc.histories;
      _visitHistories.applyNarrowData(_vhPref.narrowData);
      _visitHistories.applySortData(_vhPref.sortData);
    }
    return Column(
      children: <Widget>[
        SearchBar(
          numberOfItems: _visitHistories.length,
          narrowSetButton: OnOffSwitchButton(
            value: '絞り込み',
            isSetAnyNarrowData: _vhPref.narrowData.isSetAny(),
            onTap: () => _showNarrowSetDialog(context),
          ),
          sortSetButton: SortDropDownMenu(
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
        setStateFlag = true;
        _vhPref.narrowData = narrowData;
        _visitHistories = List.from(widget.vhbc.histories)
          ..applyNarrowData(_vhPref.narrowData);
      });
    });
  }

  _setSortState(String value) {
    final sortState = visitHistorySortStateMap.getKeyFromValue(value);

    setState(() {
      setStateFlag = true;
      _vhPref.sortData.sortState = sortState;
      _visitHistories.applySortData(_vhPref.sortData);
      _selectedSortValue = visitHistorySortStateMap[_vhPref.sortData.sortState];
    });
  }
}
