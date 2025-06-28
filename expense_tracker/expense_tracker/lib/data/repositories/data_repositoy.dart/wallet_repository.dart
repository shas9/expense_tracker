import 'package:expense_tracker/common/utilities/id_generator.dart';
import 'package:expense_tracker/data/database/realm_model.dart';
import 'package:expense_tracker/data/service/realm_database_service.dart';

abstract class WalletRepository {
  Future<WalletEntity> createWallet(
    String name,
    String type,
    double initialBalance,
    String colorCode,
  );
  Future<List<WalletEntity>> getAllWallets();
  Future<void> deleteWallet(int walletId);
  Future<void> updateWalletBalance(int walletId, double amount);
  Future<WalletEntity?> getWalletById(int walletId);
}

class WalletRepositoryImpl extends WalletRepository {
  final RealmDatabaseService realmDatabaseService;

  WalletRepositoryImpl({required this.realmDatabaseService});

  // Create a new wallet
  @override
  Future<WalletEntity> createWallet(
    String name,
    String type,
    double initialBalance,
    String colorCode,
  ) async {
    final wallet = WalletEntity(
      IdGenerator.generateId(),
      name,
      type,
      colorCode,
      initialBalance,
    );

    await realmDatabaseService.addWallet(wallet);
    return wallet;
  }

  // Get all wallets
  @override
  Future<List<WalletEntity>> getAllWallets() async {
    return await realmDatabaseService.getAllSavedWallet();
  }

  // Update wallet balance
  @override
  Future<void> updateWalletBalance(int walletId, double amount) async {
    final wallet = await getWalletById(walletId);
    if (wallet != null) {
      await realmDatabaseService.updateWallet(
        walletId,
        name: null,
        balance: wallet.balance + amount,
        type: null,
        colorCode: null,
      );
    }
  }

  // Delete a wallet
  @override
  Future<void> deleteWallet(int walletId) async {
    await realmDatabaseService.deleteWallet(walletId);
  }

  // Get wallet by ID as string
  @override
  Future<WalletEntity?> getWalletById(int walletId) async {
    return await realmDatabaseService.getWalletById(walletId);
  }
}
