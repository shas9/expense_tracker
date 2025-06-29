import 'package:flutter/material.dart';

class PrimaryDropdownWidget extends StatelessWidget {
  final String selectedDropdownType;
  final List<String> itemList;
  final ValueChanged<String?> onValueChanged;

  const PrimaryDropdownWidget({
    super.key,
    required this.selectedDropdownType,
    required this.itemList,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedDropdownType,
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down, color: colorScheme.onSurface),
          dropdownColor: colorScheme.surface,
          items: itemList
              .map(
                (type) => DropdownMenuItem(
                  value: type,
                  child: Text(
                    type,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: onValueChanged,
        ),
      ),
    );
  }
}
