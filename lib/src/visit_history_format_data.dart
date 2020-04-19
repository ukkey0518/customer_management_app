import 'package:customermanagementapp/db/database.dart';
import 'package:flutter/material.dart';

class VisitHistoryFormatData {
  int id;
  String dateStr;
  Customer customer;
  Employee employee;
  Map<Menu, Color> menuAndCategoryColors;
  String priceStr;

  VisitHistoryFormatData({
    @required this.id,
    @required this.dateStr,
    @required this.customer,
    @required this.employee,
    @required this.menuAndCategoryColors,
    @required this.priceStr,
  });
}
