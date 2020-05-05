import 'package:customermanagementapp/db/database.dart';
import 'package:customermanagementapp/view/components/polymorphism/input_widget.dart';
import 'package:flutter/material.dart';

class EmployeeSelectButton extends InputWidget {
  EmployeeSelectButton({
    @required this.selectedEmployee,
    @required this.employees,
    @required this.onChanged,
    this.isDisabled = false,
  });

  final Employee selectedEmployee;
  final List<Employee> employees;
  final ValueChanged<Employee> onChanged;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    if (isDisabled) {
      return Text(
        selectedEmployee?.name ?? '',
        style: TextStyle(fontSize: 16),
      );
    }
    return DropdownButton<Employee>(
      isDense: true,
      isExpanded: true,
      value: selectedEmployee,
      onChanged: onChanged,
      selectedItemBuilder: (context) {
        return employees.map<Widget>((employee) {
          return Text(employee.name);
        }).toList();
      },
      items: employees.map<DropdownMenuItem<Employee>>((employee) {
        return DropdownMenuItem(
          value: employee,
          child: Text(employee.name),
        );
      }).toList(),
    );
  }
}
