import 'package:flutter/material.dart';

extension ConvertFromStringList on List<String> {
  // [変換：文字列とランダム色のDataMapを取得]
  Map<String, Color> getColorDataMap() {
    final dataMap = Map<String, Color>();

    if (this.toSet().toList() == this) {
      final removedList = this.toSet().toList();
      final dup = this.where((value) => !removedList.contains(value)).toList();

      throw Exception('重複があります: $dup');
    }

    if (this.isNotEmpty) {
      this.forEach((str) {
        //TODO ランダムカラー取得処理
//        dataMap[str] =
      });
    }

    return dataMap;
  }
}
