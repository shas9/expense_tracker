import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomeExpenseSummaryCard extends StatelessWidget {
  final Map<String, double> summary;
  const HomeExpenseSummaryCard({
    super.key,
    required this.summary,
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
              child: summary.isEmpty
                  ? Center(
                      child: Text(
                      noExpensesMessage,
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ))
                  : PieChart(
                      PieChartData(
                        sections: summary.entries.map((entry) {
                          return PieChartSectionData(
                            color: _getCategoryColor(entry.key),
                            value: entry.value,
                            title: entry.key,
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

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return Colors.orange;
      case 'Transport':
        return Colors.blue;
      case 'Entertainment':
        return Colors.purple;
      case 'Shopping':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }
}
