import 'package:expense_tracker/data/database/realm_model.dart';
import 'package:expense_tracker/presenter/pages/home/section/home_expense_summary_card.dart';
import 'package:expense_tracker/presenter/pages/home/section/home_income_expense_card.dart';
import 'package:expense_tracker/presenter/pages/home/section/home_total_balance_card.dart';
import 'package:expense_tracker/presenter/pages/home/section/wallet_summary_list_widget.dart';
import 'package:flutter/material.dart';

class HomeDashboardWidget extends StatelessWidget {
  final List<Wallet> walletList;
  final Map<String, double> overallFinancialSummary;
  const HomeDashboardWidget({
    super.key,
    required this.walletList,
    required this.overallFinancialSummary,
  });

  final String noWalletsMessage = 'No wallets found';

  @override
  Widget build(BuildContext context) {
    if (walletList.isEmpty) {
      return Center(
        child: Text(
          noWalletsMessage,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }

    double totalBalance = walletList.fold(
      0,
      (sum, wallet) => sum + wallet.balance,
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeTotalBalanceCard(totalBalance: totalBalance),
            const SizedBox(height: 16),
            HomeIncomeExpenseCard(
              totalIncome: overallFinancialSummary['totalIncome'] ?? 0.0,
              totalExpenses: overallFinancialSummary['totalExpenses'] ?? 0.0,
            ),
            const SizedBox(height: 16),
            WalletSummaryListWidget(walletList: walletList),
            const SizedBox(height: 16),
            HomeExpenseSummaryCard(summary: overallFinancialSummary),
          ],
        ),
      ),
    );
  }
}
