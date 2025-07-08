
import 'package:expense_tracker/data/database/realm_model.dart';
import 'package:flutter/material.dart';

class CategoryUiModel {
  final int categoryId;
  final String name;
  final String icon;
  final Color color;

  CategoryUiModel({
    required this.categoryId,
    required this.name,
    required this.icon,
    required this.color,
  });

  factory CategoryUiModel.fromEntity(CategoryEntity categoryEntity) {
    return CategoryUiModel(
      categoryId: categoryEntity.id,
      name: categoryEntity.name,
      icon: categoryEntity.icon,
      color: _getCategoryColor(categoryEntity.name),
    );
  }

  factory CategoryUiModel.getDefault() {
    return CategoryUiModel(
      categoryId: 0,
      name: 'Other',
      icon: Icons.pages.toString(),
      color: _getCategoryColor(""),
    );
  }
}

Color _getCategoryColor(String category) {
  switch (category) {
    case 'Food':
      return Colors.orange;
    case 'Transport':
      return Colors.blue;
    case 'Entertainment':
      return Colors.purple;
    case 'Shopping':
      return Colors.pink;
    default:
      return Colors.grey;
  }
}
