import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    @required this.customers,
    @required this.searchNameController,
    @required this.onChanged,
    @required this.narrowMenuPart,
    @required this.sortMenuPart,
  });

  final List<Customer> customers;
  final TextEditingController searchNameController;
  final ValueChanged<String> onChanged;
  final Widget narrowMenuPart;
  final Widget sortMenuPart;

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
                      text: '${customers.length}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                    TextSpan(text: '件'),
                  ],
                ),
              ),
              Expanded(child: narrowMenuPart),
              Expanded(child: sortMenuPart),
            ],
          ),
          TextField(
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
          ),
        ],
      ),
    );
  }
}

// [絞り込みドロップダウンメニュー]
class NarrowDropDownButton extends StatelessWidget {
  NarrowDropDownButton({this.items, this.selectedValue, this.onSelected});

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
