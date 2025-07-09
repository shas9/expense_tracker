import 'package:expense_tracker/common/utilities/date_time_extension.dart';
import 'package:expense_tracker/data/model/ui_model/common/category_ui_model.dart';
import 'package:expense_tracker/data/model/ui_model/common/wallet_ui_model.dart';
import 'package:flutter/material.dart';


enum TransactionType { expense, income, transfer }

class CreateTransactionUiModel {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  CategoryUiModel? selectedCategory;
  WalletUiModel? selectedWallet;

  List<CategoryUiModel> categories = [];
  List<WalletUiModel> wallets = [];

  // Transaction type state
  TransactionType selectedTransactionType = TransactionType.expense;

  // Transfer-specific state
  WalletUiModel? selectedFromWallet;
  WalletUiModel? selectedToWallet;

  CreateTransactionUiModel();

  String formattedSelectedDate(BuildContext context) {
    return selectedDate.formatLocalizedTime(context, DatePatternType.mediumDatePattern);
  }

  void updateCategories(List<CategoryUiModel> categories) {
    this.categories = categories;
  }

  void updateWallets(List<WalletUiModel> wallets) {
    this.wallets = wallets;
  }

  void updateSelectedWallet(WalletUiModel wallet) {
    selectedWallet = wallet;
    selectedFromWallet = wallet;
  }

  void dispose() {
    titleController.dispose();
    amountController.dispose();
    descriptionController.dispose();
  }
}
