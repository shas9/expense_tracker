import 'package:expense_tracker/data/database/realm_model.dart';
import 'package:realm/realm.dart';

class ExpenseRepository {
  final Realm realm;

  ExpenseRepository(this.realm);

  // Add an expense or income
  Expense addTransaction(
    String title, 
    double amount, 
    DateTime date, 
    String category, 
    String walletId,
    bool isIncome
  ) {
    final expense = Expense(
      ObjectId(),
      title,
      amount,
      date,
      category,
      walletId,
      isIncome
    );

    realm.write(() {
      realm.add(expense);
      
      // Update wallet balance
      final wallet = realm.query<Wallet>('id == $walletId').firstOrNull;
      if (wallet != null) {
        wallet.balance += (isIncome ? amount : -amount);
      }
    });

    return expense;
  }

  // Get expenses for a specific wallet
  List<Expense> getExpensesByWallet(String walletId) {
    return realm.query<Expense>('walletId == "$walletId"').toList();
  }

  // Get total income and expenses
  Map<String, double> getFinancialSummary(String walletId) {
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

  // Get expenses grouped by category
  Map<String, double> getExpensesByCategory(String walletId) {
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