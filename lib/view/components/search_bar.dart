import 'package:customermanagementapp/view/components/search_bar_items/search_results.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  SearchBar({
    @required this.numberOfItems,
    this.narrowMenu,
    this.sortMenu,
    this.searchMenu,
  });

  final int numberOfItems;
  final Widget narrowMenu;
  final Widget sortMenu;
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
                narrowMenu ?? Container(),
                sortMenu ?? Container(),
              ],
            ),
          ),
          searchMenu ?? Container(),
        ],
      ),
    );
  }
}
