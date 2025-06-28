import 'package:expense_tracker/data/model/data_model/transaction/transaction_category_data_model.dart';

class TransactionSummaryDataModel {
  final double currentBalance;
  final double totalIncome;
  final double totalExpense;
  final List<TransactionCategoryDataModel> transactionCategoryDataModel;

  TransactionSummaryDataModel({
    required this.currentBalance,
    required this.totalIncome,
    required this.totalExpense,
    required this.transactionCategoryDataModel,
  });
}
