import 'package:expense_tracker/common/utilities/id_generator.dart';
import 'package:expense_tracker/data/database/realm_model.dart';
import 'package:expense_tracker/data/model/data_model/transaction/transaction_category_data_model.dart';
import 'package:expense_tracker/data/model/data_model/transaction/transaction_summary_data_model.dart';
import 'package:expense_tracker/data/model/data_model/wallet/wallet_summary_data_model.dart';
import 'package:expense_tracker/data/service/realm_database_service.dart';
import 'package:flutter/material.dart';

abstract class TransactionRepository {
  Future<TransactionEntity> addTransaction(
    String title,
    double amount,
    String description,
    DateTime date,
    int categoryId,
    int walletId,
    bool isIncome,
  );

  Future<void> updateTransaction(
    int id, {
    required String? title,
    required double? amount,
    required String? description,
    required DateTime? date,
    required int categoryId,
    required int walletId,
    required bool? isIncome,
  });

  Future<List<TransactionEntity>> getTransactionsByWallet(int walletId);
  Future<WalletSummaryDataModel> getWalletSummary(WalletEntity wallet);
  Future<List<TransactionCategoryDataModel>> getTransactionsByCategory(
    int walletId,
  );
  Future<TransactionSummaryDataModel> getTransactionSummary(
    List<WalletEntity> wallets,
  );
}

class TransactionRepositoryImpl extends TransactionRepository {
  final RealmDatabaseService realmDatabaseService;

  TransactionRepositoryImpl({required this.realmDatabaseService});

  // Add an transaction or income
  @override
  Future<TransactionEntity> addTransaction(
    String title,
    double amount,
    String description,
    DateTime date,
    int categoryId,
    int walletId,
    bool isIncome,
  ) async {
    try {
      final transaction = TransactionEntity(
        IdGenerator.generateId(),
        title,
        amount,
        description,
        date,
        categoryId,
        walletId,
        isIncome,
      );

      await realmDatabaseService.addTransaction(transaction);
      WalletEntity? wallet = await realmDatabaseService.getWalletById(walletId);

      if (wallet != null) {
        await realmDatabaseService.updateWallet(
          walletId,
          name: null,
          balance: wallet.balance + ((isIncome == true) ? amount : -amount),
          type: null,
          colorCode: null,
        );
      }
      return transaction;
    } catch (e) {
      debugPrint('Error adding transaction: $e');
      throw Exception('Failed to add transaction: $e');
    }
  }

  // Get transactions for a specific wallet
  @override
  Future<List<TransactionEntity>> getTransactionsByWallet(int walletId) async {
    return await realmDatabaseService.getSavedTransactionFromWallet(walletId);
  }

  // Get total income and transactions
  @override
  Future<WalletSummaryDataModel> getWalletSummary(WalletEntity wallet) async {
    try {
      final transactions = await getTransactionsByWallet(wallet.id);

      double totalIncome = transactions
          .where((e) => e.isIncome)
          .map((e) => e.amount)
          .fold(0, (a, b) => a + b);

      double totalExpense = transactions
          .where((e) => !e.isIncome)
          .map((e) => e.amount)
          .fold(0, (a, b) => a + b);

      return WalletSummaryDataModel(
        walletId: wallet.id,
        currentBalance: wallet.balance,
        totalIncome: totalIncome,
        totalExpense: totalExpense,
      );
    } catch (e) {
      throw Exception('Failed to get wallet summary: $e');
    }
  }

  // Get overall financial summary across all wallets
  @override
  Future<TransactionSummaryDataModel> getTransactionSummary(
    List<WalletEntity> wallets,
  ) async {
    try {
double totalIncome = 0;
    double totalExpense = 0;
    double totalWalletBalance = 0;
    final categorySummary = <int, double>{};

    for (var wallet in wallets) {
      final walletSummary = await getWalletSummary(wallet);
      totalWalletBalance += walletSummary.currentBalance;
      totalIncome += walletSummary.totalIncome;
      totalExpense += walletSummary.totalExpense;

      final walletWiseCategories = await getTransactionsByCategory(wallet.id);
      for (var category in walletWiseCategories) {
        categorySummary[category.categoryId] =
            (categorySummary[category.categoryId] ?? 0) +
                category.categoryCostAmount;
      }
    }

    final overallWalletCategory = categorySummary.entries
        .map((entry) => TransactionCategoryDataModel(
              categoryId: entry.key,
              categoryCostAmount: entry.value,
            ))
        .toList();

    return TransactionSummaryDataModel(
      currentBalance: totalWalletBalance,
      totalIncome: totalIncome,
      totalExpense: totalExpense,
      transactionCategoryDataModel: overallWalletCategory,
    );
    } catch (e) {
      throw Exception('Failed to get wallet summary: $e');
    }
  }

  // Get transactions grouped by category
  @override
  Future<List<TransactionCategoryDataModel>> getTransactionsByCategory(
      int walletId) async {
    try {
      final transactions = (await getTransactionsByWallet(walletId))
          .where((transaction) => !transaction.isIncome)
          .toList();

      final categoryTotals = <int, double>{};

      for (final transaction in transactions) {
        categoryTotals.update(
          transaction.categoryId,
          (total) => total + transaction.amount,
          ifAbsent: () => transaction.amount,
        );
      }

      // Convert to data models
      return categoryTotals.entries
          .map((entry) => TransactionCategoryDataModel(
                categoryId: entry.key,
                categoryCostAmount: entry.value,
              ))
          .toList();
    } catch (e) {
      throw Exception('Failed to get transactions by category: $e');
    }
  }

  @override
  Future<void> updateTransaction(
    int id, {
    required String? title,
    required double? amount,
    required String? description,
    required DateTime? date,
    required int? categoryId,
    required int? walletId,
    required bool? isIncome,
  }) async {
    await realmDatabaseService.updateTransaction(id,
        title: title,
        amount: amount,
        description: description,
        date: date,
        categoryId: categoryId,
        walletId: walletId,
        isIncome: isIncome);
  }
}
