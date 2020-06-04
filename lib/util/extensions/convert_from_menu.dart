import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/util/extensions/extensions.dart';

extension ConvertFromMenu on Menu {
  String toPrintText({
    bool showId = false,
    bool showName = true,
    bool showCategory = false,
    bool showPrice = false,
  }) {
    final list = List();

    list.add(showId ? 'id: $id' : '');
    list.add(showName ? 'name: $name' : '');
    list.add(showCategory
        ? 'category: ${menuCategoryJson.toMenuCategory().toPrintText()}'
        : '');
    list.add(showPrice ? 'price: ${price.toPriceString()}' : '');

    list.removeWhere((value) => value == '');

    return list.join(', ');
  }
}
