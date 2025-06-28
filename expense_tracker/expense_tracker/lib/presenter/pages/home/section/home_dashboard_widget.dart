import 'package:expense_tracker/data/model/ui_model/home_dashboard_ui_model.dart';
import 'package:expense_tracker/presenter/pages/home/section/home_expense_summary_card.dart';
import 'package:expense_tracker/presenter/pages/home/section/home_income_expense_card.dart';
import 'package:expense_tracker/presenter/pages/home/section/home_total_balance_card.dart';
import 'package:expense_tracker/presenter/pages/home/section/wallet_summary_list_widget.dart';
import 'package:flutter/material.dart';

class HomeDashboardWidget extends StatelessWidget {
  final HomeDashboardUiModel uiModel;
  const HomeDashboardWidget({
    super.key,
    required this.uiModel,
  });

  final String noWalletsMessage = 'No wallets found';

  @override
  Widget build(BuildContext context) {
    if (uiModel.walletModelList.isEmpty) {
      return Center(
        child: Text(
          noWalletsMessage,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }

    double totalBalance = uiModel.currentBalance;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeTotalBalanceCard(totalBalance: totalBalance),
            const SizedBox(height: 16),
            HomeIncomeExpenseCard(
              totalIncome: uiModel.totalIncome,
              totalExpenses: uiModel.totalExpense,
            ),
            const SizedBox(height: 16),
            WalletSummaryListWidget(walletList: uiModel.walletModelList),
            const SizedBox(height: 16),
            HomeExpenseSummaryCard(
              expenseCategoryModelList: uiModel.expenseCategoryModelList,
            ),
          ],
        ),
      ),
    );
  }
}
