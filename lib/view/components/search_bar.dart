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
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: '検索結果：'),
                    TextSpan(
                      text: '$numberOfItems',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                    TextSpan(text: '件'),
                  ],
                ),
              ),
              SizedBox(width: 8),
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
  SearchMenu({this.controller, this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      controller: controller,
      decoration: InputDecoration(
        hintText: '名前で検索',
        prefixIcon: Icon(Icons.search),
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              controller.clear();
              onChanged('');
            },
          ),
        ),
      ),
      onChanged: (name) => onChanged(controller.text),
      onEditingComplete: () => onChanged(controller.text),
    );
  }
}
