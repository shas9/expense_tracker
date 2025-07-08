import 'package:flutter/material.dart';

class CustomDecoration {
  static InputDecoration getInputFieldDecoration({
    required String label,
    required String hint,
    required ColorScheme colorScheme,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: colorScheme.surface,
      prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}