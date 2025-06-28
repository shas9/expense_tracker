class WalletSummaryDataModel {
  final int walletId;
  final double currentBalance;
  final double totalIncome;
  final double totalExpense;

  WalletSummaryDataModel({
    required this.walletId,
    required this.currentBalance,
    required this.totalIncome,
    required this.totalExpense,
  });
}
