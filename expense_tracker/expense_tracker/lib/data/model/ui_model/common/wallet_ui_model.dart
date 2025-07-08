import 'dart:ui';

import 'package:expense_tracker/common/utilities/parser.dart';
import 'package:expense_tracker/data/database/realm_model.dart';

class WalletUiModel {
  final int id;
  final String name;
  final String type;
  final double balance;
  final Color color;

  WalletUiModel({
    required this.id,
    required this.name,
    required this.type,
    required this.balance,
    required this.color,
  });

  factory WalletUiModel.fromEntity(WalletEntity walletEntity) {
    return WalletUiModel(
      id: walletEntity.id,
      name: walletEntity.name,
      type: walletEntity.type,
      balance: walletEntity.balance,
      color: Parser.hexStringToColor(walletEntity.colorCode),
    );
  }
}
