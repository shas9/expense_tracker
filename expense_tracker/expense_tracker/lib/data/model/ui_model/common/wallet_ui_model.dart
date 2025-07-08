import 'dart:ui';

import 'package:expense_tracker/common/utilities/parser.dart';
import 'package:expense_tracker/data/database/realm_model.dart';
import 'package:expense_tracker/data/model/ui_model/common/wallet_type_ui_model.dart';
import 'package:expense_tracker/data/repositories/data_repositoy.dart/wallet_repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kiwi/kiwi.dart';

class WalletUiModel {
  final int id;
  final String name;
  final WalletTypeUiModel walletTypeModel;
  final double balance;
  final Color color;

  WalletUiModel({
    required this.id,
    required this.name,
    required this.walletTypeModel,
    required this.balance,
    required this.color,
  });

  factory WalletUiModel.fromEntity(WalletEntity walletEntity) {
    final WalletRepository walletRepository = KiwiContainer().resolve<WalletRepository>();
    final walletTypeModel = walletRepository.getWalletTypeById(walletEntity.walletTypeId);
    return WalletUiModel(
      id: walletEntity.id,
      name: walletEntity.name,
      walletTypeModel: walletTypeModel ??
          WalletTypeUiModel(
            id: 0,
            name: 'Unknown',
            icon: FontAwesomeIcons.question,
            color: Colors.grey, // Default color for unknown type
          ),
      balance: walletEntity.balance,
      color: Parser.hexStringToColor(walletEntity.colorCode),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WalletUiModel) return false;
    return id == other.id &&
        name == other.name &&
        walletTypeModel.id == other.walletTypeModel.id &&
        balance == other.balance &&
        color == other.color;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        walletTypeModel.id.hashCode ^
        balance.hashCode ^
        color.hashCode;
  }
}
