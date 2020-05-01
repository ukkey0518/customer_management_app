import 'package:flutter/material.dart';

abstract class BasicListViewItem<T> extends StatelessWidget {
  BasicListViewItem({
    @required this.item,
    @required this.onTap,
    @required this.onLongPress,
  });

  final T item;
  final ValueChanged<T> onTap;
  final ValueChanged<T> onLongPress;
}
