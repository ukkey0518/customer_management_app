import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  SearchBar({
    @required this.numberOfCustomers,
    this.narrowMenu,
    this.sortMenu,
    this.searchMenu,
  });

  final int numberOfCustomers;
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
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: '検索結果：'),
                    TextSpan(
                      text: '$numberOfCustomers',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                    TextSpan(text: '件'),
                  ],
                ),
              ),
              Expanded(child: narrowMenu ?? Container()),
              Expanded(child: sortMenu ?? Container()),
            ],
          ),
          searchMenu ?? Container(),
        ],
      ),
    );
  }
}

// [絞り込みドロップダウンメニュー]
class NarrowDropDownMenu extends StatelessWidget {
  NarrowDropDownMenu({this.items, this.selectedValue, this.onSelected});

  final List<String> items;
  final String selectedValue;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: DropdownButton(
          value: selectedValue,
          icon: Icon(Icons.arrow_drop_down),
          onChanged: onSelected,
          style: TextStyle(fontSize: 14, color: Colors.black),
          items: items.map<DropdownMenuItem<String>>(
            (value) {
              return DropdownMenuItem<String>(
                value: value,
                child: SizedBox(
                  width: 80,
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

// [ソートドロップダウンメニュー]
class SortDropDownMenu extends StatelessWidget {
  SortDropDownMenu({this.items, this.selectedValue, this.onSelected});

  final List<String> items;
  final String selectedValue;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: DropdownButton(
          value: selectedValue,
          icon: Icon(Icons.arrow_drop_down),
          onChanged: onSelected,
          style: TextStyle(fontSize: 14, color: Colors.black),
          items: items.map<DropdownMenuItem<String>>(
            (value) {
              return DropdownMenuItem<String>(
                value: value,
                child: SizedBox(
                  width: 80,
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

// [検索欄]
class SearchMenu extends StatelessWidget {
  SearchMenu({this.searchNameController, this.onChanged});

  final TextEditingController searchNameController;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      controller: searchNameController,
      decoration: InputDecoration(
        hintText: '名前で検索',
        prefixIcon: Icon(Icons.search),
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => WidgetsBinding.instance.addPostFrameCallback(
            (_) => searchNameController.clear(),
          ),
        ),
      ),
      onChanged: onChanged,
      onEditingComplete: () => onChanged(searchNameController.text),
    );
  }
}