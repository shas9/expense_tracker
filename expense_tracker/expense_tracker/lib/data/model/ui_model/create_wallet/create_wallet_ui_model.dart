import 'package:expense_tracker/data/model/ui_model/common/wallet_type_ui_model.dart';
import 'package:flutter/material.dart';

class CreateWalletUiModel {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final balanceController = TextEditingController();
  WalletTypeUiModel? selectedWalletType;
  List<WalletTypeUiModel> walletTypes = [];

  CreateWalletUiModel();
}