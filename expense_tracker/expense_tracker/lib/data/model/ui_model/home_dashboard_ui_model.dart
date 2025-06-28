import 'dart:ui';

import 'package:expense_tracker/data/model/ui_model/wallet_ui_model.dart';
import 'package:flutter/material.dart';

class HomeDashboardUiModel {
  final double currentBalance;
  final double totalIncome;
  final double totalExpense;
  final List<WalletUiModel> walletModelList;
  final List<ExpenseCategoryUiModel> expenseCategoryModelList;

  HomeDashboardUiModel(
    this.currentBalance,
    this.totalIncome,
    this.totalExpense,
    this.walletModelList,
    this.expenseCategoryModelList,
  );

  HomeDashboardUiModel.empty()
      : currentBalance = 0.0,
        totalIncome = 0.0,
        totalExpense = 0.0,
        walletModelList = const [],
        expenseCategoryModelList = const [];
}

class ExpenseCategoryUiModel {
  final int categoryId;
  final String categoryName;
  final double categoryPercentage;
  final Color categoryColor;

  ExpenseCategoryUiModel(
    this.categoryId,
    this.categoryName,
    this.categoryPercentage,
    this.categoryColor,
  );
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