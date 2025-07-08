import 'package:expense_tracker/common/utilities/id_generator.dart';
import 'package:expense_tracker/data/database/realm_model.dart';
import 'package:expense_tracker/data/model/ui_model/common/wallet_type_ui_model.dart';
import 'package:expense_tracker/data/repositories/main_repository.dart';
import 'package:expense_tracker/data/service/realm_database_service.dart';

abstract class WalletRepository {
  Future<WalletEntity> createWallet(
    String name,
    int walletTypeId,
    double initialBalance,
    String colorCode,
  );
  Future<List<WalletEntity>> getAllWallets();
  List<WalletTypeUiModel> getAllWalletType();
  Future<void> deleteWallet(int walletId);
  Future<void> updateWalletBalance(int walletId, double amount);
  Future<WalletEntity?> getWalletById(int walletId);
  WalletTypeUiModel? getWalletTypeById(int walletTypeId);
}

class WalletRepositoryImpl extends WalletRepository {
  final RealmDatabaseService realmDatabaseService;
  final MainRepository mainRepository;

  WalletRepositoryImpl({
    required this.realmDatabaseService,
    required this.mainRepository,
  });

  // Create a new wallet
  @override
  Future<WalletEntity> createWallet(
    String name,
    int walletTypeId,
    double initialBalance,
    String colorCode,
  ) async {
    final wallet = WalletEntity(
      IdGenerator.generateId(),
      name,
      walletTypeId,
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
        walletTypeId: null,
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

  @override
  WalletTypeUiModel? getWalletTypeById(int walletTypeId) {
    return getAllWalletType().firstWhere(
      (type) => type.id == walletTypeId,
    );
  }

  @override
  List<WalletTypeUiModel> getAllWalletType() {
    return mainRepository.getWalletTypeList();
  }
}
