import 'package:customermanagementapp/data/enums/list_sort_order.dart';
import 'package:customermanagementapp/view/components/search_bar_items/search_results.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  SearchBar({
    @required this.numberOfItems,
    this.narrowSetButton,
    this.sortSetButton,
    this.orderSwitchButton,
    this.searchMenu,
  });

  final int numberOfItems;
  final Widget narrowSetButton;
  final Widget sortSetButton;
  final Widget orderSwitchButton;
  final Widget searchMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SearchResults(numOfResult: numberOfItems),
                narrowSetButton ?? Container(),
                Row(
                  children: <Widget>[
                    sortSetButton ?? Container(),
                    orderSwitchButton ?? Container(),
                  ],
                ),
              ],
            ),
          ),
          searchMenu ?? Container(),
        ],
      ),
    );
  }
}

class ListSortOrderSwitchButton extends StatelessWidget {
  ListSortOrderSwitchButton({
    @required this.selectedOrder,
    @required this.onUpButtonTap,
    @required this.onDownButtonTap,
  });

  final ListSortOrder selectedOrder;
  final VoidCallback onUpButtonTap;
  final VoidCallback onDownButtonTap;

  @override
  Widget build(BuildContext context) {
    var upButtonColor;
    var downButtonColor;

    if (selectedOrder == ListSortOrder.ASCENDING_ORDER) {
      upButtonColor = Theme.of(context).primaryColor;
      downButtonColor = Colors.grey;
    } else {
      upButtonColor = Colors.grey;
      downButtonColor = Theme.of(context).primaryColor;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          ' ',
          style: TextStyle(
            color: Theme.of(context).textSelectionHandleColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: Icon(Icons.keyboard_arrow_up, color: upButtonColor),
              onTap: onUpButtonTap,
            ),
            InkWell(
              child: Icon(Icons.keyboard_arrow_down, color: downButtonColor),
              onTap: onDownButtonTap,
            ),
          ],
        ),
      ],
    );
  }
}
