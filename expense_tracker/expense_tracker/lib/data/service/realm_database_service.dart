import 'package:expense_tracker/data/database/realm_model.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

abstract class RealmDatabaseService {
  // Mark: For Wallet
  Future<void> addWallet(WalletEntity wallet);
  Future<List<WalletEntity>> getAllSavedWallet();
  Future<void> updateWallet(
    int id, {
    required String? name,
    required double? balance,
    required int? walletTypeId,
    required String? colorCode,
  });
  Future<WalletEntity?> getWalletById(int walletId);
  Future<void> deleteWallet(int walletId);

  // MARK: For Transaction
  Future<void> addTransaction(TransactionEntity transaction);
  Future<List<TransactionEntity>> getAllSavedTransaction();
  Future<List<TransactionEntity>> getSavedTransactionFromWallet(int walletId);
  Future<void> updateTransaction(
    int id, {
    required String? title,
    required double? amount,
    required String? description,
    required DateTime? date,
    required int? categoryId,
    required int? walletId,
    required bool? isIncome,
  });
  Future<TransactionEntity?> getTransactionById(int transactionId);
  Future<void> deleteTransaction(int transactionId);

  // MARK: For Category
  Future<void> addCategory(CategoryEntity category);
  Future<List<CategoryEntity>> getAllSavedCategory();
  Future<List<CategoryEntity>> getAllExpenseCategory();
  Future<List<CategoryEntity>> getAllIncomeCategory();
  Future<void> updateCategory(
    int id, {
    required String? name,
    required String? icon,
    required String? colorCode,
  });
  Future<CategoryEntity?> getCategoryById(int categoryId);
  Future<void> deleteCategory(int categoryId);

  // MARK: For cleanup
  void dispose();
}

class RealmDatabaseServiceImpl extends RealmDatabaseService {
  static Realm? _realm;
  
  /// Get singleton Realm instance
  Future<Realm> _getRealm() async {
    if (_realm == null || _realm!.isClosed) {
      final config = Configuration.local(
        [
          WalletEntity.schema,
          TransactionEntity.schema,
          CategoryEntity.schema,
        ],
        schemaVersion: 1,
      );
      _realm = Realm(config);
    }
    return _realm!;
  }

  // MARK: Method For Wallet
  @override
  Future<void> addWallet(WalletEntity wallet) async {
    final realm = await _getRealm();
    try {
      realm.write(() {
        realm.add(wallet);
      });
    } catch (e) {
      debugPrint('Error saving to Realm: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteWallet(int walletId) async {
    final realm = await _getRealm();
    try {
      realm.write(() {
        final wallet = realm.find<WalletEntity>(walletId);
        if (wallet != null) {
          realm.delete(wallet);
        }
      });
    } catch (e) {
      debugPrint('Error deleting from Realm: $e');
      rethrow;
    }
  }

  @override
  Future<List<WalletEntity>> getAllSavedWallet() async {
    final realm = await _getRealm();
    try {
      return realm.all<WalletEntity>().toList();
    } catch (e) {
      debugPrint('Error fetching from Realm: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateWallet(
    int id, {
    String? name,
    double? balance,
    int? walletTypeId,
    String? colorCode,
  }) async {
    final realm = await _getRealm();
    try {
      realm.write(() {
        final wallet = realm.find<WalletEntity>(id);
        if (wallet != null) {
          wallet.name = name ?? wallet.name;
          wallet.balance = balance ?? wallet.balance;
          wallet.colorCode = colorCode ?? wallet.colorCode;
          wallet.walletTypeId = walletTypeId ?? wallet.walletTypeId;
        }
      });
    } catch (e) {
      debugPrint('Error updating to Realm: $e');
      rethrow;
    }
  }

  @override
  Future<WalletEntity?> getWalletById(int walletId) async {
    final realm = await _getRealm();
    try {
      return realm.find<WalletEntity>(walletId);
    } catch (e) {
      debugPrint('Error finding data from Realm: $e');
      rethrow;
    }
  }

  // MARK: Method For Transaction

  @override
  Future<void> addTransaction(TransactionEntity transaction) async {
    final realm = await _getRealm();
    try {
      realm.write(() {
        realm.add(transaction);
      });
    } catch (e) {
      debugPrint('Error adding data to Realm: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteTransaction(int transactionId) async {
    final realm = await _getRealm();
    try {
      realm.write(() {
        final transaction = realm.find<TransactionEntity>(transactionId);
        if (transaction != null) {
          realm.delete(transaction);
        }
      });
    } catch (e) {
      debugPrint('Error deleting data from Realm: $e');
      rethrow;
    }
  }

  @override
  Future<List<TransactionEntity>> getAllSavedTransaction() async {
    final realm = await _getRealm();
    try {
      return realm.all<TransactionEntity>().toList();
    } catch (e) {
      debugPrint('Error finding data from Realm: $e');
      rethrow;
    }
  }

  @override
  Future<List<TransactionEntity>> getSavedTransactionFromWallet(
    int walletId,
  ) async {
    final realm = await _getRealm();
    try {
      // Fixed query syntax - removed quotes around walletId since it's an int
      return realm.query<TransactionEntity>('walletId == $walletId').toList();
    } catch (e) {
      debugPrint('Error finding data from Realm: $e');
      rethrow;
    }
  }

  @override
  Future<TransactionEntity?> getTransactionById(int transactionId) async {
    final realm = await _getRealm();
    try {
      return realm.find<TransactionEntity>(transactionId);
    } catch (e) {
      debugPrint('Error finding data from Realm: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateTransaction(
    int id, {
    String? title,
    double? amount,
    String? description,
    DateTime? date,
    int? categoryId,
    int? walletId,
    bool? isIncome,
  }) async {
    final realm = await _getRealm();
    try {
      realm.write(() {
        final transaction = realm.find<TransactionEntity>(id);
        if (transaction != null) {
          transaction.title = title ?? transaction.title;
          transaction.amount = amount ?? transaction.amount;
          transaction.description = description ?? transaction.description;
          transaction.date = date ?? transaction.date;
          transaction.categoryId = categoryId ?? transaction.categoryId;
          transaction.walletId = walletId ?? transaction.walletId;
          transaction.isIncome = isIncome ?? transaction.isIncome;
        }
      });
    } catch (e) {
      debugPrint('Error updating data to Realm: $e');
      rethrow;
    }
  }

  // MARK: For Category

  @override
  Future<void> addCategory(CategoryEntity category) async {
    final realm = await _getRealm();
    try {
      realm.write(() {
        realm.add(category);
      });
    } catch (e) {
      debugPrint('Error adding data to Realm: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteCategory(int categoryId) async {
    final realm = await _getRealm();
    try {
      realm.write(() {
        final category = realm.find<CategoryEntity>(categoryId);
        if (category != null) {
          realm.delete(category);
        }
      });
    } catch (e) {
      debugPrint('Error deleting data from Realm: $e');
      rethrow;
    }
  }

  @override
  Future<List<CategoryEntity>> getAllSavedCategory() async {
    final realm = await _getRealm();
    try {
      return realm.all<CategoryEntity>().toList();
    } catch (e) {
      debugPrint('Error finding data from Realm: $e');
      rethrow;
    }
  }


  @override
  Future<List<CategoryEntity>> getAllExpenseCategory() async {
    final realm = await _getRealm();
    try {
      return realm.query<CategoryEntity>('isExpenseCategory == true').toList();
    } catch (e) {
      debugPrint('Error finding data from Realm: $e');
      rethrow;
    }
  }
  
  @override
  Future<List<CategoryEntity>> getAllIncomeCategory() async {
    final realm = await _getRealm();
    try {
      return realm.query<CategoryEntity>('isExpenseCategory == false').toList();
    } catch (e) {
      debugPrint('Error finding data from Realm: $e');
      rethrow;
    }
  }

  @override
  Future<CategoryEntity?> getCategoryById(int categoryId) async {
    final realm = await _getRealm();
    try {
      return realm.find<CategoryEntity>(categoryId);
    } catch (e) {
      debugPrint('Error finding data from Realm: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateCategory(
    int id, {
    required String? name,
    required String? icon,
    required String? colorCode,
  }) async {
    final realm = await _getRealm();
    try {
      realm.write(() {
        final category = realm.find<CategoryEntity>(id);
        if (category != null) {
          category.name = name ?? category.name;
          category.icon = icon ?? category.icon;
          category.colorCode = colorCode ?? category.colorCode;
        }
      });
    } catch (e) {
      debugPrint('Error updating data to Realm: $e');
      rethrow;
    }
  }

  // MARK: Cleanup method
  @override
  void dispose() {
    if (_realm != null && !_realm!.isClosed) {
      _realm!.close();
      _realm = null;
    }
  }
}