import 'package:flutter/material.dart';

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
