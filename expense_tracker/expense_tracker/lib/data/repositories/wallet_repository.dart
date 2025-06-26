import 'package:expense_tracker/common/utilities/id_generator.dart';
import 'package:expense_tracker/data/database/realm_model.dart';
import 'package:realm/realm.dart';

abstract class WalletRepository {
  Wallet createWallet(String name, String type, double initialBalance);
  List<Wallet> getAllWallets();
  void deleteWallet(int walletId);
  void updateWalletBalance(int walletId, double amount);
  Wallet? getWalletById(int walletId);
}

class WalletRepositoryImpl extends WalletRepository {
  final Realm realm;

  WalletRepositoryImpl({
    required this.realm
  });

  // Create a new wallet
  @override
  Wallet createWallet(String name, String type, double initialBalance) {
    final wallet = Wallet(
      IdGenerator.generateId(), 
      name, 
      type, 
      initialBalance
    );
    
    realm.write(() {
      realm.add(wallet);
    });

    return wallet;
  }

  // Get all wallets
  @override
  List<Wallet> getAllWallets() {
    return realm.all<Wallet>().toList();
  }

  // Update wallet balance
  @override
  void updateWalletBalance(int walletId, double amount) {
    realm.write(() {
      final wallet = realm.find<Wallet>(walletId);
      if (wallet != null) {
        wallet.balance += amount;
      }
    });
  }

  // Delete a wallet
  @override
  void deleteWallet(int walletId) {
    realm.write(() {
      final wallet = realm.find<Wallet>(walletId);
      if (wallet != null) {
        realm.delete(wallet);
      }
    });
  }

  // Get wallet by ID as string
  @override
  Wallet? getWalletById(int walletId) {
    return realm.query<Wallet>('id == $walletId').firstOrNull;
  }
}