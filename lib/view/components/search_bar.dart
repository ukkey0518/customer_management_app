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
          Row(
            children: <Widget>[
              SearchResults(numOfResult: numberOfItems),
              SizedBox(width: 8),
              narrowMenu ?? Container(),
              Expanded(child: sortMenu ?? Container()),
            ],
          ),
          searchMenu ?? Container(),
        ],
      ),
    );
  }
}
