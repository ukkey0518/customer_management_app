import 'package:customermanagementapp/view/components/polymorphism/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

class SingleItemSelectPicker extends InputWidget {
  SingleItemSelectPicker({
    @required this.items,
    @required this.selectedItem,
    @required this.onConfirm,
    this.isClearable = false,
    this.paddingHorizontal = 8,
    this.paddingVertical = 8,
  });

  final List<String> items;
  final String selectedItem;
  final ValueChanged<String> onConfirm;
  final bool isClearable;
  final double paddingVertical;
  final double paddingHorizontal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () => _showItemSelectPicker(context),
          onLongPress: isClearable ? () => onConfirm(null) : null,
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
                horizontal: paddingHorizontal, vertical: paddingVertical),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    selectedItem == null ? '未設定' : selectedItem,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _showItemSelectPicker(BuildContext context) {
    print('ak47');
    Picker(
      adapter: PickerDataAdapter<String>(pickerdata: items),
      changeToFirst: true,
      textAlign: TextAlign.center,
      selecteds: [items.indexOf(selectedItem)],
      columnPadding: const EdgeInsets.all(8.0),
      confirmText: '決定',
      confirmTextStyle: TextStyle(
        fontSize: 16,
        color: Theme.of(context).primaryColor,
      ),
      cancelText: 'キャンセル',
      cancelTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
      onConfirm: (Picker picker, List value) =>
          onConfirm(picker.getSelectedValues().single.toString()),
    ).showModal(context);
  }
}
