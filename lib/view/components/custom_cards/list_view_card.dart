import 'package:flutter/material.dart';

abstract class ListViewCard<T> extends StatelessWidget {
  ListViewCard({
    @required this.item,
    @required this.onTap,
    @required this.onLongPress,
  });

  final T item;
  final ValueChanged<T> onTap;
  final ValueChanged<T> onLongPress;
}
