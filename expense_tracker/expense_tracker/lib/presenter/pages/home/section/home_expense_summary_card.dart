import 'package:expense_tracker/data/model/ui_model/common/transaction_category_ui_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomeExpenseSummaryCard extends StatelessWidget {
  final List<TransactionCategoryUiModel> transactionCategoryModelList;
  const HomeExpenseSummaryCard({
    super.key,
    required this.transactionCategoryModelList,
  });

  final String expenseSummaryLabel = 'Expenses by Category';
  final String noExpensesMessage = 'No expenses yet';

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              expenseSummaryLabel,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 250,
              child: transactionCategoryModelList.isEmpty
                  ? Center(
                      child: Text(
                      noExpensesMessage,
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ))
                  : PieChart(
                      PieChartData(
                        sections: transactionCategoryModelList.map((expenseModel) {
                          return PieChartSectionData(
                            color: expenseModel.categoryUIModel.color,
                            value: expenseModel.categoryCostAmount,
                            title: expenseModel.categoryUIModel.name,
                            radius: 100,
                            titleStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
