import 'package:expense_tracker/data/database/realm_model.dart';
import 'package:expense_tracker/data/repositories/expense_repository.dart';
import 'package:expense_tracker/presenter/pages/wallet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
      ),
      body: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          if (state is WalletLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state is WalletsLoadedState && state.wallets.isNotEmpty) {
            return _buildDashboard(context, state.wallets.first);
          }
          
          return const Center(child: Text('No wallets found'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create wallet page
          Navigator.pushNamed(context, '/create-wallet');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, Wallet wallet) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Financial Summary', 
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 16),
            
            // Total Balance Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Balance'),
                    Text(
                      '\$${wallet.balance.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Pie Chart for Expenses
            _buildExpensePieChart(context, wallet.id.toString()),
            
            const SizedBox(height: 16),
            
            // Income vs Expense Line Chart
            _buildIncomeExpenseChart(context, wallet.id.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildExpensePieChart(BuildContext context, String walletId) {
    final expenseRepository = context.read<ExpenseRepository>();
    final categoryExpenses = expenseRepository.getExpensesByCategory(walletId);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Expenses by Category', 
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
            ),
            SizedBox(
              height: 250,
              child: categoryExpenses.isEmpty
                ? const Center(child: Text('No expenses yet'))
                : PieChart(
                    PieChartData(
                      sections: categoryExpenses.entries.map((entry) {
                        return PieChartSectionData(
                          color: _getCategoryColor(entry.key),
                          value: entry.value,
                          title: entry.key,
                          radius: 100,
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

  Widget _buildIncomeExpenseChart(BuildContext context, String walletId) {
    final expenseRepository = context.read<ExpenseRepository>();
    final summary = expenseRepository.getFinancialSummary(walletId);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Income vs Expenses', 
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
            ),
            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: summary['income'] ?? 0,
                          color: Colors.green,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: summary['expenses'] ?? 0,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(),
                    rightTitles: const AxisTitles(),
                    topTitles: const AxisTitles(),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text(
                            value == 0 ? 'Income' : 'Expenses',
                            style: const TextStyle(fontSize: 12),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    // Implement color mapping for different expense categories
    final colorMap = {
      'Food': Colors.blue,
      'Transport': Colors.green,
      'Entertainment': Colors.red,
      'Utilities': Colors.purple,
      'Shopping': Colors.orange,
    };
    return colorMap[category] ?? Colors.grey;
  }
}