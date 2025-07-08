// custom_date_picker.dart
import 'package:flutter/material.dart';

class CustomDatePicker {
  static Future<DateTime?> show({
    required BuildContext context,
    DateTime? initialDateTime,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final DateTime initialDate = initialDateTime ?? DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime.now(),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDateTime ?? DateTime.now()),
      );

      if (pickedTime != null) {
        return DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }
    return null;
  }
}
