import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomeIncomeExpenseCard extends StatelessWidget {
  final double totalIncome;
  final double totalExpenses;
  const HomeIncomeExpenseCard({
    super.key,
    required this.totalIncome,
    required this.totalExpenses,
  });

  final String incomeExpenseLabel = 'Income vs Expenses';

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
              incomeExpenseLabel,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [
                      BarChartRodData(
                        toY: totalIncome,
                        color: Colors.greenAccent,
                      )
                    ]),
                    BarChartGroupData(x: 1, barRods: [
                      BarChartRodData(
                        toY: totalExpenses,
                        color: Colors.redAccent,
                      )
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
