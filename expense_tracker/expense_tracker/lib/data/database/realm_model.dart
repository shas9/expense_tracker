import 'package:realm/realm.dart';

part 'realm_model.realm.dart';

@RealmModel()
class _Wallet {
  @PrimaryKey()
  late ObjectId id;
  late String name;
  late String type;
  late double balance;
}

@RealmModel()
class _Expense {
  @PrimaryKey()
  late ObjectId id;
  late String title;
  late double amount;
  late DateTime date;
  late String category;
  late String walletId; // Change to string to avoid query issues
  late bool isIncome;
}

@RealmModel()
class _Category {
  @PrimaryKey()
  late ObjectId id;
  late String name;
  late String icon;
}