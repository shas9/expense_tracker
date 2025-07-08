import 'package:flutter/material.dart';

class CreateWalletUiModel {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final balanceController = TextEditingController();
  String selectedWalletType = '';
  List<String> walletTypes = [];

  CreateWalletUiModel();
}