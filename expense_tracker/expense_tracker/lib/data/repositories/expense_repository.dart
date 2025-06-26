import 'package:expense_tracker/common/utilities/id_generator.dart';
import 'package:expense_tracker/data/database/realm_model.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

abstract class ExpenseRepository {
  Expense addTransaction(
    String title, 
    double amount, 
    String description,
    DateTime date, 
    String category, 
    int walletId,
    bool isIncome
  );

  List<Expense> getExpensesByWallet(int walletId);
  Map<String, double> getFinancialSummary(int walletId);
  Map<String, double> getExpensesByCategory(int walletId);
  Map<String, double> getOverallFinancialSummary(List<Wallet> wallets);
}

class ExpenseRepositoryImpl extends ExpenseRepository {
  final Realm realm;

  ExpenseRepositoryImpl({
    required this.realm
  });

  // Add an expense or income
  @override
  Expense addTransaction(
    String title, 
    double amount, 
    String description, 
    DateTime date,
    String category, 
    int walletId,
    bool isIncome,
  ) {
    try {
      final expense = Expense(
        IdGenerator.generateId(),
        title,
        amount,
        description,
        date,
        category,
        walletId,
        isIncome
      );

      realm.write(() {
          realm.add(expense);
          
          final wallet = realm.query<Wallet>('id == \$0', [walletId]).firstOrNull;
          if (wallet != null) {
              wallet.balance += (isIncome ? amount : -amount);
          }
      });

    return expense;
    } catch (e) {
      debugPrint('Error adding transaction: $e');
      throw Exception('Failed to add transaction: $e');
    }
  }

  // Get expenses for a specific wallet
  @override
  List<Expense> getExpensesByWallet(int walletId) {
    return realm.query<Expense>('walletId == "$walletId"').toList();
  }

  // Get total income and expenses
  @override
  Map<String, double> getFinancialSummary(int walletId) {
    final expenses = getExpensesByWallet(walletId);
    
    double totalIncome = expenses
      .where((e) => e.isIncome)
      .map((e) => e.amount)
      .fold(0, (a, b) => a + b);
    
    double totalExpenses = expenses
      .where((e) => !e.isIncome)
      .map((e) => e.amount)
      .fold(0, (a, b) => a + b);

    return {
      'income': totalIncome,
      'expenses': totalExpenses
    };
  }

  // Get overall financial summary across all wallets
@override
  Map<String, double> getOverallFinancialSummary(List<Wallet> wallets) {
  double totalIncome = 0;
  double totalExpenses = 0;
  final categorySummary = <String, double>{};

  for (var wallet in wallets) {
    final walletSummary = getFinancialSummary(wallet.id);
    totalIncome += walletSummary['income'] ?? 0;
    totalExpenses += walletSummary['expenses'] ?? 0;

    final walletCategories = getExpensesByCategory(wallet.id);
    for (var category in walletCategories.keys) {
      categorySummary[category] = 
        (categorySummary[category] ?? 0) + walletCategories[category]!;
    }
  }

  return {
    'income': totalIncome,
    'expenses': totalExpenses,
    ...categorySummary,
  };
}


  // Get expenses grouped by category
  @override
  Map<String, double> getExpensesByCategory(int walletId) {
    final expenses = getExpensesByWallet(walletId)
      .where((e) => !e.isIncome)
      .toList();
    
    final categoryMap = <String, double>{};
    
    for (var expense in expenses) {
      categoryMap[expense.category] = 
        (categoryMap[expense.category] ?? 0) + expense.amount;
    }

    return categoryMap;
  }
}