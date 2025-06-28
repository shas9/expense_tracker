import 'package:expense_tracker/common/utilities/id_generator.dart';
import 'package:expense_tracker/data/database/realm_model.dart';
import 'package:expense_tracker/data/service/realm_database_service.dart';
import 'package:flutter/material.dart';

abstract class TransactionRepository {
  Future<TransactionEntity> addTransaction(
      String title,
      double amount,
      String description,
      DateTime date,
      String category,
      int walletId,
      bool isIncome);

  Future<List<TransactionEntity>> getExpensesByWallet(int walletId);
  Future<Map<String, double>> getFinancialSummary(int walletId);
  Future<Map<String, double>> getExpensesByCategory(int walletId);
  Future<Map<String, double>> getOverallFinancialSummary(List<WalletEntity> wallets);
}

class ExpenseRepositoryImpl extends TransactionRepository {
  final RealmDatabaseService realmDatabaseService;

  ExpenseRepositoryImpl({required this.realmDatabaseService});

  // Add an expense or income
  @override
  Future<TransactionEntity> addTransaction(
    String title,
    double amount,
    String description,
    DateTime date,
    String category,
    int walletId,
    bool isIncome,
  ) async {
    try {
      final expense = TransactionEntity(
        IdGenerator.generateId(),
        title,
        amount,
        description,
        date,
        category,
        walletId,
        isIncome,
      );

      await realmDatabaseService.addTransaction(expense);
      WalletEntity? wallet = await realmDatabaseService.getWalletById(walletId);

      if (wallet != null) {
        await realmDatabaseService.updateWallet(
          walletId,
          null,
          wallet.balance - amount,
        );
      }
      return expense;
    } catch (e) {
      debugPrint('Error adding transaction: $e');
      throw Exception('Failed to add transaction: $e');
    }
  }

  // Get expenses for a specific wallet
  @override
  Future<List<TransactionEntity>> getExpensesByWallet(int walletId) async {
    return await realmDatabaseService.getSavedTransactionFromWallet(walletId);
  }

  // Get total income and expenses
  @override
  Future<Map<String, double>> getFinancialSummary(int walletId) async {
    final expenses = await getExpensesByWallet(walletId);

    double totalIncome = expenses
        .where((e) => e.isIncome)
        .map((e) => e.amount)
        .fold(0, (a, b) => a + b);

    double totalExpenses = expenses
        .where((e) => !e.isIncome)
        .map((e) => e.amount)
        .fold(0, (a, b) => a + b);

    return {'income': totalIncome, 'expenses': totalExpenses};
  }

  // Get overall financial summary across all wallets
  @override
  Future<Map<String, double>> getOverallFinancialSummary(
      List<WalletEntity> wallets,) async {
    double totalIncome = 0;
    double totalExpenses = 0;
    final categorySummary = <String, double>{};

    for (var wallet in wallets) {
      final walletSummary = await getFinancialSummary(wallet.id);
      totalIncome += walletSummary['income'] ?? 0;
      totalExpenses += walletSummary['expenses'] ?? 0;

      final walletCategories = await getExpensesByCategory(wallet.id);
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
  Future<Map<String, double>> getExpensesByCategory(int walletId) async {
    List<TransactionEntity> expenses = await getExpensesByWallet(walletId);
    expenses = expenses.where((e) => !e.isIncome).toList();

    final categoryMap = <String, double>{};

    for (var expense in expenses) {
      categoryMap[expense.category] =
          (categoryMap[expense.category] ?? 0) + expense.amount;
    }

    return categoryMap;
  }
}
