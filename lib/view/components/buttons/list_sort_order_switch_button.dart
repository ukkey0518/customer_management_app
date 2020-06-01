import 'package:customermanagementapp/data/enums/list_sort_order.dart';
import 'package:flutter/material.dart';

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
