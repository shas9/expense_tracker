import 'package:expense_tracker/data/model/ui_model/common/transaction_category_ui_model.dart';
import 'package:expense_tracker/data/model/ui_model/common/wallet_ui_model.dart';

class HomeDashboardUiModel {
  final double currentBalance;
  final double totalIncome;
  final double totalExpense;
  final List<WalletUiModel> walletModelList;
  final List<TransactionCategoryUiModel> transactionCategoryModelList;

  HomeDashboardUiModel({
    required this.currentBalance,
    required this.totalIncome,
    required this.totalExpense,
    required this.walletModelList,
    required this.transactionCategoryModelList,
  });

  HomeDashboardUiModel.empty()
      : currentBalance = 0.0,
        totalIncome = 0.0,
        totalExpense = 0.0,
        walletModelList = const [],
        transactionCategoryModelList = const [];
}
