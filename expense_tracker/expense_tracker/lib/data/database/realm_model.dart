import 'package:realm/realm.dart';

part 'realm_model.realm.dart';

@RealmModel()
class _WalletEntity {
  @PrimaryKey()
  late int id;
  late String name;
  late String type;
  late double balance;
}

@RealmModel()
class _TransactionEntity {
  @PrimaryKey()
  late int id;
  late String title;
  late double amount;
  late String description;
  late DateTime date;
  late String category;
  late int walletId; // Change to string to avoid query issues
  late bool isIncome;
}

@RealmModel()
class _CategoryEntity {
  @PrimaryKey()
  late int id;
  late String name;
  late String icon;
}

