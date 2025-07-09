import 'package:expense_tracker/common/custom_widget_component/custom_decoration.dart';
import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isNumber;
  final bool isOptional;
  const PrimaryTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint, 
    this.isNumber = false,
    this.isOptional = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme; 
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: CustomDecoration.getInputFieldDecoration(label: label, hint: hint, colorScheme: colorScheme),
      validator: (value) {
        if (isOptional) return null;
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        if (isNumber && double.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }
}
