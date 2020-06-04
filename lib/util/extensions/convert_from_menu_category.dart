import 'package:customermanagementapp/db/database.dart';

extension ConvertFromMenuCategory on MenuCategory {
  // [変換：出力用文字列を取得]
  String toPrintText({
    bool showId = false,
    bool showName = true,
    bool showColor = false,
  }) {
    final list = List();

    list.add(showId ? 'id: $id' : '');
    list.add(showName ? 'name: $name' : '');
    list.add(showColor ? 'color: $color' : '');

    list.removeWhere((value) => value == '');

    return 'MenuCategory{${list.join(', ')}}';
  }
}
