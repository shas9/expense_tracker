import 'package:expense_tracker/common/utilities/parser.dart';
import 'package:expense_tracker/data/database/realm_model.dart';
import 'package:flutter/material.dart';

class CategoryUiModel {
  final int categoryId;
  final String name;
  final String icon;
  final Color color;
  final bool isExpenseCategory;

  CategoryUiModel({
    required this.categoryId,
    required this.name,
    required this.icon,
    required this.color,
    required this.isExpenseCategory
  });

  factory CategoryUiModel.fromEntity(CategoryEntity categoryEntity) {
    return CategoryUiModel(
      categoryId: categoryEntity.id,
      name: categoryEntity.name,
      icon: categoryEntity.icon,
      color: Parser.hexStringToColor(
        categoryEntity.colorCode,
      ),
      isExpenseCategory: categoryEntity.isExpenseCategory,
    );
  }

  factory CategoryUiModel.getDefault() {
    return CategoryUiModel(
      categoryId: 0,
      name: 'Other',
      icon: Icons.pages.toString(),
      color: Colors.grey,
      isExpenseCategory: true,
    );
  }
}
