import 'package:expense_tracker/data/database/realm_model.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

abstract class RealmDatabaseService {
  // Mark: For Wallet
  Future<void> addWallet(WalletEntity wallet);
  Future<List<WalletEntity>> getAllSavedWallet();
  Future<void> updateWallet(
    int id,
    String? name,
    double? balance,
  );
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
    required String? category,
    required int? walletId,
    required bool? isIncome,
  });
  Future<TransactionEntity?> getTransactionById(int transactionId);
  Future<void> deleteTransaction(int transactionId);
}

class RealmDatabaseServiceImpl extends RealmDatabaseService {
  // MARK: Method For Wallet
  @override
  Future<void> addWallet(WalletEntity wallet) async {
    final realm = await _openRealm();
    try {
      realm.write(() {
        realm.add(wallet);
      });
    } catch (e) {
      debugPrint('Error saving to Realm: $e');
      rethrow;
    } finally {
      realm.close();
    }
  }

  @override
  Future<void> deleteWallet(int walletId) async {
    final realm = await _openRealm();
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
    } finally {
      realm.close();
    }
  }

  @override
  Future<List<WalletEntity>> getAllSavedWallet() async {
    final realm = await _openRealm();
    try {
      return realm.all<WalletEntity>().toList();
    } catch (e) {
      debugPrint('Error fetching from Realm: $e');
      rethrow;
    } finally {
      realm.close();
    }
  }

  @override
  Future<void> updateWallet(
    int id,
    String? name,
    double? balance,
  ) async {
    final realm = await _openRealm();
    try {
      realm.write(() {
        final wallet = realm.find<WalletEntity>(id);
        if (wallet != null) {
          wallet.name = name ?? wallet.name;
          wallet.balance = balance ?? wallet.balance;
        }
      });
    } catch (e) {
      debugPrint('Error updating to Realm: $e');
      rethrow;
    } finally {
      realm.close();
    }
  }

  @override
  Future<WalletEntity?> getWalletById(int walletId) async {
    final realm = await _openRealm();
    try {
      return realm.find<WalletEntity>(walletId);
    } catch (e) {
      debugPrint('Error finding data from Realm: $e');
      rethrow;
    } finally {
      realm.close();
    }
  }

  // MARK: Method For Transaction

  @override
  Future<void> addTransaction(TransactionEntity transaction) async {
    final realm = await _openRealm();
    try {
      realm.write(() {
        realm.add(transaction);
      });
    } catch (e) {
      debugPrint('Error adding data to Realm: $e');
      rethrow;
    } finally {
      realm.close();
    }
  }

  @override
  Future<void> deleteTransaction(int transactionId) async {
    final realm = await _openRealm();
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
    } finally {
      realm.close();
    }
  }

  @override
  Future<List<TransactionEntity>> getAllSavedTransaction() async {
    final realm = await _openRealm();
    try {
      return realm.all<TransactionEntity>().toList();
    } catch (e) {
      debugPrint('Error finding data from Realm: $e');
      rethrow;
    } finally {
      realm.close();
    }
  }

  @override
  Future<List<TransactionEntity>> getSavedTransactionFromWallet(int walletId) async {
    final realm = await _openRealm();
    try {
      return realm.query<TransactionEntity>('walletId == "$walletId"').toList();
    } catch (e) {
      debugPrint('Error finding data from Realm: $e');
      rethrow;
    } finally {
      realm.close();
    }
  }

  @override
  Future<TransactionEntity?> getTransactionById(int transactionId) async {
    final realm = await _openRealm();
    try {
      return realm.find<TransactionEntity>(transactionId);
    } catch (e) {
      debugPrint('Error finding data from Realm: $e');
      rethrow;
    } finally {
      realm.close();
    }
  }

  @override
  Future<void> updateTransaction(
    int id, {
    String? title,
    double? amount,
    String? description,
    DateTime? date,
    String? category,
    int? walletId,
    bool? isIncome,
  }) async {
    final realm = await _openRealm();
    try {
      realm.write(() {
        final transaction = realm.find<TransactionEntity>(id);
        if (transaction != null) {
          transaction.title = title ?? transaction.title;
          transaction.amount = amount ?? transaction.amount;
          transaction.description = description ?? transaction.description;
          transaction.date = date ?? transaction.date;
          transaction.category = category ?? transaction.category;
          transaction.walletId = walletId ?? transaction.walletId;
          transaction.isIncome = isIncome ?? transaction.isIncome;
        }
      });
    } catch (e) {
      debugPrint('Error updating data to Realm: $e');
      rethrow;
    } finally {
      realm.close();
    }
  }

  Future<Realm> _openRealm() async {
    final config = Configuration.local(
      [
        WalletEntity.schema,
        TransactionEntity.schema,
        CategoryEntity.schema,
      ],
      schemaVersion: 1,
    );

    return await Realm.open(config);
  }
}
