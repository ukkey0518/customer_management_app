import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';

extension ConvertFromMenuCategoryList on List<MenuCategory> {
  // [変換：出力用文字列を取得]
  String toPrintText({
    bool onlyLength = false,
    bool showId = false,
    bool showName = true,
    bool showColor = false,
  }) {
    var str;

    if (onlyLength) {
      str = 'length: ${this.length}';
    } else {
      str = List<MenuCategory>.from(this).map<String>(
        (mc) {
          return mc.toPrintText(
            showId: showId,
            showName: showName,
            showColor: showColor,
          );
        },
      ).join(', ');
    }

    return 'MenuCategoryList{$str}';
  }
}
