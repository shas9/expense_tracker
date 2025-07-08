import 'package:realm/realm.dart';

part 'realm_model.realm.dart';

@RealmModel()
class _WalletEntity {
  @PrimaryKey()
  late int id;
  late String name;
  late int walletTypeId; 
  late String colorCode;
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
  late int categoryId;
  late int walletId;
  late bool isIncome;
}

@RealmModel()
class _CategoryEntity {
  @PrimaryKey()
  late int id;
  late String name;
  late String icon;
  late bool isExpenseCategory;
  late String colorCode;
}

